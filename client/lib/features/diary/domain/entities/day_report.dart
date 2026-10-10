import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/time/zoned_date_time.dart';
import '../../../../shared/domain/trip.dart';
import 'day_summary.dart';

part 'day_report.freezed.dart';

@freezed
abstract class DayReport with _$DayReport {
  const DayReport._();

  const factory DayReport({
    required DateTime date,

    /// Часовой пояс водителя: в нём сервер относит поездки к дням.
    required Duration utcOffset,
    required DaySummary summary,

    /// Отсортированы по началу.
    required List<Trip> trips,
  }) = _DayReport;

  bool get isEmpty => trips.isEmpty;

  ZonedDateTime? get shiftStart => trips.isEmpty ? null : trips.first.start;

  ZonedDateTime? get shiftEnd => trips.isEmpty ? null : trips.map((t) => t.end).reduce((a, b) => a.compareTo(b) >= 0 ? a : b);

  /// От начала первой поездки до конца последней.
  Duration? get shiftDuration =>
      trips.isEmpty ? null : shiftEnd!.instant.difference(shiftStart!.instant);

  /// «На руки» за час смены — главный показатель, которым водители сравнивают дни.
  int? get netPerHour {
    final minutes = shiftDuration?.inMinutes ?? 0;
    return minutes < 30 ? null : (summary.net * 60 / minutes).round();
  }
}
