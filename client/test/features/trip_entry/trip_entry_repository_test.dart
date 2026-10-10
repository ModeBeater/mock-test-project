import 'dart:convert';

import 'package:driver_diary/core/error/failure.dart';
import 'package:driver_diary/core/error/result.dart';
import 'package:driver_diary/core/network/api_client.dart';
import 'package:driver_diary/features/trip_entry/data/datasources/trip_entry_remote_data_source.dart';
import 'package:driver_diary/features/trip_entry/data/repositories/trip_entry_repository_impl.dart';
import 'package:driver_diary/features/trip_entry/domain/entities/trip_draft.dart';
import 'package:driver_diary/features/trip_entry/domain/entities/trip_entry_outcome.dart';
import 'package:driver_diary/shared/domain/payment_method.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import '../../helpers/fixtures.dart';

void main() {
  final draft = TripDraft(
    id: 'abc',
    day: DateTime.utc(2026, 10, 1),
    startMinute: 23 * 60 + 50,
    endMinute: 20,
    utcOffset: const Duration(hours: 5),
    amount: 2000,
    commission: 300,
    payment: PaymentMethod.cash,
  );
  final saved = tripJson('abc', '2026-10-01T23:50:00+05:00', '2026-10-02T00:20:00+05:00', 2000, 'cash', 300);
  final t1 = tripJson('t1', '2026-10-01T23:40:00+05:00', '2026-10-01T23:55:00+05:00', 2400, 'card', 360);
  late List<Map<String, dynamic>> bodies;

  Future<Result<TripEntryOutcome>> submit(http.Response response) {
    bodies = [];
    final client = MockClient((r) async {
      bodies.add(jsonDecode(r.body) as Map<String, dynamic>);
      return response;
    });
    final api = ApiClient(baseUrl: Uri.parse('http://test'), httpClient: client);
    return TripEntryRepositoryImpl(TripEntryRemoteDataSource(api)).submit(draft);
  }

  test('отправляет поездку с id черновика и временем в поясе водителя', () async {
    await submit(jsonResponse(saved, 201));

    expect(bodies.single, {
      'id': 'abc',
      'start': '2026-10-01T23:50:00+05:00',
      'end': '2026-10-02T00:20:00+05:00',
      'amount': 2000,
      'payment': 'cash',
      'commission': 300,
    });
  });

  test('201 — создана, 200 — уже была сохранена', () async {
    expect((await submit(jsonResponse(saved, 201)) as Ok).value, isA<TripCreated>());
    expect((await submit(jsonResponse(saved, 200)) as Ok).value, isA<TripAlreadySaved>());
  });

  test('409 — конфликт с существующей поездкой', () async {
    Future<TripEntryOutcome> conflict(String code) async => (await submit(jsonResponse({
          'detail': {'code': code, 'message': '...', 'existing': t1},
        }, 409)) as Ok<TripEntryOutcome>)
            .value;

    expect(await conflict('trip_overlap'),
        isA<TripConflict>().having((c) => c.kind, 'kind', ConflictKind.overlap).having((c) => c.existing.id, 'id', 't1'));
    expect(await conflict('id_conflict'), isA<TripConflict>().having((c) => c.kind, 'kind', ConflictKind.sameIdDifferentData));
  });

  test('422 — сообщение сервера', () async {
    final result = await submit(jsonResponse({
      'detail': [
        {'type': 'value_error', 'loc': ['body', 'end'], 'msg': 'end must be later than start'},
      ],
    }, 422));

    expect((result as Err).failure, const Failure.rejected('end must be later than start'));
  });
}
