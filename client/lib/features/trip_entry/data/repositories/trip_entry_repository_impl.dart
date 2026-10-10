import '../../../../core/error/result.dart';
import '../../../../core/network/guard.dart';
import '../../../../shared/data/trip_dto.dart';
import '../../domain/entities/trip_draft.dart';
import '../../domain/entities/trip_entry_outcome.dart';
import '../../domain/repositories/trip_entry_repository.dart';
import '../datasources/trip_entry_remote_data_source.dart';
import '../dto/new_trip_dto.dart';

final class TripEntryRepositoryImpl implements TripEntryRepository {
  const TripEntryRepositoryImpl(this._remote);

  final TripEntryRemoteDataSource _remote;

  @override
  Future<Result<TripEntryOutcome>> submit(TripDraft draft) => guard(() async {
        return switch (await _remote.submit(NewTripDto.fromDraft(draft))) {
          SubmitCreated(:final trip) => TripEntryOutcome.created(trip.toEntity()),
          SubmitReplayed(:final trip) => TripEntryOutcome.alreadySaved(trip.toEntity()),
          SubmitConflict(:final conflict) => TripEntryOutcome.conflict(
              conflict.code == 'id_conflict' ? ConflictKind.sameIdDifferentData : ConflictKind.overlap,
              conflict.existing.toEntity(),
            ),
        };
      });
}
