import 'package:intl/intl.dart';

import '../time/zoned_date_time.dart';

final _money = NumberFormat.decimalPattern('ru');

/// `3 315 ₸` — с неразрывными пробелами, чтобы сумма не переносилась.
String formatMoney(int amount) => '${_money.format(amount)} ₸';

/// Без знака валюты — для второстепенных сумм рядом с основной.
String formatAmount(int amount) => _money.format(amount);

String formatTime(ZonedDateTime t) => DateFormat.Hm('ru').format(t.wall);

String formatDuration(Duration d) {
  final hours = d.inHours;
  final minutes = d.inMinutes % 60;
  if (hours == 0) return '$minutes мин';
  return minutes == 0 ? '$hours ч' : '$hours ч $minutes мин';
}

/// «1 октября», с годом — если год не текущий.
String formatDayMonth(DateTime day, {required DateTime today}) =>
    DateFormat(day.year == today.year ? 'd MMMM' : 'd MMMM y', 'ru').format(day);

/// «Четверг, 1 октября».
String formatDayTitle(DateTime day, {required DateTime today}) =>
    '${_capitalize(DateFormat.EEEE('ru').format(day))}, ${formatDayMonth(day, today: today)}';

/// «5 – 11 октября», «29 сентября – 5 октября».
String formatWeekRange(DateTime start, DateTime end, {required DateTime today}) {
  final sameMonth = start.month == end.month && start.year == end.year;
  final first = sameMonth ? '${start.day}' : formatDayMonth(start, today: end);
  return '$first – ${formatDayMonth(end, today: today)}';
}

/// «пн», «вт»…
String formatWeekdayShort(DateTime day) => DateFormat.E('ru').format(day).replaceAll('.', '').toLowerCase();

String pluralTrips(int n) => _plural(n, 'поездка', 'поездки', 'поездок');

String _plural(int n, String one, String few, String many) {
  final mod10 = n % 10, mod100 = n % 100;
  if (mod10 == 1 && mod100 != 11) return '$n $one';
  if (mod10 >= 2 && mod10 <= 4 && (mod100 < 12 || mod100 > 14)) return '$n $few';
  return '$n $many';
}

String _capitalize(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
