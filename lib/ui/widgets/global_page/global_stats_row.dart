import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/global_stats_bloc/global_stats_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid19_info/ui/widgets/common/timeline_graph.dart';
import 'package:covid19_info/ui/widgets/indicators/empty_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/error_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';

class GlobalStatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalStatsBloc, GlobalStatsState>(
      builder: (context, state) {
        if (state is InitialGlobalStatsState) {
          return const EmptyIcon();
        } else if (state is LoadedGlobalStatsState) {
          return _buildColumn(state);
        } else if (state is ErrorGlobalStatsState) {
          return ErrorIcon(message: state.message);
        } else {
          return const BusyIndicator();
        }
      },
    );
  }

  Widget _buildColumn(LoadedGlobalStatsState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'GLOBAL STATS',
          style: AppTextStyles.largeLight,
        ),
        const SizedBox(height: 16.0),
        _buildStatsRow(state),
        const SizedBox(height: 16.0),
        TimelineGraph(
          title: 'Global',
          timeline: state.globalTimeline,
        ),
      ],
    );
  }

  Widget _buildStatsRow(LoadedGlobalStatsState state) {
    return Row(
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
    );
  }

  Widget _buildStat({
    String label,
    int count,
    Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
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
