import 'package:flutter/widgets.dart';

/// A navigation entry shown in the home drawer.
///
/// The app provides the entries so the feature does not need to know about
/// routes that belong to other features.
class HomeDrawerItem {
  const HomeDrawerItem({
    required this.icon,
    required this.text,
    required this.location,
  });

  final IconData icon;
  final String text;

  /// Route location pushed when the entry is tapped.
  final String location;
}
