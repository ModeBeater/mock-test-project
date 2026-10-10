part of 'trip_entry_bloc.dart';

enum TripEntryStatus { editing, submitting, done }

@freezed
abstract class TripEntryState with _$TripEntryState {
  const TripEntryState._();

  const factory TripEntryState({
    required TripDraft draft,
    @Default(TripEntryStatus.editing) TripEntryStatus status,

    /// Водитель сам изменил комиссию — больше не подставляем 15%.
    @Default(false) bool commissionEdited,

    /// После первой попытки сохранить показываем и ошибки незаполненных полей.
    @Default(false) bool showAllErrors,

    /// created или alreadySaved — когда status == done.
    TripEntryOutcome? outcome,
    TripConflict? conflict,
    Failure? failure,
  }) = _TripEntryState;

  /// Ошибки времени видны сразу (время выбирают, а не печатают), остальные — после «Сохранить».
  Set<TripDraftError> get visibleErrors {
    final errors = draft.validate();
    if (showAllErrors) return errors;
    return errors.intersection(const {TripDraftError.endNotAfterStart, TripDraftError.tooLong});
  }
}
