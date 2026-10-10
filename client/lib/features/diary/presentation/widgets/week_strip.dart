import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/format/formatters.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/time/calendar.dart';

/// Неделя столбиками: высота — «на руки» за день. Нажатие выбирает день, свайп листает недели.
class WeekStrip extends StatelessWidget {
  const WeekStrip({
    super.key,
    required this.days,
    required this.selected,
    required this.today,
    required this.netOf,
    required this.onSelect,
    required this.onShiftWeek,
  });

  final List<DateTime> days;
  final DateTime selected;
  final DateTime today;
  final int? Function(DateTime day) netOf;
  final ValueChanged<DateTime> onSelect;
  final ValueChanged<int> onShiftWeek;

  @override
  Widget build(BuildContext context) {
    final nets = {for (final d in days) d: netOf(d) ?? 0};
    final maxNet = nets.values.fold(0, math.max);

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        final v = details.primaryVelocity ?? 0;
        if (v.abs() > 300) onShiftWeek(v > 0 ? -1 : 1);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            for (final day in days)
              Expanded(
                child: _DayColumn(
                  day: day,
                  share: maxNet == 0 ? 0 : nets[day]! / maxNet,
                  hasTrips: nets[day]! > 0,
                  isSelected: day == selected,
                  isToday: day == today,
                  onTap: () => onSelect(day),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DayColumn extends StatelessWidget {
  const _DayColumn({
    required this.day,
    required this.share,
    required this.hasTrips,
    required this.isSelected,
    required this.isToday,
    required this.onTap,
  });

  final DateTime day;
  final double share;
  final bool hasTrips;
  final bool isSelected;
  final bool isToday;
  final VoidCallback onTap;

  static const _barArea = 64.0;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final text = Theme.of(context).textTheme;
    final barHeight = hasTrips ? 6 + share * (_barArea - 6) : 2.0;
    final barColor = isSelected ? p.accent : (hasTrips ? p.barIdle : p.hairline);

    return Semantics(
      button: true,
      selected: isSelected,
      label: formatDayMonth(day, today: day),
      child: InkWell(
        key: ValueKey('day-${formatIsoDate(day)}'),
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              SizedBox(
                height: _barArea,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutCubic,
                    width: 18,
                    height: barHeight,
                    decoration: BoxDecoration(
                      color: barColor,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(4), bottom: Radius.circular(1)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                formatWeekdayShort(day),
                style: text.labelSmall?.copyWith(color: isSelected ? p.ink : p.muted, letterSpacing: 0.4),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: isSelected ? p.ink : null, shape: BoxShape.circle),
                child: Text(
                  '${day.day}',
                  style: context.numbers(text.titleSmall).copyWith(
                        fontWeight: FontWeight.w600,
                        color: isSelected ? p.paper : p.ink,
                      ),
                ),
              ),
              const SizedBox(height: 4),
              // Сегодня отмечаем точкой под датой.
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(color: isToday ? p.accent : null, shape: BoxShape.circle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
