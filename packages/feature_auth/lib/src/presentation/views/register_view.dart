import 'package:core_ui/core_ui.dart';
import 'package:feature_auth/src/l10n/auth_l10n.dart';
import 'package:feature_auth/src/presentation/views/widgets/form_sign_up.dart';
import 'package:feature_auth/src/presentation/views/widgets/wrapper_bloc_providers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/login_background.jpg',
            package: 'feature_auth',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
          child: Container(
        width: context.width,
        height: context.height,
        alignment: Alignment.center,
        child: const _RegisterBody(),
      )),
    );
  }
}

class _RegisterBody extends StatelessWidget {
  const _RegisterBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      BackButton(
                        onPressed: () => context.pop(),
                      ),
                      /* SizedBox(
                        width: context.wp(10),
                        child: IconButton(
                          onPressed: () => context.pop(),
                          icon: Icon(
                            Icons.adaptive.arrow_back,
                            /* size: context.dp(3), */
                          ),
                        ),
                      ), */
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: context.wp(15)),
                          child: LogoContainer(),
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.sm,
                  Text(
                    context.authL10n.signUp,
                    style: context.textTheme.titleMedium,
                  ),
                  AppSpacing.sm,
                  WrapperBlocProvidersAuth(child: FormSignUp()),
                  AppSpacing.sm,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
