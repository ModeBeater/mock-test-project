import 'package:driver_diary/core/error/failure.dart';
import 'package:driver_diary/core/error/result.dart';
import 'package:driver_diary/core/network/api_client.dart';
import 'package:driver_diary/features/diary/data/datasources/diary_remote_data_source.dart';
import 'package:driver_diary/features/diary/data/repositories/diary_repository_impl.dart';
import 'package:driver_diary/features/diary/domain/entities/day_report.dart';
import 'package:driver_diary/shared/domain/payment_method.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import '../../helpers/fixtures.dart';

void main() {
  late List<Uri> requested;

  DiaryRepositoryImpl repository(Future<http.Response> Function(http.Request) handler) {
    requested = [];
    final client = MockClient((r) {
      requested.add(r.url);
      return handler(r);
    });
    return DiaryRepositoryImpl(DiaryRemoteDataSource(ApiClient(baseUrl: Uri.parse('http://test'), httpClient: client)));
  }

  test('день: JSON → сущность', () async {
    final result = await repository((_) async => jsonResponse(exampleDayJson)).getDayReport(DateTime.utc(2026, 10, 1));

    expect(requested.single.path, '/api/days/2026-10-01');
    final report = (result as Ok<DayReport>).value;
    expect(report.date, DateTime.utc(2026, 10, 1));
    expect(report.utcOffset, const Duration(hours: 5));
    expect(report.summary.net, 3315);
    expect(report.summary.of(PaymentMethod.cash).amount, 1500);
    expect(report.trips.map((t) => t.id), ['t1', 't2']);
    expect(report.trips.first.duration, const Duration(minutes: 22));
    expect(report.shiftDuration, const Duration(minutes: 70));
    expect(report.netPerHour, 2841); // 3315 ₸ за 70 минут
  });

  test('рабочие дни', () async {
    final result = await repository((_) async => jsonResponse([
          {'date': '2026-10-03', 'trips_count': 1, 'net': 1700},
          {'date': '2026-10-01', 'trips_count': 2, 'net': 3315},
        ])).getWorkDays();

    final days = (result as Ok).value as List;
    expect(days.map((d) => d.date), [DateTime.utc(2026, 10, 1), DateTime.utc(2026, 10, 3)]);
  });

  test('ошибки превращаются в Failure', () async {
    final day = DateTime.utc(2026, 10, 1);

    expect((await repository((_) async => http.Response('', 500)).getDayReport(day) as Err).failure,
        const Failure.server(500));
    expect((await repository((_) async => throw http.ClientException('offline')).getDayReport(day) as Err).failure,
        const Failure.noConnection());
    expect((await repository((_) async => jsonResponse({'date': 1})).getDayReport(day) as Err).failure,
        const Failure.malformedResponse());
    expect((await repository((_) async => http.Response('<html>', 200)).getDayReport(day) as Err).failure,
        const Failure.malformedResponse());
  });
}
