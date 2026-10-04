import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/config.dart';

extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

extension GetLocale on BuildContext {
  String currentLocale() {
    return Localizations.localeOf(this).toString();
  }
}


extension StringCapitalizeExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
