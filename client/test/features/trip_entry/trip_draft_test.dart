import 'package:driver_diary/features/trip_entry/domain/entities/trip_draft.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TripDraft draft({int start = 10 * 60, int end = 10 * 60 + 25, int? amount = 2000, int? commission = 300}) => TripDraft(
        id: 'd1',
        day: DateTime.utc(2026, 10, 1),
        startMinute: start,
        endMinute: end,
        utcOffset: const Duration(hours: 5),
        amount: amount,
        commission: commission,
      );

  test('время в часовом поясе водителя', () {
    final d = draft();

    expect(d.start.toIso8601(), '2026-10-01T10:00:00+05:00');
    expect(d.end.toIso8601(), '2026-10-01T10:25:00+05:00');
    expect(d.duration, const Duration(minutes: 25));
    expect(d.validate(), isEmpty);
  });

  test('окончание раньше начала — поездка через полночь', () {
    final d = draft(start: 23 * 60 + 50, end: 20);

    expect(d.endsNextDay, isTrue);
    expect(d.end.toIso8601(), '2026-10-02T00:20:00+05:00');
    expect(d.duration, const Duration(minutes: 30));
    expect(d.validate(), isEmpty);
  });

  test('ошибки', () {
    expect(draft(amount: null, commission: null).validate(),
        {TripDraftError.amountMissing, TripDraftError.commissionMissing});
    expect(draft(amount: 0, commission: 0).validate(), {TripDraftError.amountNotPositive});
    expect(draft(commission: 2001).validate(), {TripDraftError.commissionExceedsAmount});
    expect(draft(end: 10 * 60).validate(), {TripDraftError.endNotAfterStart});
    // 10:00 → 09:00 читается как поездка через полночь на 23 часа — это опечатка.
    expect(draft(end: 9 * 60).validate(), {TripDraftError.tooLong});
  });

  test('комиссия по умолчанию — 15%', () {
    expect(TripDraft.suggestedCommission(2400), 360);
    expect(TripDraft.suggestedCommission(1010), 152);
  });

  test('время по умолчанию', () {
    final now = DateTime(2026, 10, 1, 0, 10);

    expect(suggestTripTime(isToday: true, now: now), (start: 23 * 60 + 50, end: 10));
    expect(suggestTripTime(isToday: false, now: now), (start: 9 * 60, end: 9 * 60 + 20));
    expect(suggestTripTime(isToday: false, now: now, previousTripEndMinute: 18 * 60), (start: 18 * 60, end: 18 * 60 + 20));
  });
}
