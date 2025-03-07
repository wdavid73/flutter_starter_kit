import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_scaffold_flutter_v2/config/config.dart';
import 'package:front_scaffold_flutter_v2/ui/blocs/blocs.dart';
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
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () => context.push('/settings'),
            icon: Icon(Icons.settings),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.widgets),
              trailing: Icon(Icons.adaptive.arrow_forward),
              title: Text("go to widgets"),
              onTap: () => context.push(RouteConstants.widgetsScreen),
            ),
            ListTile(
              leading: Icon(Icons.api),
              trailing: Icon(Icons.adaptive.arrow_forward),
              title: Text("go to example api service implementation"),
              onTap: () => context.push(RouteConstants.exampleService),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: () => context.read<AuthBloc>().logout(),
              label: Text("LogOut"),
              icon: Icon(Icons.logout_rounded),
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}