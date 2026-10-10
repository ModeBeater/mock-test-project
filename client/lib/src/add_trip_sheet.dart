import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

import 'api.dart';
import 'format.dart';
import 'models.dart';
import 'summary_card.dart';

/// Комиссия по умолчанию — как в исходных данных (15%).
const defaultCommissionRate = 0.15;

/// Самая длинная поездка, которую примет форма: защищает от опечатки,
/// когда «окончание раньше начала» превращается в поездку почти на сутки.
const maxTripDuration = Duration(hours: 12);

Future<CreateTripResult?> showAddTripSheet(
  BuildContext context, {
  required DateTime day,
  required DateTime today,
  required Duration utcOffset,
  required Future<CreateTripResult> Function(NewTrip trip) onSubmit,
  Trip? previousTrip,
  DateTime Function() clock = DateTime.now,
}) {
  return showModalBottomSheet<CreateTripResult>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: AddTripSheet(
        day: day,
        today: today,
        utcOffset: utcOffset,
        onSubmit: onSubmit,
        previousTrip: previousTrip,
        clock: clock,
      ),
    ),
  );
}

class AddTripSheet extends StatefulWidget {
  const AddTripSheet({
    super.key,
    required this.day,
    required this.today,
    required this.utcOffset,
    required this.onSubmit,
    this.previousTrip,
    this.clock = DateTime.now,
  });

  final DateTime day;
  final DateTime today;
  final Duration utcOffset;
  final Future<CreateTripResult> Function(NewTrip trip) onSubmit;

  /// Последняя поездка дня: новая по умолчанию начинается после неё.
  final Trip? previousTrip;
  final DateTime Function() clock;

  @override
  State<AddTripSheet> createState() => _AddTripSheetState();
}

class _AddTripSheetState extends State<AddTripSheet> {
  // Один id на всю форму: повторное нажатие «Сохранить» после сетевой ошибки
  // отправит ту же поездку, и сервер не создаст дубль.
  final _tripId = const Uuid().v4();
  final _formKey = GlobalKey<FormState>();
  final _amount = TextEditingController();
  final _commission = TextEditingController();

