import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'src/api.dart';
import 'src/diary_controller.dart';
import 'src/diary_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ru');
  Intl.defaultLocale = 'ru';
  runApp(DriverDiaryApp(api: DiaryApi(baseUrl: defaultApiUrl())));
}

class DriverDiaryApp extends StatefulWidget {
  const DriverDiaryApp({super.key, required this.api, this.clock = DateTime.now});

  final DiaryApi api;
  final DateTime Function() clock;

  @override
  State<DriverDiaryApp> createState() => _DriverDiaryAppState();
}

class _DriverDiaryAppState extends State<DriverDiaryApp> {
  late final controller = DiaryController(widget.api, clock: widget.clock)..start();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  ThemeData _theme(Brightness brightness) => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00796B), brightness: brightness),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Дневник смен водителя',
      debugShowCheckedModeBanner: false,
      theme: _theme(Brightness.light),
      darkTheme: _theme(Brightness.dark),
      locale: const Locale('ru'),
      supportedLocales: const [Locale('ru')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      home: DiaryScreen(controller: controller, clock: widget.clock),
    );
  }
}
