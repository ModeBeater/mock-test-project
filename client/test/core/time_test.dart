import 'package:driver_diary/core/format/formatters.dart';
import 'package:driver_diary/core/time/calendar.dart';
import 'package:driver_diary/core/time/zoned_date_time.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(() => initializeDateFormatting('ru'));

  group('ZonedDateTime', () {
    test('показывает время водителя, а не устройства', () {
      final t = ZonedDateTime.parse('2026-10-01T23:50:00+05:00');

      expect(t.instant, DateTime.utc(2026, 10, 1, 18, 50));
      expect(t.wall, DateTime.utc(2026, 10, 1, 23, 50));
      expect(t.localDate, DateTime.utc(2026, 10, 1));
      expect(formatTime(t), '23:50');
    });

    test('сериализуется обратно с тем же смещением', () {
      const iso = '2026-10-01T08:10:00+05:00';

      expect(ZonedDateTime.parse(iso).toIso8601(), iso);
      expect(ZonedDateTime.parse('2026-10-01T03:10:00Z').toIso8601(), '2026-10-01T03:10:00+00:00');
      expect(ZonedDateTime.parse('2026-10-01T03:10:00-03:30').offset, const Duration(hours: -3, minutes: -30));
    });

    test('fromWall: часы водителя → момент времени', () {
      final t = ZonedDateTime.fromWall(DateTime.utc(2026, 10, 1, 8, 10), const Duration(hours: 5));

      expect(t.instant, DateTime.utc(2026, 10, 1, 3, 10));
      expect(t, ZonedDateTime.parse('2026-10-01T08:10:00+05:00'));
    });

    test('без смещения — ошибка', () {
      expect(() => ZonedDateTime.parse('2026-10-01T08:10:00'), throwsFormatException);
    });
  });

  test('неделя начинается с понедельника', () {
    final week = weekOf(DateTime.utc(2026, 10, 1)); // четверг

    expect(week.first, DateTime.utc(2026, 9, 28));
    expect(week.last, DateTime.utc(2026, 10, 4));
  });

  test('форматирование', () {
    final today = DateTime.utc(2026, 10, 10);

    expect(formatMoney(3315), '3 315 ₸');
    expect(formatDuration(const Duration(minutes: 22)), '22 мин');
    expect(formatDuration(const Duration(minutes: 75)), '1 ч 15 мин');
    expect(formatDayTitle(DateTime.utc(2026, 10, 1), today: today), 'Четверг, 1 октября');
    expect(formatWeekRange(DateTime.utc(2026, 10, 5), DateTime.utc(2026, 10, 11), today: today), '5 – 11 октября');
    expect(formatWeekRange(DateTime.utc(2026, 9, 28), DateTime.utc(2026, 10, 4), today: today), '28 сентября – 4 октября');
    expect([1, 2, 5, 11, 21, 22, 112].map(pluralTrips),
        ['1 поездка', '2 поездки', '5 поездок', '11 поездок', '21 поездка', '22 поездки', '112 поездок']);
  });
}
