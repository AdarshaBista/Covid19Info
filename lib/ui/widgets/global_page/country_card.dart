import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/country_detail_bloc/country_detail_bloc.dart';

import 'package:covid19_info/core/models/country.dart';
import 'package:covid19_info/core/services/global_api_service.dart';

import 'package:covid19_info/ui/pages/country_details_page.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/common/label.dart';
import 'package:covid19_info/ui/widgets/common/country_stat_chart.dart';

class CountryCard extends StatelessWidget {
  final Country country;

  const CountryCard({
    @required this.country,
  }) : assert(country != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetailsPage(context),
      child: Container(
        height: 120.0,
        margin: const EdgeInsets.only(top: 8.0, left: 16.0, bottom: 8.0),
        padding: const EdgeInsets.only(top: 12.0, right: 12.0, bottom: 12.0),
        decoration: BoxDecoration(
          color: AppColors.dark,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(64.0),
            bottomLeft: Radius.circular(64.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(width: 12.0),
            _buildGraph(),
            _buildStats(),
          ],
        ),
      ),
    );
  }

  Flexible _buildStats() {
    return Flexible(
      flex: 2,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Text(
              country.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.mediumLight,
            ),
          ),
          const Divider(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: _buildStatColumn(),
          ),
        ],
      ),
    );
  }

  Column _buildStatColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildCount('Active', Colors.yellow, country.activeCases),
        const SizedBox(height: 8.0),
        _buildCount('Recovered', Colors.green, country.totalRecovered),
        const SizedBox(height: 8.0),
        _buildCount('Deaths', Colors.red, country.totalDeaths),
      ],
    );
  }

  Widget _buildCount(String label, Color color, int count) {
    return Row(
      children: <Widget>[
        Label(text: label, color: color),
        const Spacer(),
        Text(
          count.toString(),
          style: AppTextStyles.smallLight.copyWith(color: color),
        ),
      ],
    );
  }

  Widget _buildGraph() {
    return Flexible(
      flex: 1,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CountryStatChart(
            active: country.activeCases,
            recovered: country.totalRecovered,
            deaths: country.totalDeaths,
          ),
          Container(
            height: 48.0,
            width: 48.0,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Image.network(
              'https://www.countryflags.io/${country.code}/flat/48.png',
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToDetailsPage(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => CountryDetailBloc(
            apiService: context.repository<GlobalApiService>(),
          ),
          child: CountryDetailsPage(
            country: country,
          ),
        ),
      ),
    );
  }
}
