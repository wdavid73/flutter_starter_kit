import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_scaffold_flutter_v2/config/config.dart';
import 'multi_bloc_providers.dart';
import 'multi_repository_provider.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: buildRepositories(),
      child: MultiBlocProvider(
        providers: buildBlocs(),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
          title: 'My App Title',
          theme: AppTheme.getTheme(),
          darkTheme: AppTheme.getDarkTheme(),
          localizationsDelegates: LocaleConfig.localizationDelegate,
          supportedLocales: LocaleConfig.supportedLocales,
        ),
      ),
    );
  }
}