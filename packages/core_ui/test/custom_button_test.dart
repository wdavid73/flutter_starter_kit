import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(Widget child, {Locale locale = const Locale('en')}) => MaterialApp(
      locale: locale,
      localizationsDelegates: const [
        coreUiLocalizationsDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('es')],
      home: Scaffold(body: child),
    );

void main() {
  testWidgets('shows its label and calls onPressed', (tester) async {
    var pressed = 0;
    await tester.pumpWidget(
      _app(CustomButton(label: 'Save', onPressed: () => pressed++)),
    );

    await tester.tap(find.text('Save'));

    expect(pressed, 1);
  });

  testWidgets('shows the localized loading text and ignores taps',
      (tester) async {
    var pressed = 0;
    await tester.pumpWidget(
      _app(
        CustomButton(label: 'Save', isLoading: true, onPressed: () => pressed++),
        locale: const Locale('es'),
      ),
    );

    expect(find.text('Cargando...'), findsOneWidget);
    await tester.tap(find.text('Cargando...'));
    expect(pressed, 0);
  });
}
