import '../../../../core/error/result.dart';
import '../entities/day_report.dart';
import '../entities/work_day.dart';

abstract interface class DiaryRepository {
  Future<Result<DayReport>> getDayReport(DateTime day);

  /// Все дни с поездками по возрастанию даты.
  Future<Result<List<WorkDay>>> getWorkDays();
}
