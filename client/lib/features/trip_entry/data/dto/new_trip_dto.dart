import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/data/trip_dto.dart';
import '../../domain/entities/trip_draft.dart';

part 'new_trip_dto.freezed.dart';
part 'new_trip_dto.g.dart';

@freezed
abstract class NewTripDto with _$NewTripDto {
  const factory NewTripDto({
    required String id,
    required String start,
    required String end,
    required int amount,
    required String payment,
    required int commission,
  }) = _NewTripDto;

  factory NewTripDto.fromDraft(TripDraft draft) => NewTripDto(
        id: draft.id,
        start: draft.start.toIso8601(),
        end: draft.end.toIso8601(),
        amount: draft.amount!,
        payment: paymentToJson(draft.payment),
        commission: draft.commission!,
      );

  factory NewTripDto.fromJson(Map<String, dynamic> json) => _$NewTripDtoFromJson(json);
}

/// Тело ответа 409: `{"detail": {"code", "message", "existing"}}`.
@freezed
abstract class ConflictDto with _$ConflictDto {
  const factory ConflictDto({required String code, required String message, required TripDto existing}) = _ConflictDto;

  factory ConflictDto.fromJson(Map<String, dynamic> json) => _$ConflictDtoFromJson(json);
}

/// Что ответил сервер на POST /api/trips.
sealed class SubmitResponse {
  const SubmitResponse();
}

final class SubmitCreated extends SubmitResponse {
  const SubmitCreated(this.trip);

  final TripDto trip;
}

final class SubmitReplayed extends SubmitResponse {
  const SubmitReplayed(this.trip);

  final TripDto trip;
}

final class SubmitConflict extends SubmitResponse {
  const SubmitConflict(this.conflict);

  final ConflictDto conflict;
}
