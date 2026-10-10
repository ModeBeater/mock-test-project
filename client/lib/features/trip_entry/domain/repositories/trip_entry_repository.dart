import '../../../../core/error/result.dart';
import '../entities/trip_draft.dart';
import '../entities/trip_entry_outcome.dart';

abstract interface class TripEntryRepository {
  Future<Result<TripEntryOutcome>> submit(TripDraft draft);
}
