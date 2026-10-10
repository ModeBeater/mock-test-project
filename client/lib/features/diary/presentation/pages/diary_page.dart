import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/failure_message.dart';
import '../../../../core/format/formatters.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/time/clock.dart';
import '../../../trip_entry/domain/entities/trip_draft.dart';
import '../../../trip_entry/domain/entities/trip_entry_outcome.dart';
import '../../../trip_entry/presentation/widgets/trip_entry_sheet.dart';
import '../bloc/diary_bloc.dart';
import '../widgets/earnings_summary.dart';
import '../widgets/trip_timeline.dart';
import '../widgets/week_strip.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({super.key});

  static const _maxContentWidth = 560.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiaryBloc, DiaryState>(
      builder: (context, state) {
        final bloc = context.read<DiaryBloc>();
        return Scaffold(
          body: SafeArea(
            bottom: false,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: _maxContentWidth),
                child: Column(
                  children: [
                    _WeekHeader(state: state),
                    WeekStrip(
                      days: state.week,
                      selected: state.selectedDay,
                      today: state.today,
                      netOf: (d) => state.workDayOf(d)?.net,
                      onSelect: (d) => bloc.add(DiaryEvent.daySelected(d)),
                      onShiftWeek: (w) => bloc.add(DiaryEvent.dayShifted(7 * w)),
                    ),
                    SizedBox(
                      height: 2,
                      child: state.status == DiaryStatus.loading && state.report != null
                          ? const LinearProgressIndicator(minHeight: 2)
                          : null,
                    ),
                    const Divider(),
                    Expanded(child: _DayBody(state: state)),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: _AddTripBar(onPressed: state.utcOffset == null ? null : () => _addTrip(context, state)),
        );
      },
    );
  }

  Future<void> _addTrip(BuildContext context, DiaryState state) async {
    final bloc = context.read<DiaryBloc>();
    final messenger = ScaffoldMessenger.of(context);
    final lastEnd = state.report?.trips.lastOrNull?.end.wall;
    final time = suggestTripTime(
      isToday: state.selectedDay == state.today,
      now: context.read<Clock>().now(),
      previousTripEndMinute: lastEnd == null ? null : lastEnd.hour * 60 + lastEnd.minute,
    );
    final draft = TripDraft(
      id: const Uuid().v4(),
      day: state.selectedDay,
      startMinute: time.start,
      endMinute: time.end,
      utcOffset: state.utcOffset!,
    );

    final outcome = await TripEntrySheet.show(context, draft: draft, today: state.today);
    final (trip, message) = switch (outcome) {
      TripCreated(:final trip) => (trip, 'Поездка добавлена'),
      TripAlreadySaved(:final trip) => (trip, 'Эта поездка уже была сохранена — дубль не создан'),
      _ => (null, null),
    };
    if (trip == null) return;
    bloc.add(DiaryEvent.tripSaved(trip));
    messenger.showSnackBar(SnackBar(content: Text(message!)));
  }
}

class _WeekHeader extends StatelessWidget {
  const _WeekHeader({required this.state});

