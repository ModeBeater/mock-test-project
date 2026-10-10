part of 'diary_bloc.dart';

@freezed
sealed class DiaryEvent with _$DiaryEvent {
  const factory DiaryEvent.started() = DiaryStarted;
  const factory DiaryEvent.refreshed() = DiaryRefreshed;
  const factory DiaryEvent.daySelected(DateTime day) = DiaryDaySelected;

  /// Сдвиг выбранного дня: ±1 — соседний день, ±7 — та же дата соседней недели.
  const factory DiaryEvent.dayShifted(int days) = DiaryDayShifted;

  /// Поездка сохранена — показываем её день и обновляем неделю.
  const factory DiaryEvent.tripSaved(Trip trip) = DiaryTripSaved;
}
