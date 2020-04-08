import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/country_bloc/country_bloc.dart';
import 'package:covid19_info/blocs/global_stats_bloc/global_stats_bloc.dart';

import 'package:covid19_info/core/services/launcher_service.dart';
import 'package:covid19_info/core/services/nepal_api_service.dart';
import 'package:covid19_info/core/services/global_api_service.dart';

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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NepalApiService>(create: (_) => NepalApiService()),
        RepositoryProvider<GlobalApiService>(create: (_) => GlobalApiService()),
        RepositoryProvider<LauncherService>(create: (_) => LauncherService()),
      ],
      child: MaterialApp(
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
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => GlobalStatsBloc(
                apiService: context.repository<GlobalApiService>(),
              ),
            ),
            BlocProvider(
              create: (context) => CountryBloc(
                apiService: context.repository<GlobalApiService>(),
              ),
            ),
          ],
          child: NavPage(),
        ),
      ),
    );
  }
}
