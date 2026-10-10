/// Модели API. Суммы — целые тенге.
library;

enum PaymentMethod {
  cash('Наличные'),
  card('Карта');

  const PaymentMethod(this.label);
  final String label;

  static PaymentMethod fromJson(String value) => PaymentMethod.values.byName(value);
}

/// Дата без времени. Храним как полночь UTC, чтобы прибавление дней не ломалось на переходе на летнее время.
DateTime dateOnly(DateTime d) => DateTime.utc(d.year, d.month, d.day);

String formatIsoDate(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-${_two(d.month)}-${_two(d.day)}';

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

/// Момент времени и смещение, с которым его прислал сервер.
///
/// `DateTime` в Dart умеет быть только UTC или локальным временем устройства,
/// а показывать время нужно в часовом поясе водителя — он может не совпадать
/// с поясом телефона или браузера.
class ZonedDateTime {
  ZonedDateTime(DateTime instant, this.offset) : instant = instant.toUtc();

  factory ZonedDateTime.parse(String value) {
    final match = RegExp(r'(Z|[+-]\d{2}:\d{2})$').firstMatch(value);
    if (match == null) throw FormatException('Timestamp without UTC offset', value);
    return ZonedDateTime(DateTime.parse(value), parseUtcOffset(match[1]!));
  }

  final DateTime instant;
  final Duration offset;

  /// Время «на часах» водителя. Это UTC-значение со сдвинутыми полями:
  /// форматировать как есть, не переводя в локальное время.
  DateTime get wall => instant.add(offset);

  /// ISO 8601 со смещением, например `2026-10-01T08:10:00+05:00`.
  String toIso8601() {
    final w = wall;
    return '${formatIsoDate(w)}T${_two(w.hour)}:${_two(w.minute)}:${_two(w.second)}${formatUtcOffset(offset)}';
  }
}

class Trip {
  const Trip({
    required this.id,
    required this.start,
    required this.end,
    required this.amount,
    required this.payment,
    required this.commission,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        id: json['id'] as String,
        start: ZonedDateTime.parse(json['start'] as String),
        end: ZonedDateTime.parse(json['end'] as String),
        amount: json['amount'] as int,
        payment: PaymentMethod.fromJson(json['payment'] as String),
        commission: json['commission'] as int,
      );

  final String id;
  final ZonedDateTime start;
  final ZonedDateTime end;
  final int amount;
  final PaymentMethod payment;
  final int commission;

  Duration get duration => end.instant.difference(start.instant);
  bool get endsNextDay => dateOnly(end.wall).isAfter(dateOnly(start.wall));
}

class PaymentBreakdown {
  const PaymentBreakdown({required this.count, required this.amount, required this.commission});

  factory PaymentBreakdown.fromJson(Map<String, dynamic> json) => PaymentBreakdown(
        count: json['count'] as int,
        amount: json['amount'] as int,
        commission: json['commission'] as int,
      );

  static const empty = PaymentBreakdown(count: 0, amount: 0, commission: 0);

  final int count;
  final int amount;
  final int commission;
}

class DaySummary {
  const DaySummary({
    required this.tripsCount,
    required this.revenue,
    required this.commission,
    required this.net,
    required this.byPayment,
  });

  factory DaySummary.fromJson(Map<String, dynamic> json) {
    final byPayment = json['by_payment'] as Map<String, dynamic>;
    return DaySummary(
      tripsCount: json['trips_count'] as int,
      revenue: json['revenue'] as int,
      commission: json['commission'] as int,
      net: json['net'] as int,
      byPayment: {
        for (final method in PaymentMethod.values)
          method: byPayment[method.name] == null
              ? PaymentBreakdown.empty
              : PaymentBreakdown.fromJson(byPayment[method.name] as Map<String, dynamic>),
      },
    );
  }

  final int tripsCount;
  final int revenue;
  final int commission;

  /// «На руки»: выручка минус комиссия.
  final int net;
  final Map<PaymentMethod, PaymentBreakdown> byPayment;
}

class DayReport {
  const DayReport({required this.date, required this.utcOffset, required this.summary, required this.trips});

  factory DayReport.fromJson(Map<String, dynamic> json) => DayReport(
        date: dateOnly(DateTime.parse(json['date'] as String)),
        utcOffset: parseUtcOffset(json['utc_offset'] as String),
        summary: DaySummary.fromJson(json['summary'] as Map<String, dynamic>),
        trips: [for (final t in json['trips'] as List) Trip.fromJson(t as Map<String, dynamic>)],
      );

  final DateTime date;

  /// Часовой пояс водителя: в нём сервер относит поездки к дням.
  final Duration utcOffset;
  final DaySummary summary;
  final List<Trip> trips;
}

class DayInfo {
  const DayInfo({required this.date, required this.tripsCount});

  factory DayInfo.fromJson(Map<String, dynamic> json) => DayInfo(
        date: dateOnly(DateTime.parse(json['date'] as String)),
        tripsCount: json['trips_count'] as int,
      );

  final DateTime date;
  final int tripsCount;
}

/// Новая поездка для POST /api/trips.
///
/// [id] создаётся один раз при открытии формы и не меняется при повторных
/// нажатиях «Сохранить» — по нему сервер узнаёт повторную отправку.
class NewTrip {
  const NewTrip({
    required this.id,
    required this.start,
    required this.end,
    required this.amount,
    required this.payment,
    required this.commission,
  });

  final String id;
  final ZonedDateTime start;
  final ZonedDateTime end;
  final int amount;
  final PaymentMethod payment;
  final int commission;

  Map<String, dynamic> toJson() => {
        'id': id,
        'start': start.toIso8601(),
        'end': end.toIso8601(),
        'amount': amount,
        'payment': payment.name,
        'commission': commission,
      };
}
