import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:front_scaffold_flutter_v2/app/app.dart';
import 'package:front_scaffold_flutter_v2/config/constants/environment.dart';

void main() async {
  // Ensures that Flutter bindings are initialized before running the app.
  WidgetsFlutterBinding.ensureInitialized();

  // Locks the app orientation to portrait mode.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  /// Initializes environment variables required for the app.
  await Environment.initEnvironment();

  // Configures the HydratedBloc storage.
  final storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getTemporaryDirectory()).path,
    ),
  );

  // Sets the storage for HydratedBloc.
  HydratedBloc.storage = storage;

  // Runs the main application widget.
  runApp(const MainApp());
}