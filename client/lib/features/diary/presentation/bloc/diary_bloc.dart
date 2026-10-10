import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../../core/time/calendar.dart';
import '../../../../core/time/clock.dart';
import '../../../../shared/domain/trip.dart';
import '../../domain/entities/day_report.dart';
import '../../domain/entities/work_day.dart';
import '../../domain/usecases/get_day_report.dart';
import '../../domain/usecases/get_work_days.dart';

part 'diary_bloc.freezed.dart';
part 'diary_event.dart';
part 'diary_state.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  DiaryBloc({
    required GetDayReport getDayReport,
    required GetWorkDays getWorkDays,
    Clock clock = const Clock(),
  })  : _getDayReport = getDayReport,
        _getWorkDays = getWorkDays,
        super(DiaryState(today: dateOnly(clock.now()), selectedDay: dateOnly(clock.now()))) {
    // Все события ведут к загрузке дня. restartable: новое событие отменяет незавершённую
    // загрузку, поэтому при быстром листании дней старый ответ не перетрёт новый.
    on<DiaryEvent>(_onEvent, transformer: restartable());
  }

  final GetDayReport _getDayReport;
  final GetWorkDays _getWorkDays;

  Future<void> _onEvent(DiaryEvent event, Emitter<DiaryState> emit) async {
    final day = switch (event) {
      DiaryStarted() || DiaryRefreshed() => state.selectedDay,
      DiaryDaySelected(:final day) => dateOnly(day),
      DiaryDayShifted(:final days) => state.selectedDay.add(Duration(days: days)),
      DiaryTripSaved(:final trip) => trip.localDate,
    };
    // Список рабочих дней меняется только после добавления поездки; листание его не трогает.
    final reloadWorkDays = event is DiaryStarted || event is DiaryRefreshed || event is DiaryTripSaved;

    emit(state.copyWith(
      selectedDay: day,
      report: state.report?.date == day ? state.report : null,
      status: DiaryStatus.loading,
      failure: null,
    ));

    final (report, workDays) = await (
      _getDayReport(day),
      reloadWorkDays ? _getWorkDays() : Future.value(Ok(state.workDays)),
    ).wait;

    emit(switch (report) {
      Ok(:final value) => state.copyWith(
          report: value,
          utcOffset: value.utcOffset,
          status: DiaryStatus.ready,
          workDays: workDays is Ok<List<WorkDay>> ? workDays.value : state.workDays,
        ),
      Err(:final failure) => state.copyWith(status: DiaryStatus.failure, failure: failure),
    });
  }
}
