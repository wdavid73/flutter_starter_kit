import 'package:flutter/material.dart';
import 'package:front_scaffold_flutter_v2/config/theme/theme.dart';

class CustomFilledButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  final bool isLoading;

  const CustomFilledButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle = ButtonStyle(
      backgroundColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return ColorTheme.disable;
        }
        return ColorTheme.backgroundLight;
      }),
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 10),
      ),
    );
    return FilledButton(
      onPressed: !isLoading ? onPressed : null,
      style: buttonStyle,
      child: isLoading ? _LoadingButton() : child,
    );
  }
}

class _LoadingButton extends StatelessWidget {
  const _LoadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = context.textTheme.bodyMedium?.copyWith(
      color: ColorTheme.textPrimary,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: context.dp(2),
      children: [
        SizedBox(
          width: context.wp(6.5),
          height: context.hp(3),
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
          ),
        ),
        Text(
          "Loading...",
          style: textStyle,
        ),
      ],
    );
  }
}