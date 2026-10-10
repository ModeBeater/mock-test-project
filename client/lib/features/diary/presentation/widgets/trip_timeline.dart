import 'package:flutter/material.dart';

import '../../../../core/format/formatters.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../shared/domain/payment_method.dart';
import '../../../../shared/domain/trip.dart';

/// Лента смены: поездки по времени, между ними — простои без заказа.
class TripTimeline extends StatelessWidget {
  const TripTimeline({super.key, required this.trips});

  final List<Trip> trips;

  /// Простои короче не показываем — это просто подача следующего заказа.
  static const minVisibleGap = Duration(minutes: 5);

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final text = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
          child: Row(
            children: [
              Text('ПОЕЗДКИ', style: text.labelSmall?.copyWith(color: p.muted, letterSpacing: 1.4)),
              const Spacer(),
              Text(pluralTrips(trips.length), style: text.labelMedium?.copyWith(color: p.muted)),
            ],
          ),
        ),
        for (final (i, trip) in trips.indexed) ...[
          if (i > 0 && trip.start.instant.difference(trips[i - 1].end.instant) >= minVisibleGap)
            _GapRow(gap: trip.start.instant.difference(trips[i - 1].end.instant)),
          _TripRow(trip: trip, isFirst: i == 0, isLast: i == trips.length - 1),
        ],
      ],
    );
  }
}

class _TripRow extends StatelessWidget {
  const _TripRow({required this.trip, required this.isFirst, required this.isLast});

  final Trip trip;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final text = Theme.of(context).textTheme;
    final strong = context.numbers(text.titleSmall).copyWith(fontWeight: FontWeight.w600);
    final weak = context.numbers(text.bodySmall).copyWith(color: p.muted);

    return Padding(
      key: ValueKey(trip.id),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 48,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(formatTime(trip.start), style: strong),
                    Text('${formatTime(trip.end)}${trip.endsNextDay ? '⁺¹' : ''}', style: weak),
                  ],
                ),
              ),
            ),
            CustomPaint(
              size: const Size(24, double.infinity),
              painter: _RailPainter(
                line: p.hairline,
                dot: trip.payment == PaymentMethod.cash ? p.ink : p.accent,
                dotBorder: p.ink,
                top: !isFirst,
                bottom: !isLast,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(trip.payment.label, style: text.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
                    Text(
                      trip.endsNextDay ? '${formatDuration(trip.duration)} · до следующего дня' : formatDuration(trip.duration),
                      style: weak,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(formatMoney(trip.amount), style: strong),
                  Text('−${formatAmount(trip.commission)}', style: weak),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GapRow extends StatelessWidget {
  const _GapRow({required this.gap});

  final Duration gap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 26,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(width: 48),
            CustomPaint(
              size: const Size(24, double.infinity),
              painter: _RailPainter(line: p.hairline, dashed: true, top: true, bottom: true),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'без заказа ${formatDuration(gap)}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: p.muted),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Вертикальная линия ленты с точкой поездки: залитая — наличные, жёлтая — безнал.
class _RailPainter extends CustomPainter {
  const _RailPainter({
    required this.line,
    this.dot,
    this.dotBorder,
    this.top = true,
    this.bottom = true,
    this.dashed = false,
  });

  final Color line;
  final Color? dot;
  final Color? dotBorder;
  final bool top;
  final bool bottom;
  final bool dashed;

  static const _dotY = 19.0;
  static const _dotRadius = 4.5;

  @override
  void paint(Canvas canvas, Size size) {
    final x = size.width / 2 - 4;
    final paint = Paint()
      ..color = line
      ..strokeWidth = 1.5;
    final from = top ? 0.0 : _dotY;
    final to = bottom ? size.height : _dotY;

    if (dashed) {
      for (var y = from; y < to; y += 6) {
        canvas.drawLine(Offset(x, y), Offset(x, (y + 3).clamp(from, to)), paint);
      }
    } else if (to > from) {
      canvas.drawLine(Offset(x, from), Offset(x, to), paint);
    }

    if (dot != null) {
      canvas.drawCircle(Offset(x, _dotY), _dotRadius, Paint()..color = dot!);
      canvas.drawCircle(
        Offset(x, _dotY),
        _dotRadius,
        Paint()
          ..color = dotBorder!
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    }
  }

  @override
  bool shouldRepaint(_RailPainter old) =>
      old.line != line || old.dot != dot || old.top != top || old.bottom != bottom || old.dashed != dashed;
}
