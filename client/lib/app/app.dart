import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/theme/app_theme.dart';
import '../features/diary/presentation/bloc/diary_bloc.dart';
import '../features/diary/presentation/pages/diary_page.dart';
import 'dependencies.dart';

class DriverDiaryApp extends StatelessWidget {
  const DriverDiaryApp({super.key, required this.dependencies, this.remoteFonts = true});

  final AppDependencies dependencies;

  /// false — без загрузки шрифта из Google Fonts (тесты).
  final bool remoteFonts;

  @override
  Widget build(BuildContext context) {
    final deps = dependencies;
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: deps.clock),
        RepositoryProvider.value(value: deps.submitTrip),
      ],
      child: BlocProvider(
        create: (_) => DiaryBloc(getDayReport: deps.getDayReport, getWorkDays: deps.getWorkDays, clock: deps.clock)
          ..add(const DiaryEvent.started()),
        child: MaterialApp(
          title: 'Дневник смен',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.build(Brightness.light, remoteFonts: remoteFonts),
          darkTheme: AppTheme.build(Brightness.dark, remoteFonts: remoteFonts),
          locale: const Locale('ru'),
          supportedLocales: const [Locale('ru')],
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          home: const DiaryPage(),
        ),
      ),
    );
  }
}
