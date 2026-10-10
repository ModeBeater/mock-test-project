part of 'diary_bloc.dart';

enum DiaryStatus { loading, ready, failure }

@freezed
abstract class DiaryState with _$DiaryState {
  const DiaryState._();

  const factory DiaryState({
    required DateTime today,
    required DateTime selectedDay,
    @Default(DiaryStatus.loading) DiaryStatus status,

    /// Отчёт за [selectedDay]; null, пока день грузится впервые.
    DayReport? report,
    Failure? failure,
    @Default(<WorkDay>[]) List<WorkDay> workDays,

    /// Часовой пояс водителя, известен после первого ответа сервера.
    Duration? utcOffset,
  }) = _DiaryState;

  List<DateTime> get week => weekOf(selectedDay);

  bool get isCurrentWeek => weekStartOf(selectedDay) == weekStartOf(today);

  WorkDay? workDayOf(DateTime day) {
    for (final d in workDays) {
      if (d.date == day) return d;
    }
    return null;
  }

  /// Последний рабочий день не позже сегодняшнего — куда вести с пустого дня.
  DateTime? get lastWorkDay {
    for (final d in workDays.reversed) {
      if (!d.date.isAfter(today)) return d.date;
    }
    return null;
  }
}
