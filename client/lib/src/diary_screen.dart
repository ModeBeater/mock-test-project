import 'package:flutter/material.dart';

import 'add_trip_sheet.dart';
import 'diary_controller.dart';
import 'format.dart';
import 'summary_card.dart';
import 'trip_list.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key, required this.controller, this.clock = DateTime.now});

  final DiaryController controller;
  final DateTime Function() clock;

  Future<void> _pickDay(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: controller.day,
      firstDate: DateTime(2020),
      lastDate: controller.today.add(const Duration(days: 365)),
    );
    if (picked != null) controller.goTo(picked);
  }

  Future<void> _addTrip(BuildContext context) async {
    final trips = controller.report?.trips ?? const [];
    final result = await showAddTripSheet(
      context,
      day: controller.day,
      today: controller.today,
      utcOffset: controller.utcOffset!,
      onSubmit: controller.addTrip,
      previousTrip: trips.isEmpty ? null : trips.last,
      clock: clock,
    );
    if (result == null || !context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(result.created ? 'Поездка добавлена' : 'Такая поездка уже сохранена — дубль не создан'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: const Text('Дневник смен'),
          actions: [
            IconButton(
              tooltip: 'Обновить',
              onPressed: controller.loading ? null : controller.load,
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              children: [
                _DateBar(controller: controller, onPick: () => _pickDay(context)),
                SizedBox(
                  height: 2,
                  child: controller.loading && controller.report != null ? const LinearProgressIndicator() : null,
                ),
                Expanded(
                  child: GestureDetector(
                    // Свайп влево/вправо — соседний день.
                    onHorizontalDragEnd: (d) {
                      final v = d.primaryVelocity ?? 0;
                      if (v > 300) controller.previousDay();
                      if (v < -300) controller.nextDay();
                    },
                    child: _DayContent(controller: controller),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: controller.utcOffset == null
            ? null
            : FloatingActionButton.extended(
                onPressed: () => _addTrip(context),
                icon: const Icon(Icons.add),
                label: const Text('Поездка'),
              ),
      ),
    );
  }
}

class _DateBar extends StatelessWidget {
  const _DateBar({required this.controller, required this.onPick});

  final DiaryController controller;
  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final day = controller.day;
    final today = controller.today;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Предыдущий день',
            onPressed: controller.previousDay,
            icon: const Icon(Icons.chevron_left),
          ),
          Expanded(
            child: InkWell(
              onTap: onPick,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  children: [
                    Text(
                      formatDay(day, today: today),
                      key: const Key('selected-day'),
                      style: theme.textTheme.titleLarge,
                    ),
                    Text(
                      formatRelativeDay(day, today: today),
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            tooltip: 'Следующий день',
            onPressed: controller.nextDay,
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}

class _DayContent extends StatelessWidget {
  const _DayContent({required this.controller});

  final DiaryController controller;

  @override
  Widget build(BuildContext context) {
    final report = controller.report;
    final error = controller.error;

    if (report == null) {
      if (error != null) {
        return _Message(
          icon: Icons.cloud_off,
          title: 'Не удалось загрузить день',
          text: '$error',
          action: FilledButton.tonal(onPressed: controller.load, child: const Text('Повторить')),
        );
      }
      return const Center(child: CircularProgressIndicator());
    }

    final theme = Theme.of(context);
    final trips = report.trips;
    final lastDay = controller.lastDayWithTrips;

    return RefreshIndicator(
      onRefresh: controller.load,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
        children: [
          if (error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text('Не удалось обновить: $error', style: TextStyle(color: theme.colorScheme.error)),
            ),
          SummaryCard(summary: report.summary),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                Text('Поездки', style: theme.textTheme.titleMedium),
                const SizedBox(width: 16),
                if (trips.isNotEmpty)
                  Expanded(
                    child: Text(
                      'смена ${formatTime(trips.first.start)} – ${formatTime(trips.last.end)}',
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          if (trips.isEmpty)
            if (lastDay != null && lastDay != controller.day)
              _Message(
                icon: Icons.local_taxi_outlined,
                title: 'В этот день поездок нет',
                text: 'Последние поездки — ${formatDay(lastDay, today: controller.today)}',
                action: FilledButton.tonal(onPressed: () => controller.goTo(lastDay), child: const Text('Перейти')),
              )
            else
              const _Message(icon: Icons.local_taxi_outlined, title: 'В этот день поездок нет')
          else
            TripList(trips: trips),
        ],
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.icon, required this.title, this.text, this.action});

  final IconData icon;
  final String title;
  final String? text;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(height: 12),
            Text(title, style: theme.textTheme.titleMedium, textAlign: TextAlign.center),
            if (text != null) ...[
              const SizedBox(height: 4),
              Text(text!, textAlign: TextAlign.center, style: TextStyle(color: theme.colorScheme.onSurfaceVariant)),
            ],
            if (action != null) ...[const SizedBox(height: 16), action!],
          ],
        ),
      ),
    );
  }
}
