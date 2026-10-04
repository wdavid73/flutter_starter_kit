import 'package:flutter/material.dart';

extension UnFocusScreen on BuildContext {
  void unfocus() {
    return FocusScope.of(this).unfocus();
  }
}
