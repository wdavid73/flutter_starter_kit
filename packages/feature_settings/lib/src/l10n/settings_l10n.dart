import 'package:core_ui/core_ui.dart';
import 'package:flutter/widgets.dart';

import 'generated/settings_localizations.dart';

/// Delegate to register in the app. Falls back to English for locales this
/// package does not translate.
const settingsLocalizationsDelegate = FallbackLocalizationsDelegate<SettingsLocalizations>(
  SettingsLocalizations.delegate,
);

extension SettingsLocalizationsX on BuildContext {
  SettingsLocalizations get settingsL10n =>
      SettingsLocalizations.of(this) ?? lookupSettingsLocalizations(const Locale('en'));
}
