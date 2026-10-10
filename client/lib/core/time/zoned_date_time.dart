import 'calendar.dart';

/// Момент времени и смещение, в котором его нужно показывать.
///
/// `DateTime` в Dart бывает только UTC или локальным временем устройства,
/// а время поездок показываем по часовому поясу водителя — он может не совпадать
/// с поясом телефона или браузера.
final class ZonedDateTime implements Comparable<ZonedDateTime> {
  ZonedDateTime(DateTime instant, this.offset) : instant = instant.toUtc();

  /// [wall] — время «на часах» водителя (UTC-значение со сдвинутыми полями).
  factory ZonedDateTime.fromWall(DateTime wall, Duration offset) =>
      ZonedDateTime(DateTime.utc(wall.year, wall.month, wall.day, wall.hour, wall.minute, wall.second).subtract(offset), offset);

  factory ZonedDateTime.parse(String value) {
    final match = RegExp(r'(Z|[+-]\d{2}:\d{2})$').firstMatch(value);
    if (match == null) throw FormatException('Timestamp without UTC offset', value);
    return ZonedDateTime(DateTime.parse(value), parseUtcOffset(match[1]!));
  }

  final DateTime instant;
  final Duration offset;

  /// Время «на часах» водителя. Форматировать как есть, не переводя в локальное время устройства.
  DateTime get wall => instant.add(offset);

  DateTime get localDate => dateOnly(wall);

  /// ISO 8601 со смещением, например `2026-10-01T08:10:00+05:00`.
  String toIso8601() {
    final w = wall;
    String two(int n) => n.toString().padLeft(2, '0');
    return '${formatIsoDate(w)}T${two(w.hour)}:${two(w.minute)}:${two(w.second)}${formatUtcOffset(offset)}';
  }

  @override
  int compareTo(ZonedDateTime other) => instant.compareTo(other.instant);

  @override
  bool operator ==(Object other) => other is ZonedDateTime && other.instant == instant && other.offset == offset;

  @override
  int get hashCode => Object.hash(instant, offset);

  @override
  String toString() => toIso8601();
}
