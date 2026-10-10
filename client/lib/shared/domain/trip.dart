import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/time/zoned_date_time.dart';
import 'payment_method.dart';

part 'trip.freezed.dart';

@freezed
abstract class Trip with _$Trip {
  const Trip._();

  const factory Trip({
    required String id,
    required ZonedDateTime start,
    required ZonedDateTime end,
    required int amount,
    required PaymentMethod payment,
    required int commission,
  }) = _Trip;

  Duration get duration => end.instant.difference(start.instant);

  int get net => amount - commission;

  /// День поездки — дата начала по часовому поясу водителя (так же считает сервер).
  DateTime get localDate => start.localDate;

  bool get endsNextDay => end.localDate.isAfter(start.localDate);
}
