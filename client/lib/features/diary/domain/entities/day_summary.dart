import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/domain/payment_method.dart';

part 'day_summary.freezed.dart';

@freezed
abstract class PaymentBreakdown with _$PaymentBreakdown {
  const factory PaymentBreakdown({
    @Default(0) int count,
    @Default(0) int amount,
    @Default(0) int commission,
  }) = _PaymentBreakdown;
}

@freezed
abstract class DaySummary with _$DaySummary {
  const DaySummary._();

  const factory DaySummary({
    required int tripsCount,
    required int revenue,
    required int commission,

    /// «На руки»: выручка минус комиссия. Считает сервер.
    required int net,
    required Map<PaymentMethod, PaymentBreakdown> byPayment,
  }) = _DaySummary;

  PaymentBreakdown of(PaymentMethod method) => byPayment[method] ?? const PaymentBreakdown();

  /// Средний чек.
  int? get averageFare => tripsCount == 0 ? null : (revenue / tripsCount).round();
}
