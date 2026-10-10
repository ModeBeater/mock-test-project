import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:driver_diary/core/error/failure.dart';
import 'package:driver_diary/core/error/result.dart';
import 'package:driver_diary/core/time/clock.dart';
import 'package:driver_diary/core/time/zoned_date_time.dart';
import 'package:driver_diary/features/diary/domain/entities/day_report.dart';
import 'package:driver_diary/features/diary/domain/entities/day_summary.dart';
import 'package:driver_diary/features/diary/domain/entities/work_day.dart';
import 'package:driver_diary/features/diary/domain/repositories/diary_repository.dart';
import 'package:driver_diary/features/diary/domain/usecases/get_day_report.dart';
import 'package:driver_diary/features/diary/domain/usecases/get_work_days.dart';
import 'package:driver_diary/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:driver_diary/shared/domain/payment_method.dart';
import 'package:driver_diary/shared/domain/trip.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepository extends Mock implements DiaryRepository {}

DayReport report(DateTime day) => DayReport(
      date: day,
      utcOffset: const Duration(hours: 5),
      summary: const DaySummary(tripsCount: 0, revenue: 0, commission: 0, net: 0, byPayment: {}),
      trips: const [],
    );

void main() {
  final oct1 = DateTime.utc(2026, 10, 1);
  final oct2 = DateTime.utc(2026, 10, 2);
  final oct3 = DateTime.utc(2026, 10, 3);
  final workDays = [WorkDay(date: oct1, tripsCount: 2, net: 3315)];
  late _MockRepository repository;

  setUpAll(() => registerFallbackValue(DateTime(2000)));

  setUp(() {
    repository = _MockRepository();
    when(() => repository.getDayReport(any())).thenAnswer((i) async => Ok(report(i.positionalArguments.first as DateTime)));
    when(() => repository.getWorkDays()).thenAnswer((_) async => Ok(workDays));
  });

  DiaryBloc build() => DiaryBloc(
        getDayReport: GetDayReport(repository),
        getWorkDays: GetWorkDays(repository),
        clock: Clock(() => DateTime(2026, 10, 1, 12)),
      );

  blocTest<DiaryBloc, DiaryState>(
    'started: грузит сегодняшний день и рабочие дни',
    build: build,
    act: (bloc) => bloc.add(const DiaryEvent.started()),
    expect: () => [
      DiaryState(today: oct1, selectedDay: oct1),
      DiaryState(
        today: oct1,
        selectedDay: oct1,
        status: DiaryStatus.ready,
        report: report(oct1),
        workDays: workDays,
        utcOffset: const Duration(hours: 5),
      ),
    ],
  );

  blocTest<DiaryBloc, DiaryState>(
    'переключение дня не перезапрашивает рабочие дни',
    build: build,
    act: (bloc) async {
      bloc.add(const DiaryEvent.started());
      await Future<void>.delayed(Duration.zero);
      bloc.add(const DiaryEvent.dayShifted(1));
    },
    verify: (bloc) {
      expect(bloc.state.selectedDay, oct2);
      expect(bloc.state.report?.date, oct2);
      verify(() => repository.getWorkDays()).called(1);
    },
  );

  blocTest<DiaryBloc, DiaryState>(
    'ответ на устаревший запрос не перетирает выбранный день',
    setUp: () {
      final slow = Completer<Result<DayReport>>();
      when(() => repository.getDayReport(oct2)).thenAnswer((_) => slow.future);
      // Медленный ответ для 2 октября придёт уже после выбора 3 октября.
      Future<void>.delayed(const Duration(milliseconds: 20), () => slow.complete(Ok(report(oct2))));
    },
    build: build,
    act: (bloc) async {
      bloc.add(DiaryEvent.daySelected(oct2));
      await Future<void>.delayed(Duration.zero);
      bloc.add(DiaryEvent.daySelected(oct3));
      await Future<void>.delayed(const Duration(milliseconds: 40));
    },
    verify: (bloc) {
      expect(bloc.state.selectedDay, oct3);
      expect(bloc.state.report?.date, oct3);
    },
  );

  blocTest<DiaryBloc, DiaryState>(
    'ошибка загрузки',
    setUp: () => when(() => repository.getDayReport(any())).thenAnswer((_) async => const Err(Failure.noConnection())),
    build: build,
    act: (bloc) => bloc.add(const DiaryEvent.started()),
    skip: 1,
    expect: () => [
      DiaryState(today: oct1, selectedDay: oct1, status: DiaryStatus.failure, failure: const Failure.noConnection()),
    ],
  );

  blocTest<DiaryBloc, DiaryState>(
    'после сохранения поездки показывает её день и обновляет неделю',
    build: build,
    act: (bloc) => bloc.add(DiaryEvent.tripSaved(Trip(
      id: 'x',
      start: ZonedDateTime.parse('2026-10-03T23:50:00+05:00'),
      end: ZonedDateTime.parse('2026-10-04T00:20:00+05:00'),
      amount: 2000,
      payment: PaymentMethod.cash,
      commission: 300,
    ))),
    verify: (bloc) {
      expect(bloc.state.selectedDay, oct3, reason: 'поездка через полночь относится к дню начала');
      verify(() => repository.getWorkDays()).called(1);
    },
  );

  blocTest<DiaryBloc, DiaryState>(
    'неделя назад — та же дата неделей раньше',
    build: build,
    act: (bloc) => bloc.add(const DiaryEvent.dayShifted(-7)),
    verify: (bloc) => expect(bloc.state.selectedDay, DateTime.utc(2026, 9, 24)),
  );
}
