import 'package:go_router/go_router.dart';
import 'package:front_scaffold_flutter_v2/ui/screens/screens.dart';
import 'package:front_scaffold_flutter_v2/ui/views/views.dart';

/// A utility class that defines the application's route paths and generates the
/// [GoRouter] route configuration.
///
/// This class provides constants for each route path and a method to generate
/// the list of [RouteBase] objects used by [GoRouter].
class Routes {
  /// The path for the home screen.
  static const String home = '/';

  /// The path for the splash screen.
  static const String splash = '/splash';

  /// The path for the login screen.
  static const String loginScreen = '/login';

  /// The path for the registration screen.
  static const String registerScreen = '/register';

  // ----------- EXAMPLES ----------- //
  /// The path for the example service screen.
  static const String exampleService = '/example_service';

  /// The path for the widgets screen.
  static const String widgetsScreen = '/widgets';
  static const String textStylesView = '/text_styles_view';
  static const String inputsView = '/inputs_view';
  static const String selectableWidgetView = '/selectable_widget_view';
  static const String drawerView = '/drawer_view';
  static const String buttonsView = '/buttons_view';
  static const String bottomSheetView = '/bottom_sheet_view';

  /// Generates the list of [RouteBase] objects for the application.
  ///
  /// This method defines the route hierarchy and associates each route path
  /// with its corresponding screen or view. It also defines nested routes
  /// for the widgets screen.
  ///
  /// Returns:
  ///   - A [List] of [RouteBase] objects representing the application's routes.
  static List<RouteBase> getAppRoutes() {
    return [
      ///* SPLASH SCREEN
      GoRoute(
        path: splash,
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      ///* HOME ROUTE
      GoRoute(
        path: home,
        builder: (context, state) => const HomeScreen(),
      ),

      ///* WIDGET SCREEN
      GoRoute(
        path: widgetsScreen,
        builder: (context, state) => const WidgetsScreen(),
        routes: [
          GoRoute(
            path: textStylesView,
            name: 'text_styles_view',
            builder: (context, state) => TextStylesView(),
          ),
          GoRoute(
            path: inputsView,
            name: 'inputs_view',
            builder: (context, state) => InputsWidget(),
          ),
          GoRoute(
            path: selectableWidgetView,
            name: 'selectable_widget_view',
            builder: (context, state) => SelectableWidgetView(),
          ),
          GoRoute(
            path: drawerView,
            name: 'drawer_view',
            builder: (context, state) => DrawerView(),
          ),
          GoRoute(
            path: buttonsView,
            name: 'buttons_view',
            builder: (context, state) => ButtonsView(),
          ),
          GoRoute(
            path: bottomSheetView,
            name: 'bottom_sheet_view',
            builder: (context, state) => BottomSheetView(),
          ),
        ],
      ),

      GoRoute(
        path: exampleService,
        builder: (context, state) => const ExampleServiceScreen(),
      ),

      ///* AUTH ROUTES
      GoRoute(
        path: loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: registerScreen,
        builder: (context, state) => const RegisterScreen(),
      ),
    ];
  }
}