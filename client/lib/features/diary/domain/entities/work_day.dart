import 'package:freezed_annotation/freezed_annotation.dart';

part 'work_day.freezed.dart';

/// День, в который были поездки, — для недельной полосы.
@freezed
abstract class WorkDay with _$WorkDay {
  const factory WorkDay({required DateTime date, required int tripsCount, required int net}) = _WorkDay;
}
