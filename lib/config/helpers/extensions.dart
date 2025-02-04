import 'package:flutter/material.dart';
import 'package:front_scaffold_flutter_v2/config/config.dart';

extension TranslateExtension on BuildContext {
  String translate(String key) {
    return AppLocalizations.of(this).translate(key);
  }
}