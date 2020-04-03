import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/global_stats_bloc/global_stats_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:covid19_info/ui/widgets/global_page/global_details.dart';
import 'package:covid19_info/ui/widgets/indicators/error_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/empty_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';

class GlobalPage extends StatefulWidget {
  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.bloc<GlobalStatsBloc>()..add(GetGlobalStatsEvent());
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
          minHeight: 110.0,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          panel: BlocBuilder<GlobalStatsBloc, GlobalStatsState>(
            builder: (context, state) {
              if (state is InitialGlobalStatsState) {
                return const EmptyIcon();
              } else if (state is LoadedGlobalStatsState) {
                return GlobalDetails(state: state);
              } else if (state is ErrorGlobalStatsState) {
                return ErrorIcon(message: state.message);
              } else {
                return const BusyIndicator();
              }
            },
          ),
          body: Center(
            child: Text("This is the Widget behind the sliding panel"),
          ),
        ),
      ),
    );
  }
}