  final DiaryState state;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final text = Theme.of(context).textTheme;
    final bloc = context.read<DiaryBloc>();
    final week = state.week;
    final weekNet = week.fold(0, (sum, d) => sum + (state.workDayOf(d)?.net ?? 0));

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Предыдущая неделя',
            onPressed: () => bloc.add(const DiaryEvent.dayShifted(-7)),
            icon: const Icon(Icons.chevron_left),
          ),
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => _pickDay(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  children: [
                    Text(
                      formatWeekRange(week.first, week.last, today: state.today),
                      key: const Key('week-range'),
                      style: text.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'за неделю ${formatMoney(weekNet)}',
                      style: context.numbers(text.bodySmall).copyWith(color: p.muted),
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            tooltip: 'Следующая неделя',
            onPressed: () => bloc.add(const DiaryEvent.dayShifted(7)),
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDay(BuildContext context) async {
    final bloc = context.read<DiaryBloc>();
    final picked = await showDatePicker(
      context: context,
      initialDate: state.selectedDay,
      firstDate: DateTime(2020),
      lastDate: state.today.add(const Duration(days: 365)),
    );
    if (picked != null) bloc.add(DiaryEvent.daySelected(picked));
  }
}

class _DayBody extends StatelessWidget {
  const _DayBody({required this.state});

  final DiaryState state;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DiaryBloc>();
    final report = state.report;

    if (report == null) {
      if (state.status == DiaryStatus.failure) {
        return _Notice(
          title: 'Не удалось загрузить день',
          text: state.failure!.message,
          action: TextButton(onPressed: () => bloc.add(const DiaryEvent.refreshed()), child: const Text('Повторить')),
        );
      }
      return const Center(child: SizedBox.square(dimension: 24, child: CircularProgressIndicator(strokeWidth: 2)));
    }

    final p = context.palette;
    final text = Theme.of(context).textTheme;
    final shiftStart = report.shiftStart;
    final lastWorkDay = state.lastWorkDay;

    return GestureDetector(
      // Свайп по содержимому — соседний день.
      onHorizontalDragEnd: (d) {
        final v = d.primaryVelocity ?? 0;
        if (v.abs() > 300) bloc.add(DiaryEvent.dayShifted(v > 0 ? -1 : 1));
      },
      child: RefreshIndicator(
        color: p.ink,
        onRefresh: () async {
          bloc.add(const DiaryEvent.refreshed());
          await bloc.stream.firstWhere((s) => s.status != DiaryStatus.loading);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 20, bottom: 24),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formatDayTitle(state.selectedDay, today: state.today),
                          key: const Key('selected-day'),
                          style: text.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        if (shiftStart != null)
                          Text(
                            'смена ${formatTime(shiftStart)} – ${formatTime(report.shiftEnd!)} · '
                            '${formatDuration(report.shiftDuration!)}',
                            style: context.numbers(text.bodySmall).copyWith(color: p.muted),
                          ),
                      ],
                    ),
                  ),
                  if (state.selectedDay != state.today)
                    TextButton(
                      onPressed: () => bloc.add(DiaryEvent.daySelected(state.today)),
                      child: const Text('Сегодня'),
                    ),
                ],
              ),
            ),
            if (state.status == DiaryStatus.failure)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: Text('Не удалось обновить: ${state.failure!.message}', style: TextStyle(color: p.danger)),
              ),
            const SizedBox(height: 16),
            if (report.isEmpty)
              _Notice(
                title: 'Поездок нет',
                text: state.selectedDay.isAfter(state.today) ? 'Этот день ещё не наступил' : 'Смены в этот день не было',
                alignStart: true,
                action: lastWorkDay != null && lastWorkDay != state.selectedDay
                    ? TextButton.icon(
                        onPressed: () => bloc.add(DiaryEvent.daySelected(lastWorkDay)),
                        iconAlignment: IconAlignment.end,
                        icon: const Icon(Icons.arrow_forward, size: 18),
                        label: Text('Последняя смена — ${formatDayMonth(lastWorkDay, today: state.today)}'),
                      )
                    : null,
              )
            else ...[
              EarningsSummary(report: report),
              const SizedBox(height: 32),
              TripTimeline(trips: report.trips),
            ],
          ],
        ),
      ),
    );
  }
}

class _Notice extends StatelessWidget {
  const _Notice({required this.title, required this.text, this.action, this.alignStart = false});

  final String title;
  final String text;
  final Widget? action;
  final bool alignStart;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final theme = Theme.of(context).textTheme;
    final align = alignStart ? CrossAxisAlignment.start : CrossAxisAlignment.center;
    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: align,
        children: [
          Text(title, style: theme.headlineSmall?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(text, style: theme.bodyMedium?.copyWith(color: p.muted)),
          if (action != null) ...[
            const SizedBox(height: 12),
            // Кнопка-ссылка: прижимаем к тексту, без отступов слева.
            Transform.translate(offset: Offset(alignStart ? -12 : 0, 0), child: action),
          ],
        ],
      ),
    );
    return alignStart ? content : Center(child: content);
  }
}

class _AddTripBar extends StatelessWidget {
  const _AddTripBar({required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(color: p.paper, border: Border(top: BorderSide(color: p.hairline))),
      child: SafeArea(
        top: false,
        child: Center(
          heightFactor: 1,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: DiaryPage._maxContentWidth),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              // Большая кнопка внизу — до неё легко дотянуться одной рукой, когда телефон в держателе.
              child: FilledButton.icon(
                onPressed: onPressed,
                icon: const Icon(Icons.add),
                label: const Text('Добавить поездку'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
