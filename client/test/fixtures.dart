import 'dart:convert';

Map<String, dynamic> trip(String id, String start, String end, int amount, String payment, int commission) => {
      'id': id,
      'start': start,
      'end': end,
      'amount': amount,
      'payment': payment,
      'commission': commission,
    };

final exampleDay = {
  'date': '2026-10-01',
  'utc_offset': '+05:00',
  'summary': {
    'trips_count': 2,
    'revenue': 3900,
    'commission': 585,
    'net': 3315,
    'by_payment': {
      'cash': {'count': 1, 'amount': 1500, 'commission': 225},
      'card': {'count': 1, 'amount': 2400, 'commission': 360},
    },
  },
  'trips': [
    trip('t1', '2026-10-01T08:10:00+05:00', '2026-10-01T08:32:00+05:00', 2400, 'card', 360),
    trip('t2', '2026-10-01T09:05:00+05:00', '2026-10-01T09:20:00+05:00', 1500, 'cash', 225),
  ],
};

Map<String, dynamic> emptyDay(String date) => {
      'date': date,
      'utc_offset': '+05:00',
      'summary': {
        'trips_count': 0,
        'revenue': 0,
        'commission': 0,
        'net': 0,
        'by_payment': {
          'cash': {'count': 0, 'amount': 0, 'commission': 0},
          'card': {'count': 0, 'amount': 0, 'commission': 0},
        },
      },
      'trips': [],
    };

String encode(Object json) => jsonEncode(json);
