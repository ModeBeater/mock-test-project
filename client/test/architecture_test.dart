import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Правило зависимостей: domain не знает о Flutter, HTTP, data и presentation;
/// фичи не лезут друг в друга, кроме presentation → domain соседней фичи.
void main() {
  List<(String, String)> imports(bool Function(String path) where) => [
        for (final file in Directory('lib').listSync(recursive: true).whereType<File>())
          if (file.path.endsWith('.dart') && !file.path.endsWith('.g.dart') && !file.path.endsWith('.freezed.dart'))
            if (where(file.path))
              for (final line in file.readAsLinesSync())
                if (line.startsWith('import ')) (file.path, line),
      ];

  test('domain не зависит от Flutter, сети и внешних слоёв', () {
    final violations = imports((p) => p.contains('/domain/')).where((i) {
      final line = i.$2;
      return line.contains('package:flutter/') ||
          line.contains('package:http') ||
          line.contains('/data/') ||
          line.contains('/presentation/') ||
          line.contains('/network/');
    });

    expect(violations, isEmpty);
  });

  test('data не зависит от presentation', () {
    final violations = imports((p) => p.contains('/data/')).where((i) => i.$2.contains('/presentation/'));

    expect(violations, isEmpty);
  });

  test('фича diary использует trip_entry только через её domain и экран формы', () {
    final violations = imports((p) => p.contains('features/diary/')).where((i) {
      final line = i.$2;
      return line.contains('trip_entry/') &&
          !line.contains('trip_entry/domain/') &&
          !line.contains('trip_entry/presentation/widgets/trip_entry_sheet.dart');
    });

    expect(violations, isEmpty);
  });
}
