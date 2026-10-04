import 'package:core_ui/core_ui.dart';
import 'package:flutter/widgets.dart';

import 'generated/home_localizations.dart';

/// Delegate to register in the app. Falls back to English for locales this
/// package does not translate.
const homeLocalizationsDelegate = FallbackLocalizationsDelegate<HomeLocalizations>(
  HomeLocalizations.delegate,
);

extension HomeLocalizationsX on BuildContext {
  HomeLocalizations get homeL10n =>
      HomeLocalizations.of(this) ?? lookupHomeLocalizations(const Locale('en'));
}
