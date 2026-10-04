import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

Future<String?> _message(WidgetTester tester, Locale locale) async {
  String? result;
  await tester.pumpWidget(
    MaterialApp(
      locale: locale,
      localizationsDelegates: const [
        coreUiLocalizationsDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('es'), Locale('ja')],
      home: Builder(
        builder: (context) {
          result = context.coreUiL10n.validationMessage('is_required');
          return const SizedBox();
        },
      ),
    ),
  );
  return result;
}

void main() {
  testWidgets('translates validation keys in the current locale',
      (tester) async {
    expect(
        await _message(tester, const Locale('en')), 'This field is required');
    expect(await _message(tester, const Locale('es')), 'El campo es requerido');
  });

  testWidgets('falls back to English when the locale is not supported',
      (tester) async {
    expect(
        await _message(tester, const Locale('ja')), 'This field is required');
  });

  testWidgets('returns unknown keys unchanged and null for null',
      (tester) async {
    late CoreUiLocalizations l10n;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [coreUiLocalizationsDelegate],
        supportedLocales: const [Locale('en')],
        home: Builder(builder: (context) {
          l10n = context.coreUiL10n;
          return const SizedBox();
        }),
      ),
    );

    expect(l10n.validationMessage('custom_key'), 'custom_key');
    expect(l10n.validationMessage(null), isNull);
  });
}
