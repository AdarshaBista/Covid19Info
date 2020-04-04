import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/country_bloc/country_bloc.dart';
import 'package:covid19_info/blocs/global_stats_bloc/global_stats_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:covid19_info/ui/widgets/global_page/country_grid.dart';
import 'package:covid19_info/ui/widgets/global_page/global_stats_row.dart';

class GlobalPage extends StatefulWidget {
  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.bloc<GlobalStatsBloc>()..add(GetGlobalStatsEvent());
    context.bloc<CountryBloc>()..add(GetCountryEvent());
  }

  @override
  Widget build(BuildContext context) {
    const double minHeight = 110.0;
    return SafeArea(
      child: Scaffold(
        body: SlidingUpPanel(
          color: AppColors.dark,
          isDraggable: true,
          backdropEnabled: true,
          parallaxEnabled: true,
          parallaxOffset: 0.5,
          slideDirection: SlideDirection.DOWN,
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.all(12.0),
          maxHeight: MediaQuery.of(context).size.height,
          minHeight: minHeight,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          panel: _buildPanelContent(minHeight),
          body: Center(child: Text('MAP')),
        ),
      ),
    );
  }

  Widget _buildPanelContent(double minHeight) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(height: minHeight + 64.0),
        Expanded(child: CountryGrid()),
        const SizedBox(height: 32.0),
        GlobalStatsRow(),
      ],
    );
  }
}
