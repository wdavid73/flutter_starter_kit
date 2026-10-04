import 'package:core_ui/core_ui.dart';
import 'package:feature_home/src/l10n/home_l10n.dart';
import 'package:flutter/material.dart';

class HomeScreenMediumLayout extends StatelessWidget {
  const HomeScreenMediumLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: FlutterLogo(
            size: context.dp(20),
          ),
        ),
        AppSpacing.md,
        Text(
          "${context.homeL10n.home} - Medium Layout",
          style: context.textTheme.titleLarge,
        ),
      ],
    );
  }
}
