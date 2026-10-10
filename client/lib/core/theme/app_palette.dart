import 'package:flutter/material.dart';

/// Цвета приложения. Палитра «бумага и чернила» с одним акцентом — жёлтым, как у такси.
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.paper,
    required this.surface,
    required this.ink,
    required this.muted,
    required this.hairline,
    required this.barIdle,
    required this.accent,
    required this.onAccent,
    required this.danger,
  });

  static const light = AppPalette(
    paper: Color(0xFFF4F2EC),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF141414),
    muted: Color(0xFF75736C),
    hairline: Color(0xFFE2DFD6),
    barIdle: Color(0xFFCFCBC0),
    accent: Color(0xFFFFCE1F),
    onAccent: Color(0xFF141414),
    danger: Color(0xFFB8402A),
  );

  static const dark = AppPalette(
    paper: Color(0xFF0F0F0E),
    surface: Color(0xFF1A1A18),
    ink: Color(0xFFF1EFE8),
    muted: Color(0xFF8E8C85),
    hairline: Color(0xFF2A2926),
    barIdle: Color(0xFF3B3A36),
    accent: Color(0xFFFFCE1F),
    onAccent: Color(0xFF141414),
    danger: Color(0xFFFF8A70),
  );

  /// Фон экрана.
  final Color paper;

  /// Фон листов и полей ввода.
  final Color surface;
  final Color ink;
  final Color muted;
  final Color hairline;

  /// Столбики дней в недельной полосе, кроме выбранного.
  final Color barIdle;
  final Color accent;
  final Color onAccent;
  final Color danger;

  @override
  AppPalette copyWith({
    Color? paper,
    Color? surface,
    Color? ink,
    Color? muted,
    Color? hairline,
    Color? barIdle,
    Color? accent,
    Color? onAccent,
    Color? danger,
  }) =>
      AppPalette(
        paper: paper ?? this.paper,
        surface: surface ?? this.surface,
        ink: ink ?? this.ink,
        muted: muted ?? this.muted,
        hairline: hairline ?? this.hairline,
        barIdle: barIdle ?? this.barIdle,
        accent: accent ?? this.accent,
        onAccent: onAccent ?? this.onAccent,
        danger: danger ?? this.danger,
      );

  @override
  AppPalette lerp(AppPalette? other, double t) {
    if (other == null) return this;
    return AppPalette(
      paper: Color.lerp(paper, other.paper, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      hairline: Color.lerp(hairline, other.hairline, t)!,
      barIdle: Color.lerp(barIdle, other.barIdle, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
    );
  }
}

extension AppThemeContext on BuildContext {
  AppPalette get palette => Theme.of(this).extension<AppPalette>()!;

  /// Цифры одинаковой ширины: суммы и время выравниваются в колонках.
  TextStyle numbers(TextStyle? base) =>
      (base ?? const TextStyle()).copyWith(fontFeatures: const [FontFeature.tabularFigures()]);
}
