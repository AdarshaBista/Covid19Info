import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/ui/styles/styles.dart';

import 'package:covid19_info/core/services/api_service.dart';

import 'package:covid19_info/ui/pages/nav_page.dart';

import 'package:device_preview/device_preview.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ),
  );

  // TODO: Remove Device Preview
  runApp(
    DevicePreview(
      builder: (_) => App(),
      background: BoxDecoration(color: AppColors.dark),
    ),
  );
  // runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.of(context).locale,
      builder: DevicePreview.appBuilder,
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
        accentColor: AppColors.secondary,
        fontFamily: 'Sen',
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<ApiService>(create: (_) => ApiService()),
        ],
        child: NavPage(),
      ),
    );
  }
}
