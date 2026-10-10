// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripDto _$TripDtoFromJson(Map<String, dynamic> json) => _TripDto(
  id: json['id'] as String,
  start: json['start'] as String,
  end: json['end'] as String,
  amount: (json['amount'] as num).toInt(),
  payment: json['payment'] as String,
  commission: (json['commission'] as num).toInt(),
);

Map<String, dynamic> _$TripDtoToJson(_TripDto instance) => <String, dynamic>{
  'id': instance.id,
  'start': instance.start,
  'end': instance.end,
  'amount': instance.amount,
  'payment': instance.payment,
  'commission': instance.commission,
};
