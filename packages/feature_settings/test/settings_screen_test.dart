import 'package:core_ui/core_ui.dart';
import 'package:feature_settings/feature_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:platform_theme/platform_theme.dart';

class _MockStorage extends Mock implements Storage {}

void main() {
  setUp(() {
    final storage = _MockStorage();
    when(() => storage.read(any())).thenReturn(null);
    when(() => storage.write(any(), any<dynamic>())).thenAnswer((_) async {});
    when(() => storage.delete(any())).thenAnswer((_) async {});
    HydratedBloc.storage = storage;
    GetIt.instance.registerSingleton<ThemeModeCubit>(ThemeModeCubit());
  });

  tearDown(() => GetIt.instance.reset());

  Widget app(Locale locale) => MaterialApp(
        locale: locale,
        localizationsDelegates: const [
          settingsLocalizationsDelegate,
          coreUiLocalizationsDelegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('es')],
        home: Builder(
          builder: (context) => Theme(
            data: AppTheme.getLightTheme(context),
            child: const SettingsScreen(),
          ),
        ),
      );

  testWidgets('shows localized section titles', (tester) async {
    await tester.pumpWidget(app(const Locale('en')));

    expect(find.text('General'), findsOneWidget);
    expect(find.text('Report a bug'), findsOneWidget);
  });

  testWidgets('toggling the switch flips the theme mode cubit', (tester) async {
    await tester.pumpWidget(app(const Locale('en')));
    final cubit = GetIt.instance.get<ThemeModeCubit>();
    expect(cubit.state.isDarkMode, isFalse);

    await tester.tap(find.byType(Switch));

    expect(cubit.state.isDarkMode, isTrue);
  });
}
