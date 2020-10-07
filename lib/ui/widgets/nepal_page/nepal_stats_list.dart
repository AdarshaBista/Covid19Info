import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/nepal_stats.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/common/pill.dart';
import 'package:covid19_info/ui/widgets/common/timeline_graph.dart';
import 'package:covid19_info/ui/widgets/nepal_page/nepal_stats_panel.dart';

class NepalStatsList extends StatelessWidget {
  final ScrollController controller;
  final NepalStats nepalStats;

  const NepalStatsList({
    @required this.controller,
    @required this.nepalStats,
  })  : assert(controller != null),
        assert(nepalStats != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 4.0),
        const Pill(),
        const SizedBox(height: 4.0),
        Text(
          'NEPAL STATS',
          style: AppTextStyles.mediumLight,
        ),
        const SizedBox(height: 8.0),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            controller: controller,
            padding: EdgeInsets.zero,
            children: [
              NepalStatsPanel(nepalStats: nepalStats),
              TimelineGraph(
                title: 'Nepal',
                timeline: nepalStats.timeline,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
