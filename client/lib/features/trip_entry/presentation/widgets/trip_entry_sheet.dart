import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure_message.dart';
import '../../../../core/format/formatters.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/time/calendar.dart';
import '../../../../shared/domain/payment_method.dart';
import '../../domain/entities/trip_draft.dart';
import '../../domain/entities/trip_entry_outcome.dart';
import '../../domain/usecases/submit_trip.dart';
import '../bloc/trip_entry_bloc.dart';

/// Форма новой поездки. Возвращает [TripCreated] или [TripAlreadySaved], либо null, если форму закрыли.
class TripEntrySheet extends StatefulWidget {
  const TripEntrySheet({super.key, required this.today});

  final DateTime today;

  static Future<TripEntryOutcome?> show(BuildContext context, {required TripDraft draft, required DateTime today}) {
    final submitTrip = context.read<SubmitTrip>();
    return showModalBottomSheet<TripEntryOutcome>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => BlocProvider(
        create: (_) => TripEntryBloc(submitTrip: submitTrip, draft: draft),
        child: TripEntrySheet(today: today),
      ),
    );
  }

  @override
  State<TripEntrySheet> createState() => _TripEntrySheetState();
}

class _TripEntrySheetState extends State<TripEntrySheet> {
  final _amount = TextEditingController();
  final _commission = TextEditingController();

  @override
  void dispose() {
    _amount.dispose();
    _commission.dispose();
    super.dispose();
  }

  TripEntryBloc get _bloc => context.read<TripEntryBloc>();

  Future<void> _pickTime({required bool start}) async {
    final draft = _bloc.state.draft;
    final minute = start ? draft.startMinute : draft.endMinute;
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: minute ~/ 60, minute: minute % 60),
      initialEntryMode: TimePickerEntryMode.input,
      helpText: start ? 'Начало поездки' : 'Окончание поездки',
    );
    if (picked == null) return;
    final value = picked.hour * 60 + picked.minute;
    _bloc.add(start ? TripEntryEvent.startChanged(value) : TripEntryEvent.endChanged(value));
  }

  Future<void> _pickDay() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _bloc.state.draft.day,
      firstDate: DateTime(2020),
      lastDate: widget.today.add(const Duration(days: 365)),
    );
    if (picked != null) _bloc.add(TripEntryEvent.dayChanged(dateOnly(picked)));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TripEntryBloc, TripEntryState>(
          listenWhen: (a, b) => b.status == TripEntryStatus.done && a.status != b.status,
          listener: (context, state) => Navigator.of(context).pop(state.outcome),
        ),
        // Комиссию подставляет блок (15% от суммы) — переносим её в поле.
        BlocListener<TripEntryBloc, TripEntryState>(
          listenWhen: (a, b) => a.draft.commission != b.draft.commission && !b.commissionEdited,
          listener: (context, state) => _commission.text = state.draft.commission?.toString() ?? '',
        ),
      ],
      child: BlocBuilder<TripEntryBloc, TripEntryState>(
        builder: (context, state) {
          final p = context.palette;
          final text = Theme.of(context).textTheme;
          final errors = state.visibleErrors;
          final draft = state.draft;
          final submitting = state.status == TripEntryStatus.submitting;

          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Новая поездка', style: text.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  _AmountField(
                    controller: _amount,
                    error: _amountError(errors),
                    onChanged: (v) => _bloc.add(TripEntryEvent.amountChanged(int.tryParse(v))),
                  ),
                  const SizedBox(height: 20),
                  _PaymentToggle(
                    value: draft.payment,
                    onChanged: (m) => _bloc.add(TripEntryEvent.paymentChanged(m)),
                  ),
                  const SizedBox(height: 20),
                  _TimeRange(
                    draft: draft,
                    error: _timeError(errors),
                    onPickStart: () => _pickTime(start: true),
                    onPickEnd: () => _pickTime(start: false),
                  ),
                  const SizedBox(height: 8),
                  _Row(
                    label: 'Дата',
                    onTap: _pickDay,
                    child: Text(
                      formatDayTitle(draft.day, today: widget.today),
                      style: text.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  _Row(
                    label: 'Комиссия',
                    hint: 'по умолчанию 15%',
                    error: _commissionError(errors),
                    child: SizedBox(
                      width: 120,
                      child: TextField(
                        key: const Key('commission'),
                        controller: _commission,
                        textAlign: TextAlign.end,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(9)],
                        style: context.numbers(text.bodyLarge).copyWith(fontWeight: FontWeight.w500),
                        decoration: const InputDecoration(suffixText: ' ₸', border: InputBorder.none, isDense: true),
                        onChanged: (v) => _bloc.add(TripEntryEvent.commissionChanged(int.tryParse(v))),
                      ),
                    ),
                  ),
                  if (_submitError(state) case final message?)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(message, key: const Key('submit-error'), style: TextStyle(color: p.danger)),
                    ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: submitting ? null : () => _bloc.add(const TripEntryEvent.submitted()),
                    child: submitting
                        ? SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2, color: p.onAccent))
                        : const Text('Сохранить'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String? _amountError(Set<TripDraftError> e) {
    if (e.contains(TripDraftError.amountMissing)) return 'Укажите сумму';
    if (e.contains(TripDraftError.amountNotPositive)) return 'Сумма должна быть больше нуля';
    return null;
  }

  String? _commissionError(Set<TripDraftError> e) {
    if (e.contains(TripDraftError.commissionMissing)) return 'Укажите комиссию';
    if (e.contains(TripDraftError.commissionExceedsAmount)) return 'Комиссия больше суммы поездки';
    return null;
  }

  String? _timeError(Set<TripDraftError> e) {
    if (e.contains(TripDraftError.endNotAfterStart)) return 'Окончание должно быть позже начала';
    if (e.contains(TripDraftError.tooLong)) return 'Поездка дольше 12 часов — проверьте время';
    return null;
  }

  String? _submitError(TripEntryState state) {
    if (state.conflict case TripConflict(:final kind, :final existing)) {
      final trip = '${formatTime(existing.start)}–${formatTime(existing.end)}, ${formatMoney(existing.amount)}';
      return switch (kind) {
        ConflictKind.overlap => 'Пересекается с другой поездкой: $trip',
        ConflictKind.sameIdDifferentData => 'Эта поездка уже сохранена с другими данными: $trip',
      };
    }
    if (state.failure case final failure?) {
      return '${failure.message}. Нажмите «Сохранить» ещё раз — дубль не появится.';
    }
    return null;
  }
}

