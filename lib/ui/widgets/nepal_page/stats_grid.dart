import 'package:flutter/material.dart';

import 'package:covid19_info/blocs/nepal_stats_bloc/nepal_stats_bloc.dart';

import 'package:covid19_info/ui/widgets/common/stat_card.dart';
import 'package:covid19_info/ui/widgets/common/timeline_graph.dart';

class StatsGrid extends StatelessWidget {
  final LoadedNepalStatsState state;

  const StatsGrid({
    @required this.state,
  }) : assert(state != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GridView.count(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            StatCard(
              label: 'Tested',
              count: state.nepalStats.total.toString(),
              color: Colors.blue,
            ),
            StatCard(
              label: 'Negative',
              count: state.nepalStats.negative.toString(),
              color: Colors.teal,
            ),
            StatCard(
              label: 'Positive',
              count: state.nepalStats.positive.toString(),
              color: Colors.yellow,
            ),
            StatCard(
              label: 'Pending',
              count: state.nepalStats.pendingResult.toString(),
              color: Colors.pinkAccent,
            ),
            StatCard(
              label: 'Isolation',
              count: state.nepalStats.isolation.toString(),
              color: Colors.deepPurple,
            ),
            StatCard(
              label: 'Quarantine',
              count: state.nepalStats.quarantine.toString(),
              color: Colors.grey,
            ),
            StatCard(
              label: 'Recovered',
              count: state.nepalStats.recovered.toString(),
              color: Colors.green,
            ),
            StatCard(
              label: 'Active',
              count: state.nepalStats.active.toString(),
              color: Colors.orange,
            ),
            StatCard(
              label: 'Deaths',
              count: state.nepalStats.deaths.toString(),
              color: Colors.red,
            ),
          ],
        ),
        TimelineGraph(
          title: 'Nepal',
          timeline: state.nepalStats.timeline,
        ),
      ],
    );
  }
}
