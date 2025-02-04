import 'package:flutter/material.dart';
import 'package:front_scaffold_flutter_v2/config/config.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      title: 'My App Title',
      theme: AppTheme.getTheme(),
      darkTheme: AppTheme.getDarkTheme(),
      localizationsDelegates: LocaleConfig.localizationDelegate,
      supportedLocales: LocaleConfig.supportedLocales,
    );
  }
}