import 'package:bloc_test/bloc_test.dart';
import 'package:core_ui/core_ui.dart';
import 'package:feature_home/feature_home.dart';
import 'package:feature_home/src/presentation/widgets/drawer_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:platform_session/platform_session.dart';

class _MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late AuthBloc authBloc;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  setUp(() {
    authBloc = _MockAuthBloc();
  });

  Widget app({List<HomeDrawerItem> items = const []}) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, _) => Theme(
            data: AppTheme.getLightTheme(context),
            child: BlocProvider<AuthBloc>.value(
              value: authBloc,
              child: Scaffold(
                key: scaffoldKey,
                drawer: DrawerHome(items: items),
                body: const SizedBox(),
              ),
            ),
          ),
        ),
        GoRoute(
          path: '/target',
          builder: (_, __) => const Scaffold(body: Text('target page')),
        ),
      ],
    );
    return MaterialApp.router(routerConfig: router);
  }

  testWidgets('renders the entries provided by the app', (tester) async {
    await tester.pumpWidget(app(items: const [
      HomeDrawerItem(icon: Icons.widgets, text: 'widgets', location: '/target'),
    ]));
    await tester.pumpAndSettle();
    scaffoldKey.currentState!.openDrawer();
    await tester.pumpAndSettle();

    expect(find.text('widgets'), findsOneWidget);
  });

  testWidgets('tapping an entry pushes its location', (tester) async {
    await tester.pumpWidget(app(items: const [
      HomeDrawerItem(icon: Icons.widgets, text: 'widgets', location: '/target'),
    ]));
    await tester.pumpAndSettle();
    scaffoldKey.currentState!.openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.text('widgets'));
    await tester.pumpAndSettle();

    expect(find.text('target page'), findsOneWidget);
  });

  testWidgets('Log out calls AuthBloc.logout', (tester) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    scaffoldKey.currentState!.openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Log out'));

    verify(() => authBloc.logout()).called(1);
  });
}
