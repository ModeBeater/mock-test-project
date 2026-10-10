import '../../../../core/error/result.dart';
import '../../../../core/time/calendar.dart';
import '../entities/day_report.dart';
import '../repositories/diary_repository.dart';

final class GetDayReport {
  const GetDayReport(this._repository);

  final DiaryRepository _repository;

  Future<Result<DayReport>> call(DateTime day) => _repository.getDayReport(dateOnly(day));
}
