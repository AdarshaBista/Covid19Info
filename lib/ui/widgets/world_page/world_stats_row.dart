import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/world_stats/world_stats_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid19_info/ui/widgets/indicators/empty_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/error_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';

class WorldStatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldStatsBloc, WorldStatsState>(
      builder: (context, state) {
        if (state is InitialWorldStatsState) {
          return const EmptyIcon();
        } else if (state is LoadedWorldStatsState) {
          return _buildStatsRow(state);
        } else if (state is ErrorWorldStatsState) {
          return ErrorIcon(message: state.message);
        } else {
          return const BusyIndicator();
        }
      },
    );
  }

  Widget _buildStatsRow(LoadedWorldStatsState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        _buildStat(
          label: 'Confirmed',
          count: state.worldStats.confirmed,
          color: Colors.blue,
        ),
        _buildStat(
          label: 'Recovered',
          count: state.worldStats.recovered,
          color: Colors.green,
          showIcon: true,
        ),
        _buildStat(
          label: 'Deaths',
          count: state.worldStats.deaths,
          color: Colors.red,
        ),
      ],
    );
  }

  Widget _buildStat({
    String label,
    int count,
    Color color,
    bool showIcon = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: AutoSizeText(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.smallLight,
            ),
          ),
          const SizedBox(height: 8.0),
          Flexible(
            child: AutoSizeText(
              count.toString(),
              style: AppTextStyles.largeLight.copyWith(color: color),
            ),
          ),
          const SizedBox(height: 12.0),
          Icon(
            Icons.keyboard_arrow_down,
            size: 14.0,
            color: showIcon ? AppColors.light : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
