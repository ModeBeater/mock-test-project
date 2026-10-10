import 'package:flutter/material.dart';

import 'format.dart';
import 'models.dart';
import 'summary_card.dart';

class TripList extends StatelessWidget {
  const TripList({super.key, required this.trips});

  final List<Trip> trips;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (final (i, trip) in trips.indexed) ...[
            if (i > 0) const Divider(height: 1, indent: 72),
            TripTile(trip: trip),
          ],
        ],
      ),
    );
  }
}

class TripTile extends StatelessWidget {
  const TripTile({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final color = paymentColor(scheme, trip.payment);

    return ListTile(
      key: ValueKey(trip.id),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.12),
        foregroundColor: color,
        child: Icon(paymentIcon(trip.payment), size: 20),
      ),
      title: Text(formatTimeRange(trip)),
      subtitle: Text('${formatDuration(trip.duration)} · ${trip.payment.label}'),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(formatMoney(trip.amount), style: theme.textTheme.titleMedium),
          Text(
            '−${formatMoney(trip.commission)}',
            style: theme.textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
