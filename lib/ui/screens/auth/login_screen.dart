import 'package:flutter/material.dart';
import 'package:front_scaffold_flutter_v2/config/config.dart';
import 'package:front_scaffold_flutter_v2/ui/views/views.dart';

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
