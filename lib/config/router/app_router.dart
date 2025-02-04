import 'package:go_router/go_router.dart';
import 'package:front_scaffold_flutter_v2/ui/screens/screens.dart';
import 'package:front_scaffold_flutter_v2/ui/views/views.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ///* INITIAL ROUTE
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),

    ///* WIDGET SCREEN
    GoRoute(
      path: '/widgets',
      builder: (context, state) => const WidgetsScreen(),
      routes: [
        GoRoute(
          path: 'text_styles_view',
          name: 'text_styles_view',
          builder: (context, state) => TextStylesView(),
        ),
        GoRoute(
          path: 'inputs_view',
          name: 'inputs_view',
          builder: (context, state) => InputsWidget(),
        ),
        GoRoute(
          path: 'selectable_widget_view',
          name: 'selectable_widget_view',
          builder: (context, state) => SelectableWidgetView(),
        ),
        GoRoute(
          path: 'drawer_view',
          name: 'drawer_view',
          builder: (context, state) => DrawerView(),
        ),
        GoRoute(
          path: 'buttons_view',
          name: 'buttons_view',
          builder: (context, state) => ButtonsView(),
        ),
        GoRoute(
          path: 'bottom_sheet_view',
          name: 'bottom_sheet_view',
          builder: (context, state) => BottomSheetView(),
        ),
      ],
    ),

    ///* AUTH ROUTES
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
  ],
  redirect: (context, state) {
    // TODO: IMPLEMENT LOGIC TO REDIRECT IF NOT AUTHENTICATED
    return null;
  },
);