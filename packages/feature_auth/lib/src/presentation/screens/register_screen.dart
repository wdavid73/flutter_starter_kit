import 'package:core_ui/core_ui.dart';
import 'package:feature_auth/src/presentation/views/register_view.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        onTap: () => context.unfocus(),
        child: RegisterView(),
      ),
    );
  }
}