  late DateTime _day = widget.day;
  late TimeOfDay _start;
  late TimeOfDay _end;
  PaymentMethod _payment = PaymentMethod.card;
  bool _commissionEdited = false;
  bool _submitting = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.day == widget.today) {
      // Поездку обычно записывают сразу после неё: окончание — сейчас.
      final now = widget.clock();
      _end = TimeOfDay(hour: now.hour, minute: now.minute);
      _start = _shift(_end, -20);
    } else {
      final prev = widget.previousTrip?.end.wall;
      _start = prev == null ? const TimeOfDay(hour: 9, minute: 0) : TimeOfDay(hour: prev.hour, minute: prev.minute);
      _end = _shift(_start, 20);
    }
    _amount.addListener(_suggestCommission);
  }

  @override
  void dispose() {
    _amount.dispose();
    _commission.dispose();
    super.dispose();
  }

  static TimeOfDay _shift(TimeOfDay t, int minutes) {
    final total = (t.hour * 60 + t.minute + minutes) % (24 * 60);
    return TimeOfDay(hour: total ~/ 60, minute: total % 60);
  }

  void _suggestCommission() {
    if (_commissionEdited) return;
    final amount = int.tryParse(_amount.text);
    _commission.text = amount == null ? '' : (amount * defaultCommissionRate).round().toString();
  }

  DateTime _wall(DateTime day, TimeOfDay t) => DateTime.utc(day.year, day.month, day.day, t.hour, t.minute);

  /// Начало и окончание; если окончание «раньше» начала — поездка закончилась после полуночи.
  (DateTime, DateTime) get _interval {
    final start = _wall(_day, _start);
    var end = _wall(_day, _end);
    if (end.isBefore(start)) end = end.add(const Duration(days: 1));
    return (start, end);
  }

  String? get _timeError {
    final (start, end) = _interval;
    if (!end.isAfter(start)) return 'Окончание должно быть позже начала';
    if (end.difference(start) > maxTripDuration) return 'Поездка дольше 12 часов — проверьте время';
    return null;
  }

  Future<void> _pickDay() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _day,
      firstDate: DateTime(2020),
      lastDate: widget.today.add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _day = dateOnly(picked));
  }

  Future<void> _pickTime({required bool start}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: start ? _start : _end,
      initialEntryMode: TimePickerEntryMode.input,
      helpText: start ? 'Начало поездки' : 'Окончание поездки',
    );
    if (picked == null) return;
    setState(() {
      if (start) {
        _start = picked;
      } else {
        _end = picked;
      }
    });
  }

  Future<void> _submit() async {
    final formValid = _formKey.currentState!.validate();
    if (!formValid || _timeError != null) {
      setState(() {});
      return;
    }

    final (start, end) = _interval;
    final offset = widget.utcOffset;
    final trip = NewTrip(
      id: _tripId,
      // wall — время «на часах» водителя; переводим в момент времени, вычитая смещение.
      start: ZonedDateTime(start.subtract(offset), offset),
      end: ZonedDateTime(end.subtract(offset), offset),
      amount: int.parse(_amount.text),
      payment: _payment,
      commission: int.parse(_commission.text),
    );

    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      final result = await widget.onSubmit(trip);
      if (mounted) Navigator.of(context).pop(result);
    } on TripConflictException catch (e) {
      final existing = '${formatTimeRange(e.existing)}, ${formatMoney(e.existing.amount)}';
      setState(() => _error = switch (e.code) {
            'trip_overlap' => 'Пересекается с другой поездкой: $existing',
            _ => 'Эта поездка уже сохранена с другими данными: $existing',
          });
    } on ApiException catch (e) {
      setState(() => _error = '$e. Можно нажать «Сохранить» ещё раз — дубль не появится.');
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final timeError = _timeError;
    final (start, end) = _interval;
    final nextDay = timeError == null && end.day != start.day;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Новая поездка', style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _pickDay,
              icon: const Icon(Icons.event),
              label: Text(
                '${formatRelativeDay(_day, today: widget.today)}, ${formatDay(_day, today: widget.today)}',
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _TimeField(label: 'Начало', time: _start, onTap: () => _pickTime(start: true)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _TimeField(
                    label: nextDay ? 'Окончание (+1 день)' : 'Окончание',
                    time: _end,
                    onTap: () => _pickTime(start: false),
                  ),
                ),
              ],
            ),
            if (timeError != null)
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 12),
                child: Text(timeError, style: TextStyle(color: theme.colorScheme.error)),
              ),
            const SizedBox(height: 16),
            TextFormField(
              key: const Key('amount'),
              controller: _amount,
              autofocus: true,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(9)],
              decoration: const InputDecoration(labelText: 'Сумма', suffixText: '₸', border: OutlineInputBorder()),
              validator: (v) {
                final amount = int.tryParse(v ?? '');
                if (amount == null) return 'Укажите сумму';
                if (amount <= 0) return 'Сумма должна быть больше 0';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              key: const Key('commission'),
              controller: _commission,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(9)],
              onChanged: (_) => _commissionEdited = true,
              decoration: const InputDecoration(
                labelText: 'Комиссия',
                suffixText: '₸',
                helperText: 'Подставляется 15% от суммы, можно изменить',
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                final commission = int.tryParse(v ?? '');
                if (commission == null) return 'Укажите комиссию';
                final amount = int.tryParse(_amount.text);
                if (amount != null && commission > amount) return 'Комиссия больше суммы поездки';
                return null;
              },
            ),
            const SizedBox(height: 16),
            SegmentedButton<PaymentMethod>(
              segments: [
                for (final method in PaymentMethod.values)
                  ButtonSegment(value: method, label: Text(method.label), icon: Icon(paymentIcon(method))),
              ],
              selected: {_payment},
              onSelectionChanged: (s) => setState(() => _payment = s.single),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(_error!, key: const Key('submit-error'), style: TextStyle(color: theme.colorScheme.error)),
              ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _submitting ? null : _submit,
              style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
              child: _submitting
                  ? const SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeField extends StatelessWidget {
  const _TimeField({required this.label, required this.time, required this.onTap});

  final String label;
  final TimeOfDay time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.schedule),
        ),
        child: Text(
          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
