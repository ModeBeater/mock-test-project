import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_palette.dart';

abstract final class AppTheme {
  /// [remoteFonts] = false — системный шрифт вместо Onest (тесты, офлайн-сборки).
  static ThemeData build(Brightness brightness, {bool remoteFonts = true}) {
    final p = brightness == Brightness.light ? AppPalette.light : AppPalette.dark;
    final scheme = ColorScheme(
      brightness: brightness,
      primary: p.ink,
      onPrimary: p.paper,
      secondary: p.accent,
      onSecondary: p.onAccent,
      error: p.danger,
      onError: p.paper,
      surface: p.paper,
      onSurface: p.ink,
      onSurfaceVariant: p.muted,
      outline: p.hairline,
      outlineVariant: p.hairline,
      surfaceContainerLowest: p.surface,
      surfaceContainerLow: p.surface,
      surfaceContainer: p.surface,
      surfaceContainerHigh: p.surface,
      surfaceContainerHighest: p.surface,
    );

    final base = ThemeData(brightness: brightness, colorScheme: scheme, useMaterial3: true);
    final text = (remoteFonts ? GoogleFonts.onestTextTheme(base.textTheme) : base.textTheme).apply(
      bodyColor: p.ink,
      displayColor: p.ink,
    );

    return base.copyWith(
      scaffoldBackgroundColor: p.paper,
      textTheme: text,
      extensions: [p],
      dividerTheme: DividerThemeData(color: p.hairline, thickness: 1, space: 1),
      splashFactory: InkSparkle.splashFactory,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: p.ink,
          textStyle: text.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: p.accent,
          foregroundColor: p.onAccent,
          disabledBackgroundColor: p.hairline,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: text.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        border: UnderlineInputBorder(borderSide: BorderSide(color: p.hairline)),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: p.hairline)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: p.ink, width: 1.5)),
        errorStyle: TextStyle(color: p.danger),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: p.surface,
        showDragHandle: true,
        dragHandleColor: p.hairline,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: p.ink,
        contentTextStyle: text.bodyMedium?.copyWith(color: p.paper),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: p.ink, linearTrackColor: Colors.transparent),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: p.surface,
        headerBackgroundColor: p.surface,
        todayBorder: BorderSide(color: p.ink),
        dayBackgroundColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? p.accent : null),
        dayForegroundColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? p.onAccent : null),
      ),
      timePickerTheme: TimePickerThemeData(backgroundColor: p.surface),
    );
  }
}
