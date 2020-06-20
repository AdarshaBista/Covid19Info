import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:covid19_info/core/services/api_service.dart';
import 'package:covid19_info/core/services/cache_service.dart';
import 'package:covid19_info/core/services/launcher_service.dart';
import 'package:covid19_info/core/services/podcast_player_service.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/pages/nav_page.dart';

import 'package:device_preview/device_preview.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ),
  );

  await initHive();
  runApp(
    DevicePreview(
      enabled: Platform.isWindows,
      isToolBarVisible: true,
      style: DevicePreviewStyle(
        background: BoxDecoration(color: Color(0xFF24292E)),
        toolBar: DevicePreviewToolBarStyle.dark().copyWith(
          position: DevicePreviewToolBarPosition.left,
        ),
      ),
      data: DevicePreviewData(
        deviceIndex: 3,
        isFrameVisible: true,
      ),
      builder: (_) => (App()),
    ),
  );
}

Future<void> initHive() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    Hive.init('cache');
    return;
  }

  final appDir = await getApplicationDocumentsDirectory();
  Hive.init(appDir.path);
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LauncherService>(create: (_) => LauncherService()),
        RepositoryProvider<PodcastPlayerService>(create: (_) => PodcastPlayerService()),
        RepositoryProvider<ApiService>(
          create: (_) => ApiService(cacheService: CacheService()),
        ),
      ],
      child: MaterialApp(
        builder: DevicePreview.appBuilder,
        locale: DevicePreview.of(context).locale,
        debugShowCheckedModeBanner: false,
        title: 'Covid19 Info',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          iconTheme: IconThemeData(color: AppColors.primary),
          appBarTheme: AppBarTheme(
            brightness: Brightness.dark,
            color: AppColors.primary,
            iconTheme: IconThemeData(color: AppColors.primary),
          ),
          brightness: Brightness.dark,
          primaryColor: AppColors.primary,
          accentColor: AppColors.primary,
          fontFamily: 'Sen',
        ),
        home: NavPage(),
      ),
    );
  }
}
