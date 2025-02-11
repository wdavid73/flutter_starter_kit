import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_scaffold_flutter_v2/app/app.dart';
import 'package:front_scaffold_flutter_v2/config/constants/environment.dart';
import 'package:front_scaffold_flutter_v2/firebase_options.dart';

/// The main entry point of the Flutter application.
void main() async {
  // Ensures that Flutter bindings are initialized before running the app.
  WidgetsFlutterBinding.ensureInitialized();

  // Locks the app orientation to portrait mode.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  /// Initializes environment variables required for the app.
  await Environment.initEnvironment();

  /// Initializes Firebase with platform-specific configuration.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Runs the main application widget.
  runApp(const MainApp());
}