import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/domain/trip.dart';

part 'trip_entry_outcome.freezed.dart';

enum ConflictKind {
  /// Пересекается по времени с другой поездкой.
  overlap,

  /// Поездка с этим id уже сохранена, но с другими данными.
  sameIdDifferentData,
}

/// Чем закончилась отправка. Все три варианта — штатные ответы сервера, а не ошибки.
@freezed
sealed class TripEntryOutcome with _$TripEntryOutcome {
  const factory TripEntryOutcome.created(Trip trip) = TripCreated;

  /// Сервер уже знал эту поездку (повторная отправка) — дубль не создан.
  const factory TripEntryOutcome.alreadySaved(Trip trip) = TripAlreadySaved;
  const factory TripEntryOutcome.conflict(ConflictKind kind, Trip existing) = TripConflict;
}
