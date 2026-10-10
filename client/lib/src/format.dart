import 'package:intl/intl.dart';

import 'models.dart';

final _money = NumberFormat.decimalPattern('ru');

String formatMoney(int amount) => '${_money.format(amount)} ₸';

String formatTime(ZonedDateTime t) => DateFormat.Hm('ru').format(t.wall);

String formatTimeRange(Trip trip) =>
    '${formatTime(trip.start)} – ${formatTime(trip.end)}${trip.endsNextDay ? ' (+1 день)' : ''}';

String formatDuration(Duration d) {
  final hours = d.inHours;
  final minutes = d.inMinutes % 60;
  if (hours == 0) return '$minutes мин';
  return minutes == 0 ? '$hours ч' : '$hours ч $minutes мин';
}

/// «10 октября», с годом — если год не текущий.
String formatDay(DateTime day, {required DateTime today}) =>
    DateFormat(day.year == today.year ? 'd MMMM' : 'd MMMM y', 'ru').format(day);

/// «Сегодня», «Вчера», «Завтра» или день недели.
String formatRelativeDay(DateTime day, {required DateTime today}) {
  final diff = day.difference(today).inDays;
  return switch (diff) {
    0 => 'Сегодня',
    -1 => 'Вчера',
    1 => 'Завтра',
    _ => toBeginningOfSentenceCase(DateFormat.EEEE('ru').format(day)),
  };
}

String pluralTrips(int n) {
  final mod10 = n % 10, mod100 = n % 100;
  if (mod10 == 1 && mod100 != 11) return '$n поездка';
  if (mod10 >= 2 && mod10 <= 4 && (mod100 < 12 || mod100 > 14)) return '$n поездки';
  return '$n поездок';
}
