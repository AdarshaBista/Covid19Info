import 'package:flutter/material.dart';

import 'package:covid19_info/blocs/nepal_stats_bloc/nepal_stats_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/common/stat_card.dart';

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
        Text(
          'TESTED',
          style: AppTextStyles.largeLight,
        ),
        const SizedBox(height: 16.0),
        GridView.count(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            StatCard(
              label: 'Total',
              count: state.nepalStats.total.toString(),
              color: Colors.blue,
            ),
            StatCard(
              label: 'Negative',
              count: state.nepalStats.negative.toString(),
              color: Colors.green,
            ),
            StatCard(
              label: 'Positive',
              count: state.nepalStats.positive.toString(),
              color: Colors.yellow,
            ),
            StatCard(
              label: 'Isolation',
              count: state.nepalStats.isolation.toString(),
              color: Colors.deepPurple,
            ),
            StatCard(
              label: 'Deaths',
              count: state.nepalStats.deaths.toString(),
              color: Colors.red,
            ),
          ],
        ),
      ],
    );
  }
}
