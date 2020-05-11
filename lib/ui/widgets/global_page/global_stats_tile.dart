import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/global_stats_bloc/global_stats_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid19_info/ui/widgets/common/timeline_graph.dart';
import 'package:covid19_info/ui/widgets/indicators/empty_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/error_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';

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
          return const EmptyIcon();
        } else if (state is LoadedGlobalStatsState) {
          return _buildPanel(state);
        } else if (state is ErrorGlobalStatsState) {
          return ErrorIcon(message: state.message);
        } else {
          return const BusyIndicator();
        }
      },
    );
  }

  Widget _buildPanel(LoadedGlobalStatsState state) {
    return SlidingUpPanel(
      color: AppColors.dark,
      parallaxOffset: 0.2,
      isDraggable: true,
      backdropEnabled: true,
      parallaxEnabled: true,
      backdropTapClosesPanel: true,
      slideDirection: SlideDirection.DOWN,
      margin: const EdgeInsets.all(12.0),
      borderRadius: BorderRadius.circular(16.0),
      maxHeight: MediaQuery.of(context).size.height * 0.7,
      minHeight: 96.0,
      onPanelSlide: (value) => setState(() {
        panelPos = value;
      }),
      collapsed: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStatsRow(state, context),
          _buildArrowIcon(),
        ],
      ),
      panel: Transform.scale(
        scale: panelPos,
        child: TimelineGraph(
          title: 'Global',
          timeline: state.globalTimeline,
        ),
      ),
    );
  }

  Widget _buildArrowIcon() {
    return Transform.rotate(
      angle: panelPos * math.pi,
      child: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white54,
        size: 14.0,
      ),
    );
  }

  Widget _buildStatsRow(LoadedGlobalStatsState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          _buildStat(
            label: 'Confirmed',
            count: state.globalTimeline.last.confirmed,
            color: Colors.blue,
          ),
          _buildStat(
            label: 'Recovered',
            count: state.globalTimeline.last.recovered,
            color: Colors.green,
          ),
          _buildStat(
            label: 'Deaths',
            count: state.globalTimeline.last.deaths,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildStat({
    String label,
    int count,
    Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: AutoSizeText(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.smallLight,
            ),
          ),
          const SizedBox(height: 8.0),
          Flexible(
            child: AutoSizeText(
              count.toString(),
              style: AppTextStyles.largeLight.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
