import '../../../../core/error/result.dart';
import '../../../../core/network/guard.dart';
import '../../domain/entities/day_report.dart';
import '../../domain/entities/work_day.dart';
import '../../domain/repositories/diary_repository.dart';
import '../datasources/diary_remote_data_source.dart';
import '../dto/day_report_dto.dart';

final class DiaryRepositoryImpl implements DiaryRepository {
  const DiaryRepositoryImpl(this._remote);

  final DiaryRemoteDataSource _remote;

  @override
  Future<Result<DayReport>> getDayReport(DateTime day) => guard(() async => (await _remote.fetchDay(day)).toEntity());

  @override
  Future<Result<List<WorkDay>>> getWorkDays() => guard(() async {
        final days = [for (final d in await _remote.fetchWorkDays()) d.toEntity()];
        return days..sort((a, b) => a.date.compareTo(b.date));
      });
}
