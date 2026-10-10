import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/time/calendar.dart';
import '../../../../shared/data/trip_dto.dart';
import '../../domain/entities/day_report.dart';
import '../../domain/entities/day_summary.dart';
import '../../domain/entities/work_day.dart';

part 'day_report_dto.freezed.dart';
part 'day_report_dto.g.dart';

@freezed
abstract class PaymentBreakdownDto with _$PaymentBreakdownDto {
  const factory PaymentBreakdownDto({required int count, required int amount, required int commission}) =
      _PaymentBreakdownDto;

  factory PaymentBreakdownDto.fromJson(Map<String, dynamic> json) => _$PaymentBreakdownDtoFromJson(json);
}

@freezed
abstract class DaySummaryDto with _$DaySummaryDto {
  const factory DaySummaryDto({
    required int tripsCount,
    required int revenue,
    required int commission,
    required int net,
    required Map<String, PaymentBreakdownDto> byPayment,
  }) = _DaySummaryDto;

  factory DaySummaryDto.fromJson(Map<String, dynamic> json) => _$DaySummaryDtoFromJson(json);
}

@freezed
abstract class DayReportDto with _$DayReportDto {
  const factory DayReportDto({
    required String date,
    required String utcOffset,
    required DaySummaryDto summary,
    required List<TripDto> trips,
  }) = _DayReportDto;

  factory DayReportDto.fromJson(Map<String, dynamic> json) => _$DayReportDtoFromJson(json);
}

@freezed
abstract class WorkDayDto with _$WorkDayDto {
  const factory WorkDayDto({required String date, required int tripsCount, required int net}) = _WorkDayDto;

  factory WorkDayDto.fromJson(Map<String, dynamic> json) => _$WorkDayDtoFromJson(json);
}

extension DayReportDtoMapper on DayReportDto {
  DayReport toEntity() {
    final trips = [for (final t in this.trips) t.toEntity()]..sort((a, b) => a.start.compareTo(b.start));
    return DayReport(
      date: dateOnly(DateTime.parse(date)),
      utcOffset: parseUtcOffset(utcOffset),
      summary: summary.toEntity(),
      trips: trips,
    );
  }
}

extension on DaySummaryDto {
  DaySummary toEntity() => DaySummary(
        tripsCount: tripsCount,
        revenue: revenue,
        commission: commission,
        net: net,
        byPayment: {
          for (final MapEntry(:key, :value) in byPayment.entries)
            paymentFromJson(key): PaymentBreakdown(count: value.count, amount: value.amount, commission: value.commission),
        },
      );
}

extension WorkDayDtoMapper on WorkDayDto {
  WorkDay toEntity() => WorkDay(date: dateOnly(DateTime.parse(date)), tripsCount: tripsCount, net: net);
}
