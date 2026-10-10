import 'dart:convert';

import 'package:driver_diary/src/api.dart';
import 'package:driver_diary/src/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'fixtures.dart';

void main() {
  final newTrip = NewTrip(
    id: 'abc',
    start: ZonedDateTime.parse('2026-10-01T10:00:00+05:00'),
    end: ZonedDateTime.parse('2026-10-01T10:20:00+05:00'),
    amount: 2000,
    payment: PaymentMethod.cash,
    commission: 300,
  );
  final saved = trip('abc', '2026-10-01T10:00:00+05:00', '2026-10-01T10:20:00+05:00', 2000, 'cash', 300);

  DiaryApi api(Future<http.Response> Function(http.Request) handler) =>
      DiaryApi(baseUrl: Uri.parse('http://test'), client: MockClient(handler));

  http.Response json(Object body, int status) =>
      http.Response.bytes(utf8.encode(encode(body)), status, headers: {'content-type': 'application/json'});

  test('fetchDay запрашивает день по дате', () async {
    late Uri requested;
    final report = await api((r) async {
      requested = r.url;
      return json(exampleDay, 200);
    }).fetchDay(DateTime.utc(2026, 10, 1));

    expect(requested.path, '/api/days/2026-10-01');
    expect(report.summary.tripsCount, 2);
  });

  test('201 — новая поездка, 200 — повтор', () async {
    expect((await api((_) async => json(saved, 201)).createTrip(newTrip)).created, isTrue);
    expect((await api((_) async => json(saved, 200)).createTrip(newTrip)).created, isFalse);
  });

  test('повторная отправка уходит с тем же id', () async {
    final bodies = <Map<String, dynamic>>[];
    final client = api((r) async {
      bodies.add(jsonDecode(r.body) as Map<String, dynamic>);
      return json(saved, bodies.length == 1 ? 201 : 200);
    });

    await client.createTrip(newTrip);
    await client.createTrip(newTrip);

    expect(bodies, hasLength(2));
    expect(bodies[0], bodies[1]);
    expect(bodies[0]['id'], 'abc');
  });

  test('409 превращается в TripConflictException', () async {
    final conflict = {
      'detail': {
        'code': 'trip_overlap',
        'message': "Trip overlaps with trip 't1'",
        'existing': trip('t1', '2026-10-01T08:10:00+05:00', '2026-10-01T08:32:00+05:00', 2400, 'card', 360),
      },
    };

    expect(
      () => api((_) async => json(conflict, 409)).createTrip(newTrip),
      throwsA(isA<TripConflictException>()
          .having((e) => e.code, 'code', 'trip_overlap')
          .having((e) => e.existing.id, 'existing.id', 't1')),
    );
  });

  test('422 — сообщение сервера', () async {
    final error = {
      'detail': [
        {'loc': ['body'], 'msg': 'Value error, end must be later than start', 'type': 'value_error'},
      ],
    };

    expect(
      () => api((_) async => json(error, 422)).createTrip(newTrip),
      throwsA(isA<ApiException>().having((e) => e.message, 'message', contains('end must be later than start'))),
    );
  });

  test('нет связи с сервером', () async {
    expect(
      () => api((_) async => throw http.ClientException('connection refused')).fetchDays(),
      throwsA(isA<ApiException>().having((e) => e.message, 'message', 'Нет связи с сервером')),
    );
  });
}
