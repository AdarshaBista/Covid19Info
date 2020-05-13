import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/nepal_stats_bloc/nepal_stats_bloc.dart';

import 'package:covid19_info/core/models/nepal_stats.dart';

import 'package:covid19_info/ui/widgets/common/timeline_graph.dart';
import 'package:covid19_info/ui/widgets/nepal_page/stats_grid.dart';
import 'package:covid19_info/ui/widgets/indicators/empty_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/error_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';
import 'package:covid19_info/ui/widgets/common/collapsible_appbar.dart';

class NepalPage extends StatelessWidget {
  const NepalPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
          const CollapsibleAppBar(
            elevation: 0.0,
            title: 'NEPAL STATS',
            imageUrl: 'assets/images/nepal_header.png',
          ),
        ],
        body: BlocBuilder<NepalStatsBloc, NepalStatsState>(
          builder: (context, state) {
            if (state is InitialNepalStatsState) {
              return const EmptyIcon();
            } else if (state is LoadedNepalStatsState) {
              return _buildNepalStats(state.nepalStats);
            } else if (state is ErrorNepalStatsState) {
              return ErrorIcon(message: state.message);
            } else {
              return const BusyIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget _buildNepalStats(NepalStats nepalStats) {
    return ListView(
      children: [
        StatsGrid(nepalStats: nepalStats),
        TimelineGraph(
          title: 'Nepal',
          timeline: nepalStats.timeline,
        ),
      ],
    );
  }
}
