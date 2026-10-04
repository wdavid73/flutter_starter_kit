import 'package:core_ui/src/theme/theme.dart';
import 'package:flutter/material.dart';

class LogoContainer extends StatelessWidget {
  const LogoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: FlutterLogo(
        size: context.dp(7),
      ),
    );
  }
}
