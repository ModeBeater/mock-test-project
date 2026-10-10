import 'dart:convert';

import 'package:driver_diary/main.dart';
import 'package:driver_diary/src/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'fixtures.dart';

/// Фейковый сервер: 1 октября — пример из задания, остальные дни пустые.
class FakeServer {
  final posted = <Map<String, dynamic>>[];
  final knownIds = <String>{};
  bool offline = false;

  Future<http.Response> handle(http.Request request) async {
    if (offline) throw http.ClientException('offline');
    final path = request.url.path;
    if (request.method == 'POST' && path == '/api/trips') {
      final body = jsonDecode(request.body) as Map<String, dynamic>;
      posted.add(body);
      final created = knownIds.add(body['id'] as String);
      return _json(body, created ? 201 : 200);
    }
    if (path == '/api/days') return _json([{'date': '2026-10-01', 'trips_count': 2}]);
    final date = path.split('/').last;
    return _json(date == '2026-10-01' ? exampleDay : emptyDay(date));
  }

  http.Response _json(Object body, [int status = 200]) => http.Response.bytes(utf8.encode(jsonEncode(body)), status);
}

void main() {
  setUpAll(() => initializeDateFormatting('ru'));

  late FakeServer server;

  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    server = FakeServer();
    await tester.pumpWidget(DriverDiaryApp(
      api: DiaryApi(baseUrl: Uri.parse('http://test'), client: MockClient(server.handle)),
      clock: () => DateTime(2026, 10, 1, 12, 0),
    ));
    await tester.pumpAndSettle();
  }

  testWidgets('показывает сводку и поездки дня', (tester) async {
    await pumpApp(tester);

    expect(find.text('1 октября'), findsOneWidget);
    expect(find.text('Сегодня'), findsOneWidget);
    expect(tester.widget<Text>(find.byKey(const Key('summary-net'))).data, '3 315 ₸');
    expect(tester.widget<Text>(find.byKey(const Key('summary-cash'))).data, '1 500 ₸');
    expect(tester.widget<Text>(find.byKey(const Key('summary-card'))).data, '2 400 ₸');
    expect(find.text('08:10 – 08:32'), findsOneWidget);
    expect(find.text('22 мин · Карта'), findsOneWidget);
    expect(find.text('смена 08:10 – 09:20'), findsOneWidget);
  });

  testWidgets('полоса «наличные / карта» пропорциональна выручке', (tester) async {
    await pumpApp(tester);

    final cash = tester.getSize(find.byKey(const Key('split-cash')));
    final card = tester.getSize(find.byKey(const Key('split-card')));

    expect(cash.height, 8);
    expect(card.height, 8);
    expect(cash.width / card.width, closeTo(1500 / 2400, 0.01));
  });

  testWidgets('переключение дней', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.byTooltip('Следующий день'));
    await tester.pumpAndSettle();

    expect(find.text('2 октября'), findsOneWidget);
    expect(find.text('Завтра'), findsOneWidget);
    expect(find.text('В этот день поездок нет'), findsOneWidget);

    expect(find.text('Последние поездки — 1 октября'), findsOneWidget);
    await tester.tap(find.text('Перейти'));
    await tester.pumpAndSettle();

    expect(find.text('1 октября'), findsOneWidget);
    expect(find.text('08:10 – 08:32'), findsOneWidget);
  });

  testWidgets('добавление поездки; повтор после ошибки сети уходит с тем же id', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Поездка'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('amount')), '2000');
    await tester.pump();
    expect(find.widgetWithText(TextFormField, '300'), findsOneWidget, reason: 'комиссия 15% подставляется сама');

    server.offline = true;
    await tester.tap(find.text('Сохранить'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Нет связи с сервером'), findsOneWidget);

    server.offline = false;
    await tester.tap(find.text('Сохранить'));
    await tester.pumpAndSettle();
    expect(find.text('Поездка добавлена'), findsOneWidget);

    expect(server.posted, hasLength(1));
    expect(server.posted.single, containsPair('start', '2026-10-01T11:40:00+05:00'));
    expect(server.posted.single, containsPair('end', '2026-10-01T12:00:00+05:00'));
    expect(server.posted.single, containsPair('amount', 2000));
    expect(server.posted.single, containsPair('commission', 300));
    expect(server.posted.single, containsPair('payment', 'card'));
  });

  testWidgets('форма не отправляет некорректные данные', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Поездка'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('amount')), '0');
    await tester.tap(find.text('Сохранить'));
    await tester.pumpAndSettle();

    expect(find.text('Сумма должна быть больше 0'), findsOneWidget);
    expect(server.posted, isEmpty);
  });
}
