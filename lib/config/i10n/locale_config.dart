import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_localizations.dart';

abstract class LocaleConfig {
  static Iterable<LocalizationsDelegate<dynamic>> localizationDelegate = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    AppCupertinoLocalizationsDelegate(),
  ];

  static const List<Locale> supportedLocales = [
    Locale('es', 'ES'),
    Locale('es'),
    Locale('en', 'US'),
  ];
}