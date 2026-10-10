import 'package:flutter/material.dart';

import '../../../../core/format/formatters.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../shared/domain/payment_method.dart';
import '../../domain/entities/day_report.dart';

/// Итог дня в виде ведомости: крупно «на руки», ниже — из чего сложилось.
class EarningsSummary extends StatelessWidget {
  const EarningsSummary({super.key, required this.report});

  final DayReport report;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final text = Theme.of(context).textTheme;
    final s = report.summary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formatMoney(s.net),
            key: const Key('summary-net'),
            style: context.numbers(text.displayMedium).copyWith(fontWeight: FontWeight.w700, letterSpacing: -1.5),
          ),
          Text('на руки', style: text.bodyMedium?.copyWith(color: p.muted)),
          const SizedBox(height: 20),
          IntrinsicHeight(
            child: Row(
              children: [
                _Kpi(label: 'Поездок', value: '${s.tripsCount}'),
                VerticalDivider(color: p.hairline, width: 24),
                _Kpi(label: 'В час', value: report.netPerHour == null ? '—' : formatMoney(report.netPerHour!)),
                VerticalDivider(color: p.hairline, width: 24),
                _Kpi(label: 'Средний чек', value: s.averageFare == null ? '—' : formatMoney(s.averageFare!)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Divider(),
          _LedgerRow(label: 'Выручка', value: formatMoney(s.revenue), valueKey: const Key('summary-revenue')),
          _LedgerRow(
            label: 'Комиссия сервиса',
            value: s.commission == 0 ? formatMoney(0) : '−${formatMoney(s.commission)}',
            muted: true,
          ),
          const Divider(),
          for (final method in PaymentMethod.values)
            _LedgerRow(
              swatch: _swatch(p, method),
              label: method.label,
              hint: '${s.of(method).count}',
              value: formatMoney(s.of(method).amount),
              valueKey: Key('summary-${method.name}'),
            ),
          const SizedBox(height: 8),
          _SplitBar(cash: s.of(PaymentMethod.cash).amount, card: s.of(PaymentMethod.card).amount),
        ],
      ),
    );
  }
}

Color _swatch(AppPalette p, PaymentMethod method) => switch (method) {
      PaymentMethod.cash => p.ink,
      PaymentMethod.card => p.accent,
    };

class _Kpi extends StatelessWidget {
  const _Kpi({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: text.bodySmall?.copyWith(color: context.palette.muted)),
          const SizedBox(height: 2),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(value, style: context.numbers(text.titleMedium).copyWith(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _LedgerRow extends StatelessWidget {
  const _LedgerRow({required this.label, required this.value, this.hint, this.swatch, this.muted = false, this.valueKey});

  final String label;
  final String value;
  final String? hint;
  final Color? swatch;
  final bool muted;
  final Key? valueKey;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        children: [
          if (swatch != null) ...[
            Container(width: 10, height: 10, decoration: BoxDecoration(color: swatch, borderRadius: BorderRadius.circular(2))),
            const SizedBox(width: 10),
          ],
          // Подпись забирает всё свободное место, сумма прижата к правому краю.
          Expanded(
            child: Row(
              children: [
                Flexible(child: Text(label, style: text.bodyLarge, overflow: TextOverflow.ellipsis)),
                if (hint != null) ...[
                  const SizedBox(width: 6),
                  Text(hint!, style: context.numbers(text.bodyMedium).copyWith(color: p.muted)),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            value,
            key: valueKey,
            style: context.numbers(text.bodyLarge).copyWith(
                  fontWeight: muted ? FontWeight.w400 : FontWeight.w600,
                  color: muted ? p.muted : p.ink,
                ),
          ),
        ],
      ),
    );
  }
}

/// Доля наличных и безнала в выручке.
class _SplitBar extends StatelessWidget {
  const _SplitBar({required this.cash, required this.card});

  final int cash;
  final int card;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: SizedBox(
        height: 6,
        child: cash + card == 0
            ? ColoredBox(color: p.hairline, child: const SizedBox.expand())
            : Row(
                // Без stretch пустой ColoredBox получает нулевую высоту и полоса не видна.
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (cash > 0) Expanded(key: const Key('split-cash'), flex: cash, child: ColoredBox(color: p.ink)),
                  if (card > 0) Expanded(key: const Key('split-card'), flex: card, child: ColoredBox(color: p.accent)),
                ],
              ),
      ),
    );
  }
}
