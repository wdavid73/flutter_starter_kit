import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgPictureCustom extends StatelessWidget {
  final String iconPath;

  /// Package that owns the asset, when it does not live in the app.
  final String? package;
  final double iconSize;
  final Alignment alignment;
  final BoxFit fit;

  const SvgPictureCustom({
    super.key,
    required this.iconPath,
    this.package,
    this.iconSize = 30,
    this.alignment = Alignment.center,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      package: package,
      width: iconSize,
      height: iconSize,
      alignment: alignment,
      fit: fit,
    );
  }
}