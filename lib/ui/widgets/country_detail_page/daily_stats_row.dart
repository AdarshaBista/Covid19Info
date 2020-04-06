import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/country.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/common/stat_card.dart';

class DailyStatsRow extends StatelessWidget {
  final Country country;

  const DailyStatsRow({
    @required this.country,
  }) : assert(country != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'DAILY UPDATE',
          style: AppTextStyles.largeLight,
        ),
        const SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StatCard(
                label: 'Confirmed Today',
                count: country.dailyConfirmed.toString(),
                color: Colors.lightBlue,
              ),
              StatCard(
                label: 'Deaths Today',
                count: country.dailyDeaths.toString(),
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
