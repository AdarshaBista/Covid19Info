import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/district.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/common/stat_card.dart';

class DistrictStatsGrid extends StatelessWidget {
  final District district;

  const DistrictStatsGrid({
    @required this.district,
  }) : assert(district != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'STATS',
          textAlign: TextAlign.center,
          style: AppTextStyles.mediumLight,
        ),
        const SizedBox(height: 8.0),
        GridView.count(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            StatCard(
              label: 'Active',
              color: Colors.yellow,
              count: district.active.toString(),
              backgroundColor: AppColors.background.withOpacity(0.25),
            ),
            StatCard(
              label: 'Recovered',
              color: Colors.green,
              count: district.recovered.toString(),
              backgroundColor: AppColors.background.withOpacity(0.25),
            ),
            StatCard(
              label: 'Deaths',
              color: Colors.red,
              count: district.deaths.toString(),
              backgroundColor: AppColors.background.withOpacity(0.25),
            ),
          ],
        ),
      ],
    );
  }
}
