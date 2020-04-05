import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/country.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/common/label.dart';
import 'package:covid19_info/ui/widgets/global_page/country_stat_chart.dart';

class CountryCard extends StatelessWidget {
  final Country country;

  const CountryCard({
    @required this.country,
  }) : assert(country != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Open country detail
      },
      child: Container(
        height: 128.0,
        margin: const EdgeInsets.only(top: 8.0, right: 16.0, bottom: 8.0),
        padding: const EdgeInsets.only(top: 12.0, left: 12.0, bottom: 12.0),
        decoration: BoxDecoration(
          color: AppColors.dark,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(64.0),
            bottomRight: Radius.circular(64.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(width: 12.0),
            Flexible(
              flex: 2,
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      country.data.name,
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
            ),
            _buildGraph(),
          ],
        ),
      ),
    );
  }

  Column _buildStatColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildCount('Active', Colors.yellow, country.data.active),
        const SizedBox(height: 8.0),
        _buildCount('Recovered', Colors.green, country.data.recovered),
        const SizedBox(height: 8.0),
        _buildCount('Deaths', Colors.red, country.data.deaths),
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

  Flexible _buildGraph() {
    return Flexible(
      flex: 1,
      child: CountryStatChart(
        active: country.data.active,
        recovered: country.data.recovered,
        deaths: country.data.deaths,
      ),
    );
  }
}
