import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../entities/trip_draft.dart';
import '../entities/trip_entry_outcome.dart';
import '../repositories/trip_entry_repository.dart';

final class SubmitTrip {
  const SubmitTrip(this._repository);

  final TripEntryRepository _repository;

  /// Невалидный черновик на сервер не уходит.
  Future<Result<TripEntryOutcome>> call(TripDraft draft) async {
    final errors = draft.validate();
    if (errors.isNotEmpty) return Err(Failure.rejected(errors.map((e) => e.name).join(', ')));
    return _repository.submit(draft);
  }
}
