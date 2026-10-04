import 'package:core_ui/core_ui.dart';
import 'package:feature_auth/feature_auth.dart';
import 'package:feature_home/feature_home.dart';
import 'package:feature_onboarding/feature_onboarding.dart';
import 'package:feature_settings/feature_settings.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final packageLocales = <String, List<Locale>>{
    'core_ui': coreUiSupportedLocales,
    'feature_auth': authSupportedLocales,
    'feature_home': homeSupportedLocales,
    'feature_onboarding': onboardingSupportedLocales,
    'feature_settings': settingsSupportedLocales,
  };

  group('supported locales', () {
    for (final entry in packageLocales.entries) {
      test('include every locale translated by ${entry.key}', () {
        for (final locale in entry.value) {
          expect(
            appSupportedLocales,
            contains(locale),
            reason: '${entry.key} translates $locale but the app does not '
                'list it in supportedLocales',
          );
        }
      });
    }

    test('include the app own locales', () {
      expect(appSupportedLocales, containsAll(AppLocalizations.supportedLocales));
    });
  });

  group('delegates', () {
    test('every delegate accepts every supported locale', () {
      for (final locale in appSupportedLocales) {
        for (final delegate in appLocalizationsDelegates) {
          expect(
            delegate.isSupported(locale),
            isTrue,
            reason: '${delegate.runtimeType} rejects $locale; wrap it in a '
                'FallbackLocalizationsDelegate',
          );
        }
      }
    });

    test('a locale only some packages translate still loads everywhere',
        () async {
      const japanese = Locale('ja');
      for (final delegate in appLocalizationsDelegates) {
        expect(await delegate.load(japanese), isNotNull);
      }
    });
  });
}
