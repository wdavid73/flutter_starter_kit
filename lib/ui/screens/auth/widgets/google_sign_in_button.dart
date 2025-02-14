import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_scaffold_flutter_v2/config/config.dart';
import 'package:front_scaffold_flutter_v2/ui/blocs/blocs.dart';
import 'package:front_scaffold_flutter_v2/ui/widgets/widgets.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    final googleSignInLoading = context.select<AuthBloc, bool>(
      (bloc) => bloc.state.googleSignInLoading,
    );

    TextStyle? textStyle = context.textTheme.bodyMedium?.copyWith(
      color: ColorTheme.textPrimary,
    );

    double iconSize = context.dp(3);

    return CustomFilledButton(
      isLoading: googleSignInLoading,
      onPressed: () => context.read<AuthBloc>().googleSignIn(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icon/icon_google.svg',
            width: iconSize,
            height: iconSize,
          ),
          const SizedBox(width: 10),
          Text(
            context.translate('sign_in_with_google'),
            style: textStyle,
          ),
        ],
      ),
    );
  }
}