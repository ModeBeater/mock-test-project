import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/time/zoned_date_time.dart';
import '../../../../shared/domain/payment_method.dart';

part 'trip_draft.freezed.dart';

enum TripDraftError { amountMissing, amountNotPositive, commissionMissing, commissionExceedsAmount, endNotAfterStart, tooLong }

/// Поездка, которую водитель заполняет в форме. Время — минуты от полуночи по часам водителя.
@freezed
abstract class TripDraft with _$TripDraft {
  const TripDraft._();

  const factory TripDraft({
    /// Ключ идемпотентности: создаётся вместе с черновиком и не меняется при повторной отправке.
    required String id,
    required DateTime day,
    required int startMinute,
    required int endMinute,
    required Duration utcOffset,
    int? amount,
    int? commission,
    @Default(PaymentMethod.card) PaymentMethod payment,
  }) = _TripDraft;

  /// Комиссия по умолчанию — как в исходных данных.
  static const commissionRate = 0.15;

  /// Защита от опечатки: «окончание раньше начала» иначе превращается в поездку почти на сутки.
  static const maxDuration = Duration(hours: 12);

  static int suggestedCommission(int amount) => (amount * commissionRate).round();

  /// Окончание раньше начала по часам — значит, поездка закончилась после полуночи.
  bool get endsNextDay => endMinute < startMinute;

  ZonedDateTime get start => ZonedDateTime.fromWall(day.add(Duration(minutes: startMinute)), utcOffset);

  ZonedDateTime get end =>
      ZonedDateTime.fromWall(day.add(Duration(days: endsNextDay ? 1 : 0, minutes: endMinute)), utcOffset);

  Duration get duration => end.instant.difference(start.instant);

  Set<TripDraftError> validate() => {
        if (amount == null) TripDraftError.amountMissing else if (amount! <= 0) TripDraftError.amountNotPositive,
        if (commission == null)
          TripDraftError.commissionMissing
        else if (amount != null && commission! > amount!)
          TripDraftError.commissionExceedsAmount,
        if (duration <= Duration.zero) TripDraftError.endNotAfterStart,
        if (duration > maxDuration) TripDraftError.tooLong,
      };
}

/// Время по умолчанию для новой поездки.
///
/// Сегодня поездку обычно записывают сразу после неё: окончание — сейчас, начало — 20 минут назад.
/// В другой день — сразу после последней поездки этого дня (или с 9:00).
({int start, int end}) suggestTripTime({required bool isToday, required DateTime now, int? previousTripEndMinute}) {
  const typicalTrip = 20;
  const day = 24 * 60;
  if (isToday) {
    final end = now.hour * 60 + now.minute;
    return (start: (end - typicalTrip) % day, end: end);
  }
  final start = previousTripEndMinute ?? 9 * 60;
  return (start: start, end: (start + typicalTrip) % day);
}
