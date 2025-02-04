import 'package:flutter/material.dart';
import 'package:front_scaffold_flutter_v2/config/config.dart';
import 'package:animate_do/animate_do.dart';
import 'package:front_scaffold_flutter_v2/ui/screens/widgets.dart';

import '../config/constants/environment.dart';

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
      // home: _Body(responsive: responsive),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    super.key,
    required this.responsive,
  });

  final Responsive responsive;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Appbar",
          /*style: AppTypography.getRegularStyle(
            fontSize: AppTypography.extraHugeSize,
          ),*/
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),
                FlutterLogo(
                  size: responsive.dp(20),
                ),
                const Spacer(flex: 3),
                FadeIn(
                  child: Container(
                    width: responsive.width,
                    height: responsive.hp(30),
                    color: ColorTheme.primaryColor,
                  ),
                ),
                Text(
                  Environment.apiUrl,
                  /*style: AppTypography.getRegularStyle(
                    fontSize: responsive.dp(1.6),
                  ),*/
                ),
                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}