import 'package:flutter/foundation.dart';

import 'api.dart';
import 'models.dart';

/// Состояние экрана: выбранный день, его сводка и поездки.
class DiaryController extends ChangeNotifier {
  DiaryController(this.api, {DateTime Function()? clock})
      : _clock = clock ?? DateTime.now,
        day = dateOnly((clock ?? DateTime.now)());

  final DiaryApi api;
  final DateTime Function() _clock;

  DateTime day;

  /// Отчёт за [day]; null, пока день грузится впервые.
  DayReport? report;
  Object? error;
  bool loading = false;

  /// Дни, в которые были поездки, — чтобы с пустого дня можно было перейти к последнему рабочему.
  List<DayInfo> daysWithTrips = const [];

  /// Часовой пояс водителя, известен после первого ответа сервера.
  Duration? utcOffset;

  // Ответы на устаревшие запросы (пользователь быстро листает дни) игнорируем.
  int _generation = 0;

  DateTime get today => dateOnly(_clock());

  DateTime? get lastDayWithTrips => daysWithTrips.isEmpty ? null : daysWithTrips.last.date;

  Future<void> start() => Future.wait([load(), _loadDays()]);

  Future<void> load() async {
    final generation = ++_generation;
    final requested = day;
    loading = true;
    error = null;
    notifyListeners();
    try {
      final result = await api.fetchDay(requested);
      if (generation != _generation) return;
      report = result;
      utcOffset = result.utcOffset;
    } catch (e) {
      if (generation != _generation) return;
      error = e;
    } finally {
      if (generation == _generation) {
        loading = false;
        notifyListeners();
      }
    }
  }

  Future<void> goTo(DateTime newDay) {
    day = dateOnly(newDay);
    if (report?.date != day) report = null;
    return load();
  }

  Future<void> previousDay() => goTo(day.subtract(const Duration(days: 1)));

  Future<void> nextDay() => goTo(day.add(const Duration(days: 1)));

  Future<CreateTripResult> addTrip(NewTrip trip) async {
    final result = await api.createTrip(trip);
    await Future.wait([goTo(dateOnly(result.trip.start.wall)), _loadDays()]);
    return result;
  }

  Future<void> _loadDays() async {
    try {
      daysWithTrips = await api.fetchDays();
      notifyListeners();
    } catch (_) {
      // Не критично: без списка просто не покажем кнопку перехода к последнему дню.
    }
  }
}