class _AmountField extends StatelessWidget {
  const _AmountField({required this.controller, required this.onChanged, this.error});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String? error;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final style = context.numbers(Theme.of(context).textTheme.displaySmall).copyWith(fontWeight: FontWeight.w700);
    return TextField(
      key: const Key('amount'),
      controller: controller,
      autofocus: true,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(9)],
      style: style,
      cursorColor: p.ink,
      decoration: InputDecoration(
        hintText: '0',
        hintStyle: style.copyWith(color: p.hairline),
        suffixText: '₸',
        suffixStyle: style.copyWith(color: p.muted),
        labelText: 'Сумма',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(color: p.muted),
        errorText: error,
      ),
      onChanged: onChanged,
    );
  }
}

/// Наличные / безнал: две большие кнопки — по ним легко попасть, не глядя.
class _PaymentToggle extends StatelessWidget {
  const _PaymentToggle({required this.value, required this.onChanged});

  final PaymentMethod value;
  final ValueChanged<PaymentMethod> onChanged;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final text = Theme.of(context).textTheme;
    return Row(
      children: [
        for (final (i, method) in PaymentMethod.values.indexed) ...[
          if (i > 0) const SizedBox(width: 8),
          Expanded(
            child: Semantics(
              button: true,
              selected: method == value,
              child: Material(
                color: method == value ? p.ink : Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: method == value ? p.ink : p.hairline),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => onChanged(method),
                  child: SizedBox(
                    height: 48,
                    child: Center(
                      child: Text(
                        method.label,
                        style: text.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: method == value ? p.paper : p.ink,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _TimeRange extends StatelessWidget {
  const _TimeRange({required this.draft, required this.onPickStart, required this.onPickEnd, this.error});

  final TripDraft draft;
  final VoidCallback onPickStart;
  final VoidCallback onPickEnd;
  final String? error;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final text = Theme.of(context).textTheme;
    final caption = error ??
        (draft.endsNextDay
            ? '${formatDuration(draft.duration)} · окончание на следующий день'
            : formatDuration(draft.duration));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: _TimeBox(label: 'Начало', minute: draft.startMinute, onTap: onPickStart)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.arrow_forward, size: 18, color: p.muted),
            ),
            Expanded(child: _TimeBox(label: 'Окончание', minute: draft.endMinute, onTap: onPickEnd)),
          ],
        ),
        const SizedBox(height: 6),
        Text(caption, style: text.bodySmall?.copyWith(color: error == null ? p.muted : p.danger)),
      ],
    );
  }
}

class _TimeBox extends StatelessWidget {
  const _TimeBox({required this.label, required this.minute, required this.onTap});

  final String label;
  final int minute;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final text = Theme.of(context).textTheme;
    final time = '${(minute ~/ 60).toString().padLeft(2, '0')}:${(minute % 60).toString().padLeft(2, '0')}';
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(border: Border.all(color: p.hairline), borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: text.labelSmall?.copyWith(color: p.muted)),
            Text(time, style: context.numbers(text.titleLarge).copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

/// Строка «подпись — значение» с тонкой линией снизу.
class _Row extends StatelessWidget {
  const _Row({required this.label, required this.child, this.hint, this.error, this.onTap});

  final String label;
  final Widget child;
  final String? hint;
  final String? error;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final text = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 56),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: p.hairline))),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(label, style: text.bodyLarge),
                  if (error != null)
                    Text(error!, style: text.bodySmall?.copyWith(color: p.danger))
                  else if (hint != null)
                    Text(hint!, style: text.bodySmall?.copyWith(color: p.muted)),
                ],
              ),
            ),
            child,
            if (onTap != null) Icon(Icons.chevron_right, color: p.muted),
          ],
        ),
      ),
    );
  }
}
