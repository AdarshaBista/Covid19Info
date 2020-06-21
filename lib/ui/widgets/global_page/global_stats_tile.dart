import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/global_stats_bloc/global_stats_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:covid19_info/ui/widgets/common/timeline_graph.dart';
import 'package:covid19_info/ui/widgets/global_page/stat_column.dart';

class GlobalStatsTile extends StatefulWidget {
  @override
  _GlobalStatsTileState createState() => _GlobalStatsTileState();
}

class _GlobalStatsTileState extends State<GlobalStatsTile> {
  double panelPos = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalStatsBloc, GlobalStatsState>(
      builder: (context, state) {
        if (state is InitialGlobalStatsState) {
          return const Offstage();
        } else if (state is LoadedGlobalStatsState) {
          return _buildPanel(state);
        } else if (state is ErrorGlobalStatsState) {
          return const Offstage();
        } else {
          return const Offstage();
        }
      },
    );
  }

  Widget _buildPanel(LoadedGlobalStatsState state) {
    return SlidingUpPanel(
      color: AppColors.dark,
      parallaxOffset: 0.2,
      isDraggable: true,
      parallaxEnabled: true,
      backdropEnabled: false,
      slideDirection: SlideDirection.DOWN,
      margin: const EdgeInsets.all(12.0),
      borderRadius: BorderRadius.circular(12.0),
      maxHeight: MediaQuery.of(context).size.height * 0.7,
      minHeight: 88.0,
      onPanelSlide: (value) => setState(() {
        panelPos = value;
      }),
      collapsed: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStatsRow(state, context),
          Transform.rotate(
            angle: panelPos * 3.1415,
            child: Icon(
              Icons.keyboard_arrow_down,
              size: 16.0,
              color: AppColors.light.withOpacity(0.5),
            ),
          ),
        ],
      ),
      panelBuilder: (_) => Transform.scale(
        scale: panelPos,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              TimelineGraph(
                title: 'Global',
                timeline: state.globalTimeline,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow(LoadedGlobalStatsState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          StatColumn(
            label: 'Confirmed',
            count: state.globalTimeline.last.confirmed,
            color: Colors.blue,
          ),
          StatColumn(
            label: 'Recovered',
            count: state.globalTimeline.last.recovered,
            color: Colors.green,
          ),
          StatColumn(
            label: 'Deaths',
            count: state.globalTimeline.last.deaths,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
