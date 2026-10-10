import 'package:driver_diary/src/format.dart';
import 'package:driver_diary/src/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'fixtures.dart';

void main() {
  setUpAll(() => initializeDateFormatting('ru'));

  group('ZonedDateTime', () {
    test('показывает время водителя, а не устройства', () {
      final t = ZonedDateTime.parse('2026-10-01T23:50:00+05:00');

      expect(t.instant, DateTime.utc(2026, 10, 1, 18, 50));
      expect(t.wall, DateTime.utc(2026, 10, 1, 23, 50));
      expect(formatTime(t), '23:50');
    });

    test('сериализуется обратно с тем же смещением', () {
      const iso = '2026-10-01T08:10:00+05:00';
      expect(ZonedDateTime.parse(iso).toIso8601(), iso);
      expect(ZonedDateTime.parse('2026-10-01T03:10:00Z').toIso8601(), '2026-10-01T03:10:00+00:00');
      expect(ZonedDateTime.parse('2026-10-01T03:10:00-03:30').offset, const Duration(hours: -3, minutes: -30));
    });

    test('без смещения — ошибка', () {
      expect(() => ZonedDateTime.parse('2026-10-01T08:10:00'), throwsFormatException);
    });
  });

  test('DayReport.fromJson', () {
    final report = DayReport.fromJson(exampleDay);

    expect(report.date, DateTime.utc(2026, 10, 1));
    expect(report.utcOffset, const Duration(hours: 5));
    expect(report.summary.net, 3315);
    expect(report.summary.byPayment[PaymentMethod.cash]!.amount, 1500);
    expect(report.trips.map((t) => t.id), ['t1', 't2']);
    expect(report.trips.first.duration, const Duration(minutes: 22));
    expect(report.trips.first.payment, PaymentMethod.card);
  });

  test('поездка через полночь', () {
    final t = Trip.fromJson(trip('n', '2026-10-08T23:41:00+05:00', '2026-10-09T00:12:00+05:00', 3800, 'card', 570));

    expect(t.endsNextDay, isTrue);
    expect(formatTimeRange(t), '23:41 – 00:12 (+1 день)');
  });

  test('NewTrip.toJson', () {
    const offset = Duration(hours: 5);
    final json = NewTrip(
      id: 'abc',
      start: ZonedDateTime(DateTime.utc(2026, 10, 1, 18, 50), offset),
      end: ZonedDateTime(DateTime.utc(2026, 10, 1, 19, 20), offset),
      amount: 2000,
      payment: PaymentMethod.cash,
      commission: 300,
    ).toJson();

    expect(json, {
      'id': 'abc',
      'start': '2026-10-01T23:50:00+05:00',
      'end': '2026-10-02T00:20:00+05:00',
      'amount': 2000,
      'payment': 'cash',
      'commission': 300,
    });
  });

  test('форматирование', () {
    expect(formatMoney(3315), '3 315 ₸');
    expect(formatDuration(const Duration(minutes: 22)), '22 мин');
    expect(formatDuration(const Duration(minutes: 75)), '1 ч 15 мин');
    expect([1, 2, 5, 11, 21, 22, 112].map(pluralTrips),
        ['1 поездка', '2 поездки', '5 поездок', '11 поездок', '21 поездка', '22 поездки', '112 поездок']);
  });
}
