import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/country_detail_bloc/country_detail_bloc.dart';

import 'package:covid19_info/core/models/country.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/common/timeline_graph.dart';
import 'package:covid19_info/ui/widgets/indicators/error_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/empty_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';
import 'package:covid19_info/ui/widgets/country_detail_page/daily_stats_row.dart';
import 'package:covid19_info/ui/widgets/country_detail_page/country_pie_chart.dart';
import 'package:covid19_info/ui/widgets/country_detail_page/country_stats_grid.dart';

class CountryDetailsPage extends StatelessWidget {
  final Country country;

  const CountryDetailsPage({
    @required this.country,
  }) : assert(country != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8.0,
        backgroundColor: AppColors.dark,
        centerTitle: true,
        title: Hero(
          tag: country.name,
          child: Material(
            color: Colors.transparent,
            child: Text(
              country.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.largeLightSerif,
            ),
          ),
        ),
      ),
      body: BlocBuilder<CountryDetailBloc, CountryDetailState>(
        builder: (context, state) {
          if (state is InitialCountryDetailState) {
            return const EmptyIcon();
          } else if (state is LoadedCountryDetailState) {
            return _buildContent(state.country);
          } else if (state is ErrorCountryDetailState) {
            return ErrorIcon(message: state.message);
          } else {
            return const BusyIndicator();
          }
        },
      ),
    );
  }

  Widget _buildContent(Country c) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        CountryPieChart(country: c),
        const Divider(height: 32.0),
        CountryStatsGrid(country: c),
        const SizedBox(height: 24.0),
        DailyStatsRow(country: c),
        const SizedBox(height: 24.0),
        TimelineGraph(
          title: c.name,
          timeline: c.timeline,
        ),
      ],
    );
  }
}
