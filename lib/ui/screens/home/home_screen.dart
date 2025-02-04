import 'package:flutter/material.dart';
import 'package:front_scaffold_flutter_v2/config/config.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.translate('home'),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.login),
              trailing: Icon(Icons.adaptive.arrow_forward),
              title: Text("go to login"),
              onTap: () => context.push('/login'),
            ),
            ListTile(
              leading: Icon(Icons.widgets),
              trailing: Icon(Icons.adaptive.arrow_forward),
              title: Text("go to widgets"),
              onTap: () => context.push('/widgets'),
            )
          ],
        ),
      ),
    );
  }
}