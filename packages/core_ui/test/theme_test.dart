import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('light and dark themes build with the packaged font',
      (tester) async {
    late ThemeData light;
    late ThemeData dark;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            light = AppTheme.getLightTheme(context);
            dark = AppTheme.getDarkTheme(context);
            return const SizedBox();
          },
        ),
      ),
    );

    expect(light.brightness, Brightness.light);
    expect(dark.brightness, Brightness.dark);
    expect(AppTypography.fontFamily, 'packages/core_ui/MontserratAlternates');
  });

  test('AppSpacing.vertical builds a SizedBox of the given height', () {
    final spacing = AppSpacing.vertical(12) as SizedBox;

    expect(spacing.height, 12);
  });
}
