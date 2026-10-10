// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_report_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentBreakdownDto _$PaymentBreakdownDtoFromJson(Map<String, dynamic> json) =>
    _PaymentBreakdownDto(
      count: (json['count'] as num).toInt(),
      amount: (json['amount'] as num).toInt(),
      commission: (json['commission'] as num).toInt(),
    );

Map<String, dynamic> _$PaymentBreakdownDtoToJson(
  _PaymentBreakdownDto instance,
) => <String, dynamic>{
  'count': instance.count,
  'amount': instance.amount,
  'commission': instance.commission,
};

_DaySummaryDto _$DaySummaryDtoFromJson(Map<String, dynamic> json) =>
    _DaySummaryDto(
      tripsCount: (json['trips_count'] as num).toInt(),
      revenue: (json['revenue'] as num).toInt(),
      commission: (json['commission'] as num).toInt(),
      net: (json['net'] as num).toInt(),
      byPayment: (json['by_payment'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
          k,
          PaymentBreakdownDto.fromJson(e as Map<String, dynamic>),
        ),
      ),
    );

Map<String, dynamic> _$DaySummaryDtoToJson(_DaySummaryDto instance) =>
    <String, dynamic>{
      'trips_count': instance.tripsCount,
      'revenue': instance.revenue,
      'commission': instance.commission,
      'net': instance.net,
      'by_payment': instance.byPayment.map((k, e) => MapEntry(k, e.toJson())),
    };

_DayReportDto _$DayReportDtoFromJson(Map<String, dynamic> json) =>
    _DayReportDto(
      date: json['date'] as String,
      utcOffset: json['utc_offset'] as String,
      summary: DaySummaryDto.fromJson(json['summary'] as Map<String, dynamic>),
      trips: (json['trips'] as List<dynamic>)
          .map((e) => TripDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DayReportDtoToJson(_DayReportDto instance) =>
    <String, dynamic>{
      'date': instance.date,
      'utc_offset': instance.utcOffset,
      'summary': instance.summary.toJson(),
      'trips': instance.trips.map((e) => e.toJson()).toList(),
    };

_WorkDayDto _$WorkDayDtoFromJson(Map<String, dynamic> json) => _WorkDayDto(
  date: json['date'] as String,
  tripsCount: (json['trips_count'] as num).toInt(),
  net: (json['net'] as num).toInt(),
);

Map<String, dynamic> _$WorkDayDtoToJson(_WorkDayDto instance) =>
    <String, dynamic>{
      'date': instance.date,
      'trips_count': instance.tripsCount,
      'net': instance.net,
    };
