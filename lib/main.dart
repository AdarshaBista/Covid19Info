import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:covid19_info/ui/styles/styles.dart';

import 'package:covid19_info/ui/pages/nav_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid19 Info',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        iconTheme: IconThemeData(color: AppColors.secondary),
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
          color: AppColors.primary,
          iconTheme: IconThemeData(color: AppColors.secondary),
        ),
        brightness: Brightness.dark,
        primaryColor: AppColors.primary,
        accentColor: AppColors.accent,
        fontFamily: 'Sen',
      ),
      home: NavPage(),
    );
  }
}
