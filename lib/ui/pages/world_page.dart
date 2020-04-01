import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/world_stats/world_stats_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:covid19_info/ui/widgets/world_page/world_stats_row.dart';

class WorldPage extends StatefulWidget {
  @override
  _WorldPageState createState() => _WorldPageState();
}

class _WorldPageState extends State<WorldPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.bloc<WorldStatsBloc>()..add(GetWorldStatsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SlidingUpPanel(
          color: AppColors.dark,
          isDraggable: true,
          backdropEnabled: true,
          parallaxEnabled: true,
          slideDirection: SlideDirection.DOWN,
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.all(12.0),
          maxHeight: MediaQuery.of(context).size.height,
          minHeight: 120.0,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          collapsed: WorldStatsRow(),
          panelBuilder: (scrollController) => Center(
            child: Text("This is the sliding Widget"),
          ),
          body: Center(
            child: Text("This is the Widget behind the sliding panel"),
          ),
        ),
      ),
    );
  }
}
