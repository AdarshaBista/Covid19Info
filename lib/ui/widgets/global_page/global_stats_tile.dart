import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/global_stats_bloc/global_stats_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';
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
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Card(
          elevation: 8.0,
          margin: EdgeInsets.all(12.0),
          clipBehavior: Clip.antiAlias,
          color: AppColors.dark,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: BlocBuilder<GlobalStatsBloc, GlobalStatsState>(
            builder: (context, state) {
              if (state is InitialGlobalStatsState) {
                return const EmptyIcon();
              } else if (state is LoadedGlobalStatsState) {
                return _buildTile(state, context);
              } else if (state is ErrorGlobalStatsState) {
                return ErrorIcon(message: state.message);
              } else {
                return const BusyIndicator();
              }
            },
          ),
        ),
        _buildArrowIcon(context),
      ],
    );
  }

  Positioned _buildArrowIcon(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width / 2.0 - 14.0,
      bottom: -2.0,
      child: CircleAvatar(
        radius: 14.0,
        backgroundColor: AppColors.dark,
        child: Icon(
          isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          size: 14.0,
        ),
      ),
    );
  }

  ExpansionTile _buildTile(LoadedGlobalStatsState state, BuildContext context) {
    return ExpansionTile(
      backgroundColor: AppColors.dark,
      title: _buildStatsRow(state, context),
      trailing: Offstage(),
      onExpansionChanged: (value) {
        setState(() {
          isExpanded = value;
        });
      },
      children: [
        TimelineGraph(
          title: 'Global',
          timeline: state.globalTimeline,
        ),
      ],
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
