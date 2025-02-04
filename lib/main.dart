import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_scaffold_flutter_v2/app/app.dart';
import 'package:front_scaffold_flutter_v2/config/constants/environment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Environment.initEnvironment();
  runApp(const MainApp());
}