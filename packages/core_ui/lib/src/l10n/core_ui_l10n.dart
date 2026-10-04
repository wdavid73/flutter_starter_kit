import 'package:flutter/widgets.dart';

import 'fallback_localizations_delegate.dart';
import 'generated/core_ui_localizations.dart';

/// Locales translated by this package.
const coreUiSupportedLocales = CoreUiLocalizations.supportedLocales;

/// Delegate to register in the app. Falls back to English for locales this
/// package does not translate.
const coreUiLocalizationsDelegate =
    FallbackLocalizationsDelegate<CoreUiLocalizations>(
  CoreUiLocalizations.delegate,
);

extension CoreUiL10nX on BuildContext {
  /// Localized generic UI strings, falling back to English when the current
  /// locale is not supported by this package.
  CoreUiLocalizations get coreUiL10n =>
      CoreUiLocalizations.of(this) ??
      lookupCoreUiLocalizations(const Locale('en'));
}

extension CoreUiLocalizationsX on CoreUiLocalizations {
  /// Translates a validation error key produced by the form inputs
  /// (for example `is_required`). Unknown keys are returned unchanged.
  String? validationMessage(String? key) {
    final messages = <String, String>{
      'is_required': isRequired,
      'is_email': isEmail,
      'is_password_length': isPasswordLength,
      'is_invalid_password_pattern': isInvalidPasswordPattern,
      'is_not_equal_password': isNotEqualPassword,
      'is_empty': isEmpty,
      'is_empty_list': isEmptyList,
      'is_empty_select': isEmptySelect,
      'is_not_equal': isNotEqual,
    };
    return messages[key] ?? key;
  }
}
