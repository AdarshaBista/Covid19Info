import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/ui/styles/styles.dart';

import 'package:covid19_info/core/services/launcher_service.dart';
import 'package:covid19_info/core/services/nepal_api_service.dart';
import 'package:covid19_info/core/services/global_api_service.dart';

import 'package:covid19_info/ui/pages/nav_page.dart';

import 'package:device_preview/device_preview.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(
    DevicePreview(
      background: BoxDecoration(color: AppColors.dark),
      enabled: true,
      builder: (context) => App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NepalApiService>(create: (_) => NepalApiService()),
        RepositoryProvider<GlobalApiService>(create: (_) => GlobalApiService()),
        RepositoryProvider<LauncherService>(create: (_) => LauncherService()),
      ],
      child: MaterialApp(
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
        home: NavPage(),
      ),
    );
  }
}
