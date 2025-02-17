import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_scaffold_flutter_v2/config/config.dart';
import 'package:front_scaffold_flutter_v2/ui/widgets/widgets.dart';

class AppleSignInButton extends StatelessWidget {
  const AppleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = context.textTheme.bodyMedium?.copyWith(
      color: ColorTheme.textPrimary,
    );

    double iconSize = context.dp(3);

    return CustomFilledButton(
      isLoading: false,
      onPressed: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icon/icon_apple.svg',
            width: iconSize,
            height: iconSize,
          ),
          const SizedBox(width: 10),
          Text(
            context.translate('sign_in_with_apple'),
            style: textStyle,
          ),
        ],
      ),
    );
  }
}