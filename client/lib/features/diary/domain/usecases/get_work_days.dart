import '../../../../core/error/result.dart';
import '../entities/work_day.dart';
import '../repositories/diary_repository.dart';

final class GetWorkDays {
  const GetWorkDays(this._repository);

  final DiaryRepository _repository;

  Future<Result<List<WorkDay>>> call() => _repository.getWorkDays();
}
