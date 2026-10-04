import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:feature_home/src/l10n/home_l10n.dart';

class HomeScreenExpandedLayout extends StatelessWidget {
  const HomeScreenExpandedLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: FlutterLogo(
            size: context.dp(25),
          ),
        ),
        AppSpacing.md,
        Text(
          "${context.homeL10n.home} - Expanded Layout",
          style: context.textTheme.titleLarge,
        ),
      ],
    );
  }
}
