import 'package:core_ui/core_ui.dart';
import 'package:flutter/widgets.dart';

import 'generated/auth_localizations.dart';

/// Delegate to register in the app. Falls back to English for locales this
/// package does not translate.
const authLocalizationsDelegate = FallbackLocalizationsDelegate<AuthLocalizations>(
  AuthLocalizations.delegate,
);

extension AuthLocalizationsX on BuildContext {
  AuthLocalizations get authL10n =>
      AuthLocalizations.of(this) ?? lookupAuthLocalizations(const Locale('en'));
}

extension AuthErrorMessagesX on AuthLocalizations {
  /// Translates the auth/network error keys emitted by the session layer.
  /// Unknown keys are returned unchanged.
  String? errorByKey(String? key) {
    final messages = <String, String>{
      'connection_time_out': connectionTimeOut,
      'invalid-credential': invalidCredential,
      'email-already-in-use': emailAlreadyInUse,
      'wrong-password': wrongPassword,
      'invalid-email': invalidEmail,
      'weak-password': weakPassword,
    };
    return messages[key] ?? key;
  }
}
