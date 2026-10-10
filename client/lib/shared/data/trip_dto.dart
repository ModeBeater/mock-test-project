import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/time/zoned_date_time.dart';
import '../domain/payment_method.dart';
import '../domain/trip.dart';

part 'trip_dto.freezed.dart';
part 'trip_dto.g.dart';

@freezed
abstract class TripDto with _$TripDto {
  const factory TripDto({
    required String id,
    required String start,
    required String end,
    required int amount,
    required String payment,
    required int commission,
  }) = _TripDto;

  factory TripDto.fromJson(Map<String, dynamic> json) => _$TripDtoFromJson(json);
}

extension TripDtoMapper on TripDto {
  Trip toEntity() => Trip(
        id: id,
        start: ZonedDateTime.parse(start),
        end: ZonedDateTime.parse(end),
        amount: amount,
        payment: paymentFromJson(payment),
        commission: commission,
      );
}

PaymentMethod paymentFromJson(String value) => switch (value) {
      'cash' => PaymentMethod.cash,
      'card' => PaymentMethod.card,
      _ => throw FormatException('Unknown payment method', value),
    };

String paymentToJson(PaymentMethod method) => switch (method) {
      PaymentMethod.cash => 'cash',
      PaymentMethod.card => 'card',
    };
