import 'dart:convert';

import 'package:driver_diary/app/app.dart';
import 'package:driver_diary/app/dependencies.dart';
import 'package:driver_diary/core/time/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'helpers/fixtures.dart';

/// Фейковый сервер: 1 октября — пример из задания, остальные дни пустые.
class FakeServer {
  final posted = <Map<String, dynamic>>[];
  final _ids = <String>{};
  bool offline = false;

  Future<http.Response> handle(http.Request request) async {
    if (offline) throw http.ClientException('offline');
    final path = request.url.path;
    if (request.method == 'POST' && path == '/api/trips') {
      final body = jsonDecode(request.body) as Map<String, dynamic>;
      posted.add(body);
      return jsonResponse(body, _ids.add(body['id'] as String) ? 201 : 200);
    }
    if (path == '/api/days') {
      return jsonResponse([
        {'date': '2026-10-01', 'trips_count': 2, 'net': 3315},
      ]);
    }
    final date = path.split('/').last;
    return jsonResponse(date == '2026-10-01' ? exampleDayJson : emptyDayJson(date));
  }
}

void main() {
  setUpAll(() => initializeDateFormatting('ru'));

  late FakeServer server;

  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    server = FakeServer();
    await tester.pumpWidget(DriverDiaryApp(
      remoteFonts: false,
      dependencies: AppDependencies(
        apiBaseUrl: Uri.parse('http://test'),
        httpClient: MockClient(server.handle),
        clock: Clock(() => DateTime(2026, 10, 1, 12, 0)),
      ),
    ));
    await tester.pumpAndSettle();
  }

  String textOf(WidgetTester tester, String key) => tester.widget<Text>(find.byKey(Key(key))).data!;

  testWidgets('сводка и лента поездок', (tester) async {
    await pumpApp(tester);

    expect(textOf(tester, 'week-range'), '28 сентября – 4 октября');
    expect(textOf(tester, 'selected-day'), 'Четверг, 1 октября');
    expect(textOf(tester, 'summary-net'), '3 315 ₸');
    expect(textOf(tester, 'summary-revenue'), '3 900 ₸');
    expect(textOf(tester, 'summary-cash'), '1 500 ₸');
    expect(textOf(tester, 'summary-card'), '2 400 ₸');
    expect(find.text('08:10'), findsOneWidget);
    expect(find.text('без заказа 33 мин'), findsOneWidget);
  });

  testWidgets('полоса «наличные / безнал» пропорциональна выручке', (tester) async {
    await pumpApp(tester);

    final cash = tester.getSize(find.byKey(const Key('split-cash')));
    final card = tester.getSize(find.byKey(const Key('split-card')));

    expect(cash.height, 6);
    expect(cash.width / card.width, closeTo(1500 / 2400, 0.01));
  });

  testWidgets('переключение дней и переход к последней смене', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.byKey(const ValueKey('day-2026-10-02')));
    await tester.pumpAndSettle();

    expect(textOf(tester, 'selected-day'), 'Пятница, 2 октября');
    expect(find.text('Поездок нет'), findsOneWidget);

    await tester.tap(find.textContaining('Последняя смена — 1 октября'));
    await tester.pumpAndSettle();

    expect(textOf(tester, 'selected-day'), 'Четверг, 1 октября');

    await tester.tap(find.byTooltip('Предыдущая неделя'));
    await tester.pumpAndSettle();

    expect(textOf(tester, 'week-range'), '21 – 27 сентября');
  });

  testWidgets('добавление поездки: после ошибки сети повтор уходит с тем же id', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Добавить поездку'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('amount')), '2000');
    await tester.pump();
    expect(find.widgetWithText(TextField, '300'), findsOneWidget, reason: 'комиссия 15% подставляется сама');

    server.offline = true;
    await tester.tap(find.text('Сохранить'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Нет связи с сервером'), findsOneWidget);

    server.offline = false;
    await tester.tap(find.text('Сохранить'));
    await tester.pumpAndSettle();
    expect(find.text('Поездка добавлена'), findsOneWidget);

    expect(server.posted, [
      {
        'id': server.posted.single['id'],
        'start': '2026-10-01T11:40:00+05:00',
        'end': '2026-10-01T12:00:00+05:00',
        'amount': 2000,
        'payment': 'card',
        'commission': 300,
      },
    ]);
  });

  testWidgets('форма не отправляет некорректные данные', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Добавить поездку'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('amount')), '0');
    await tester.tap(find.text('Сохранить'));
    await tester.pumpAndSettle();

    expect(find.text('Сумма должна быть больше нуля'), findsOneWidget);
    expect(server.posted, isEmpty);
  });
}
