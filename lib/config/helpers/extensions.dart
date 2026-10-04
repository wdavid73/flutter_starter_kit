import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/config.dart';

extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

extension AppLocalizationsX on AppLocalizations {
  String? getByKey(String? key) {
    final map = <String, String>{
      'connection_time_out': connectionTimeOut,
      'invalid-credential': invalidCredential,
      'email-already-in-use': emailAlreadyInUse,
      'wrong-password': wrongPassword,
      'invalid-email': invalidEmail,
      'weak-password': weakPassword,
    };
    return map[key] ?? key;
  }
}

extension GetLocale on BuildContext {
  String currentLocale() {
    return Localizations.localeOf(this).toString();
  }
}

extension UnFocusScreen on BuildContext {
  void unfocus() {
    return FocusScope.of(this).unfocus();
  }
}

extension StringCapitalizeExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
