import 'package:flutter/material.dart';

import 'package:covid19_info/blocs/nepal_stats_bloc/nepal_stats_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/nepal_page/stat_card.dart';

class StatsRow extends StatelessWidget {
  final LoadedNepalStatsState state;

  const StatsRow({
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StatCard(
              label: 'Total',
              count: state.nepalStats.total,
              color: Colors.blue,
            ),
            StatCard(
              label: 'Negative',
              count: state.nepalStats.negative,
              color: Colors.green,
            ),
            StatCard(
              label: 'Positive',
              count: state.nepalStats.positive,
              color: Colors.red,
            ),
          ],
        ),
      ],
    );
  }
}
