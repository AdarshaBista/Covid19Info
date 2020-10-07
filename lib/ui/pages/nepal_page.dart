import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/nepal_stats_bloc/nepal_stats_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:covid19_info/ui/widgets/indicators/empty_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/error_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';
import 'package:covid19_info/ui/widgets/nepal_page/nepal_map.dart';
import 'package:covid19_info/ui/widgets/nepal_page/nepal_stats_list.dart';

class NepalPage extends StatelessWidget {
  const NepalPage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Stack(
          children: <Widget>[
            const NepalMap(),
            SlidingUpPanel(
              color: AppColors.background,
              parallaxOffset: 0.3,
              backdropEnabled: true,
              parallaxEnabled: true,
              margin: EdgeInsets.zero,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              maxHeight: MediaQuery.of(context).size.height * 0.7,
              minHeight: 50.0,
              panelBuilder: _buildNepalStatsPanel,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNepalStatsPanel(ScrollController sc) {
    return BlocBuilder<NepalStatsBloc, NepalStatsState>(
      builder: (context, state) {
        if (state is InitialNepalStatsState) {
          return const EmptyIcon();
        } else if (state is LoadedNepalStatsState) {
          return NepalStatsList(
            controller: sc,
            nepalStats: state.nepalStats,
          );
        } else if (state is ErrorNepalStatsState) {
          return ErrorIcon(message: state.message);
        } else {
          return const BusyIndicator();
        }
      },
    );
  }
}
