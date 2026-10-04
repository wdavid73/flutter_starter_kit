import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:feature_auth/src/presentation/views/login_view.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        onTap: () => context.unfocus(),
        child: LoginView(),
      ),
    );
  }
}
