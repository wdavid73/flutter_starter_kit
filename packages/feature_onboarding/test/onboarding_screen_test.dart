import 'package:core_ui/core_ui.dart';
import 'package:feature_onboarding/feature_onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the first page with localized Skip and Done labels',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('es'),
        localizationsDelegates: const [
          onboardingLocalizationsDelegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('es')],
        home: Builder(
          builder: (context) => Theme(
            data: AppTheme.getLightTheme(context),
            child: const OnBoardingScreen(),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Tittle Section One'), findsOneWidget);
    expect(find.text('Saltar'), findsOneWidget);
  });
}
