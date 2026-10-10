// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_trip_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NewTripDto _$NewTripDtoFromJson(Map<String, dynamic> json) => _NewTripDto(
  id: json['id'] as String,
  start: json['start'] as String,
  end: json['end'] as String,
  amount: (json['amount'] as num).toInt(),
  payment: json['payment'] as String,
  commission: (json['commission'] as num).toInt(),
);

Map<String, dynamic> _$NewTripDtoToJson(_NewTripDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start': instance.start,
      'end': instance.end,
      'amount': instance.amount,
      'payment': instance.payment,
      'commission': instance.commission,
    };

_ConflictDto _$ConflictDtoFromJson(Map<String, dynamic> json) => _ConflictDto(
  code: json['code'] as String,
  message: json['message'] as String,
  existing: TripDto.fromJson(json['existing'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ConflictDtoToJson(_ConflictDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'existing': instance.existing.toJson(),
    };
