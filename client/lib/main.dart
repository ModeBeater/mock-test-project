import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'app/app.dart';
import 'app/dependencies.dart';
import 'core/network/api_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ru');
  Intl.defaultLocale = 'ru';
  runApp(DriverDiaryApp(dependencies: AppDependencies(apiBaseUrl: defaultApiBaseUrl())));
}
