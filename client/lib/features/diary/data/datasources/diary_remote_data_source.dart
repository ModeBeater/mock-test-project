import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/time/calendar.dart';
import '../dto/day_report_dto.dart';

class DiaryRemoteDataSource {
  const DiaryRemoteDataSource(this._api);

  final ApiClient _api;

  Future<DayReportDto> fetchDay(DateTime day) async {
    final response = await _api.get('/api/days/${formatIsoDate(day)}');
    if (!response.isSuccess) throw UnexpectedStatusException(response.statusCode, response.body);
    return DayReportDto.fromJson(response.body! as Map<String, dynamic>);
  }

  Future<List<WorkDayDto>> fetchWorkDays() async {
    final response = await _api.get('/api/days');
    if (!response.isSuccess) throw UnexpectedStatusException(response.statusCode, response.body);
    return [for (final item in response.body! as List) WorkDayDto.fromJson(item as Map<String, dynamic>)];
  }
}
