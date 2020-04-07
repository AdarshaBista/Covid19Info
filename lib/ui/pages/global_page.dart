import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/country_bloc/country_bloc.dart';
import 'package:covid19_info/blocs/global_stats_bloc/global_stats_bloc.dart';

import 'package:covid19_info/ui/widgets/global_page/map_card.dart';
import 'package:covid19_info/ui/widgets/global_page/country_list.dart';
import 'package:covid19_info/ui/widgets/global_page/global_stats_row.dart';
import 'package:covid19_info/ui/widgets/global_page/top_infected_stats.dart';

class GlobalPage extends StatefulWidget {
  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.bloc<GlobalStatsBloc>()..add(GetGlobalStatsEvent());
    context.bloc<CountryBloc>()..add(GetCountryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            MapCard(),
            const SizedBox(height: 24.0),
            GlobalStatsRow(),
            const SizedBox(height: 16.0),
            TopInfectedStats(),
            const SizedBox(height: 16.0),
            CountryList(),
          ],
        ),
      ),
    );
  }
}
