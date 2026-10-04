import 'package:core_ui/core_ui.dart';
import 'package:flutter/widgets.dart';

import 'generated/onboarding_localizations.dart';

/// Locales translated by this package.
const onboardingSupportedLocales = OnboardingLocalizations.supportedLocales;

/// Delegate to register in the app. Falls back to English for locales this
/// package does not translate.
const onboardingLocalizationsDelegate = FallbackLocalizationsDelegate<OnboardingLocalizations>(
  OnboardingLocalizations.delegate,
);

extension OnboardingLocalizationsX on BuildContext {
  OnboardingLocalizations get onboardingL10n =>
      OnboardingLocalizations.of(this) ?? lookupOnboardingLocalizations(const Locale('en'));
}
