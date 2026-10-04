import 'package:core_ui/core_ui.dart';
import 'package:feature_showcase/feature_showcase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  Widget app() {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, _) => Theme(
            data: AppTheme.getLightTheme(context),
            child: const WidgetsScreen(),
          ),
          routes: [
            GoRoute(
              path: 'widgets/buttons_view',
              builder: (_, __) => const Scaffold(body: Text('buttons page')),
            ),
          ],
        ),
      ],
    );
    return MaterialApp.router(routerConfig: router);
  }

  testWidgets('lists the demo views', (tester) async {
    await tester.pumpWidget(app());
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.text('Go to TextStyles View'), findsOneWidget);
    expect(find.text('Go to Buttons View'), findsOneWidget);
  });

  testWidgets('tapping an entry pushes its view route', (tester) async {
    await tester.pumpWidget(app());
    await tester.pump(const Duration(milliseconds: 600));

    await tester.ensureVisible(find.text('Go to Buttons View'));
    await tester.tap(find.text('Go to Buttons View'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.text('buttons page'), findsOneWidget);
  });
}
