import 'package:flutter/material.dart';
import 'package:front_scaffold_flutter_v2/config/config.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.translate('login'),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            context.translate('login'),
          ),
        ),
      ),
    );
  }
}