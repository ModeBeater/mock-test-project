import 'package:http/http.dart' as http;

import '../core/network/api_client.dart';
import '../core/time/clock.dart';
import '../features/diary/data/datasources/diary_remote_data_source.dart';
import '../features/diary/data/repositories/diary_repository_impl.dart';
import '../features/diary/domain/usecases/get_day_report.dart';
import '../features/diary/domain/usecases/get_work_days.dart';
import '../features/trip_entry/data/datasources/trip_entry_remote_data_source.dart';
import '../features/trip_entry/data/repositories/trip_entry_repository_impl.dart';
import '../features/trip_entry/domain/usecases/submit_trip.dart';

/// Корень композиции: здесь и только здесь слои соединяются друг с другом.
final class AppDependencies {
  factory AppDependencies({required Uri apiBaseUrl, http.Client? httpClient, Clock clock = const Clock()}) {
    final api = ApiClient(baseUrl: apiBaseUrl, httpClient: httpClient ?? http.Client());
    final diary = DiaryRepositoryImpl(DiaryRemoteDataSource(api));
    final tripEntry = TripEntryRepositoryImpl(TripEntryRemoteDataSource(api));
    return AppDependencies._(
      clock: clock,
      getDayReport: GetDayReport(diary),
      getWorkDays: GetWorkDays(diary),
      submitTrip: SubmitTrip(tripEntry),
    );
  }

  const AppDependencies._({
    required this.clock,
    required this.getDayReport,
    required this.getWorkDays,
    required this.submitTrip,
  });

  final Clock clock;
  final GetDayReport getDayReport;
  final GetWorkDays getWorkDays;
  final SubmitTrip submitTrip;
}
