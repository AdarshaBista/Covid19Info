import 'package:flutter/material.dart';

import 'package:covid19_info/blocs/global_stats_bloc/global_stats_bloc.dart';

import 'package:covid19_info/ui/widgets/common/timeline_graph.dart';
import 'package:covid19_info/ui/widgets/global_page/global_stats_row.dart';

class GlobalDetails extends StatelessWidget {
  final LoadedGlobalStatsState state;

  const GlobalDetails({
    @required this.state,
  }) : assert(state != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TimelineGraph(
          title: 'Global',
          timeline: state.globalTimeline,
        ),
        const SizedBox(height: 32.0),
        GlobalStatsRow(),
      ],
    );
  }
}
