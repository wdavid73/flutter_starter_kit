import 'package:core_ui/core_ui.dart';
import 'package:feature_auth/feature_auth.dart';
import 'package:feature_home/feature_home.dart';
import 'package:feature_onboarding/feature_onboarding.dart';
import 'package:feature_settings/feature_settings.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations.dart';

/// Every locale translated by the app or by any of its packages.
///
/// Each package declares its own languages; the app supports their union and
/// each package falls back to English for the ones it does not translate.
final List<Locale> appSupportedLocales = <Locale>{
  ...AppLocalizations.supportedLocales,
  ...coreUiSupportedLocales,
  ...authSupportedLocales,
  ...homeSupportedLocales,
  ...onboardingSupportedLocales,
  ...settingsSupportedLocales,
}.toList(growable: false);

/// Delegates for the app and for every package that owns texts.
const List<LocalizationsDelegate<dynamic>> appLocalizationsDelegates = [
  FallbackLocalizationsDelegate<AppLocalizations>(AppLocalizations.delegate),
  authLocalizationsDelegate,
  coreUiLocalizationsDelegate,
  homeLocalizationsDelegate,
  onboardingLocalizationsDelegate,
  settingsLocalizationsDelegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
