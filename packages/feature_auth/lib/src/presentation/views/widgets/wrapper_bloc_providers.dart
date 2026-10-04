import 'package:feature_auth/src/cubit/register/register_form_cubit.dart';
import 'package:feature_auth/src/cubit/sign_in/sign_in_form_cubit.dart';
import 'package:platform_session/platform_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class WrapperBlocProvidersAuth extends StatelessWidget {
  final Widget child;
  const WrapperBlocProvidersAuth({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final authBloc = GetIt.instance.get<AuthBloc>();
    final signInCubit = GetIt.instance.get<SignInFormCubit>();
    final registerCubit = GetIt.instance.get<RegisterFormCubit>();

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authBloc),
        BlocProvider(create: (context) => signInCubit),
        BlocProvider(create: (context) => registerCubit),
      ],
      child: child,
    );
  }
}
