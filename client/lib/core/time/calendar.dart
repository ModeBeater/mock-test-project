/// Календарные даты без времени храним как полночь UTC: прибавление дней не ломается на переходе на летнее время.
DateTime dateOnly(DateTime d) => DateTime.utc(d.year, d.month, d.day);

/// Понедельник недели, в которую входит [day].
DateTime weekStartOf(DateTime day) {
  final date = dateOnly(day);
  return date.subtract(Duration(days: date.weekday - DateTime.monday));
}

List<DateTime> weekOf(DateTime day) {
  final start = weekStartOf(day);
  return [for (var i = 0; i < 7; i++) start.add(Duration(days: i))];
}

String formatIsoDate(DateTime d) => '${d.year.toString().padLeft(4, '0')}-${_two(d.month)}-${_two(d.day)}';

Duration parseUtcOffset(String value) {
  if (value == 'Z') return Duration.zero;
  final match = RegExp(r'^([+-])(\d{2}):(\d{2})$').firstMatch(value);
  if (match == null) throw FormatException('Bad UTC offset', value);
  final offset = Duration(hours: int.parse(match[2]!), minutes: int.parse(match[3]!));
  return match[1] == '-' ? -offset : offset;
}

String formatUtcOffset(Duration offset) {
  final sign = offset.isNegative ? '-' : '+';
  final minutes = offset.inMinutes.abs();
  return '$sign${_two(minutes ~/ 60)}:${_two(minutes % 60)}';
}

String _two(int n) => n.toString().padLeft(2, '0');
