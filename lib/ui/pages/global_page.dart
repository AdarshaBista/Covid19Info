import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/global_stats/global_stats_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:covid19_info/ui/widgets/global_page/global_stats_row.dart';

class GlobalPage extends StatefulWidget {
  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.bloc<GlobalStatsBloc>()..add(GetWorldStatsEvent());
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
          collapsed: GlobalStatsRow(),
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
