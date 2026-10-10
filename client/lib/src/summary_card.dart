import 'package:flutter/material.dart';

import 'format.dart';
import 'models.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key, required this.summary});

  final DaySummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('На руки', style: muted),
            const SizedBox(height: 4),
            Text(
              formatMoney(summary.net),
              key: const Key('summary-net'),
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _Stat(label: 'Поездок', value: '${summary.tripsCount}')),
                Expanded(child: _Stat(label: 'Выручка', value: formatMoney(summary.revenue))),
                Expanded(
                  child: _Stat(
                    label: 'Комиссия',
                    value: summary.commission == 0 ? formatMoney(0) : '−${formatMoney(summary.commission)}',
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            _PaymentSplit(summary: summary),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        const SizedBox(height: 2),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(value, style: theme.textTheme.titleMedium),
        ),
      ],
    );
  }
}

Color paymentColor(ColorScheme scheme, PaymentMethod method) => switch (method) {
      PaymentMethod.cash => scheme.tertiary,
      PaymentMethod.card => scheme.primary,
    };

IconData paymentIcon(PaymentMethod method) => switch (method) {
      PaymentMethod.cash => Icons.payments_outlined,
      PaymentMethod.card => Icons.credit_card,
    };

/// Полоса «наличные / карта» пропорционально выручке и подписи под ней.
class _PaymentSplit extends StatelessWidget {
  const _PaymentSplit({required this.summary});

  final DaySummary summary;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final parts = [
      for (final method in PaymentMethod.values) (method, summary.byPayment[method] ?? PaymentBreakdown.empty),
    ];

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SizedBox(
            height: 8,
            child: summary.revenue == 0
                ? ColoredBox(color: scheme.surfaceContainerHighest, child: const SizedBox.expand())
                : Row(
                    // Без stretch пустой ColoredBox получает нулевую высоту и полоса не видна.
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (final (method, part) in parts)
                        if (part.amount > 0)
                          Expanded(
                            key: Key('split-${method.name}'),
                            flex: part.amount,
                            child: ColoredBox(color: paymentColor(scheme, method)),
                          ),
                    ],
                  ),
          ),
        ),
        const SizedBox(height: 12),
        for (final (method, part) in parts)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Icon(paymentIcon(method), size: 18, color: paymentColor(scheme, method)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(text: method.label),
                      TextSpan(text: ' · ${pluralTrips(part.count)}', style: TextStyle(color: scheme.onSurfaceVariant)),
                    ]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  formatMoney(part.amount),
                  key: Key('summary-${method.name}'),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
