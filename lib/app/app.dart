import 'package:flutter/material.dart';
import 'package:front_scaffold_flutter_v2/config/config.dart';
import 'package:front_scaffold_flutter_v2/ui/screens/widgets.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App Title',
      theme: AppTheme.getTheme(),
      darkTheme: AppTheme.getDarkTheme(),
      home: WidgetsScreen(),
      localizationsDelegates: LocaleConfig.localizationDelegate,
      supportedLocales: LocaleConfig.supportedLocales,
      // home: _Body(responsive: responsive),
    );
  }
}