import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/country_bloc/country_bloc.dart';
import 'package:covid19_info/blocs/global_stats_bloc/global_stats_bloc.dart';
import 'package:covid19_info/blocs/nepal_stats_bloc/nepal_stats_bloc.dart';
import 'package:covid19_info/blocs/hospital_bloc/hospital_bloc.dart';
import 'package:covid19_info/blocs/search_hospital_bloc/search_hospital_bloc.dart';
import 'package:covid19_info/blocs/news_bloc/news_bloc.dart';
import 'package:covid19_info/blocs/faq_bloc/faq_bloc.dart';
import 'package:covid19_info/blocs/myth_bloc/myth_bloc.dart';

import 'package:covid19_info/core/services/nepal_api_service.dart';
import 'package:covid19_info/core/services/global_api_service.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

import 'package:covid19_info/ui/pages/nepal_page.dart';
import 'package:covid19_info/ui/pages/news_page.dart';
import 'package:covid19_info/ui/pages/info_page.dart';
import 'package:covid19_info/ui/pages/global_page.dart';

class NavPage extends StatefulWidget {
  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int _selectedIndex = 0;

  List<GButton> get tabs => [
        GButton(
          icon: LineAwesomeIcons.globe,
          text: 'World',
          iconColor: Colors.teal,
          backgroundColor: Colors.teal,
        ),
        GButton(
          icon: LineAwesomeIcons.sun_o,
          text: 'Nepal',
          iconColor: Colors.red,
          backgroundColor: Colors.red,
        ),
        GButton(
          icon: LineAwesomeIcons.newspaper_o,
          text: 'News',
          iconColor: Colors.green,
          backgroundColor: Colors.green,
        ),
        GButton(
          icon: LineAwesomeIcons.info_circle,
          text: 'Info',
          iconColor: Colors.blue,
          backgroundColor: Colors.blue,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(4.0),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: AppColors.dark,
          borderRadius: BorderRadius.circular(64.0),
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.5)),
          ],
        ),
        child: GNav(
          gap: 8,
          tabs: tabs,
          iconSize: 20,
          activeColor: Colors.white,
          duration: Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          _buildWorldPage(),
          _buildNepalPage(),
          _buildNewsPage(),
          _buildInfopage(),
        ],
      ),
    );
  }

  Widget _buildWorldPage() => MultiBlocProvider(
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
        child: GlobalPage(),
      );

  Widget _buildNepalPage() => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NepalStatsBloc(
              apiService: context.repository<NepalApiService>(),
            ),
          ),
          BlocProvider(
            create: (context) => HospitalBloc(
              apiService: context.repository<NepalApiService>(),
            ),
          ),
          BlocProvider(
            create: (context) => SearchHospitalBloc(
              hospitalBloc: context.bloc<HospitalBloc>(),
            ),
          ),
        ],
        child: NepalPage(),
      );

  Widget _buildNewsPage() => BlocProvider(
        create: (context) => NewsBloc(
          apiService: context.repository<NepalApiService>(),
        ),
        child: NewsPage(),
      );

  Widget _buildInfopage() => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FaqBloc(
              apiService: context.repository<NepalApiService>(),
            ),
          ),
          BlocProvider(
            create: (context) => MythBloc(
              apiService: context.repository<NepalApiService>(),
            ),
          ),
        ],
        child: InfoPage(),
      );
}
