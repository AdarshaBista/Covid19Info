import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/country_bloc/country_bloc.dart';
import 'package:covid19_info/blocs/global_stats_bloc/global_stats_bloc.dart';

import 'package:covid19_info/ui/styles/app_colors.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:covid19_info/ui/widgets/global_page/map_card.dart';
import 'package:covid19_info/ui/widgets/global_page/country_list.dart';
import 'package:covid19_info/ui/widgets/global_page/global_stats_row.dart';
import 'package:covid19_info/ui/widgets/global_page/top_infected_stats.dart';

class GlobalPage extends StatefulWidget {
  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {
  double panelPos = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.bloc<GlobalStatsBloc>()..add(GetGlobalStatsEvent());
    context.bloc<CountryBloc>()..add(GetCountryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      extendBodyBehindAppBar: false,
      body: SlidingUpPanel(
        color: AppColors.background,
        parallaxOffset: 0.5,
        isDraggable: true,
        backdropEnabled: true,
        parallaxEnabled: true,
        backdropTapClosesPanel: true,
        slideDirection: SlideDirection.UP,
        margin: EdgeInsets.zero,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        maxHeight: MediaQuery.of(context).size.height * 0.9,
        minHeight: 140.0,
        onPanelSlide: (value) => setState(() {
          panelPos = value;
        }),
        body: MapCard(),
        panelBuilder: (sc) => _buildList(sc),
      ),
    );
  }

  ListView _buildList(ScrollController sc) {
    return ListView(
      controller: sc,
      shrinkWrap: true,
      children: <Widget>[
        Transform.rotate(
          angle: panelPos * math.pi,
          child: Icon(
            Icons.keyboard_arrow_up,
            color: Colors.white54,
            size: 16.0,
          ),
        ),
        const SizedBox(height: 6.0),
        GlobalStatsRow(),
        const SizedBox(height: 16.0),
        TopInfectedStats(),
        const SizedBox(height: 16.0),
        CountryList(),
      ],
    );
  }
}
