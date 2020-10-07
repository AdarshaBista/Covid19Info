import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/district.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/nepal_page/gender_bar_graph.dart';
import 'package:covid19_info/ui/widgets/common/cases_distribution.dart';
import 'package:covid19_info/ui/widgets/nepal_page/district_stats_grid.dart';
import 'package:covid19_info/ui/widgets/nepal_page/individual_cases_list.dart';

class DistrictSheet extends StatelessWidget {
  final District district;

  const DistrictSheet({
    @required this.district,
  }) : assert(district != null);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 16.0),
        Text(
          district.title.toUpperCase(),
          style: AppTextStyles.mediumLight.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        _buildDivider(),
        _buildStat(),
        _buildDivider(),
        DistrictStatsGrid(district: district),
        const SizedBox(height: 16.0),
        CasesDistribution(
          active: district.active,
          deaths: district.deaths,
          recovered: district.recovered,
        ),
        _buildDivider(),
        GenderBarGraph(district: district),
        _buildDivider(),
        IndividualCasesList(district: district),
      ],
    );
  }

  Widget _buildDivider() {
    return Column(
      children: const [
        SizedBox(height: 8.0),
        Divider(height: 16.0, indent: 32.0, endIndent: 32.0),
        SizedBox(height: 8.0),
      ],
    );
  }

  Widget _buildStat() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            dense: true,
            title: Text(
              'Province',
              style: AppTextStyles.smallLight,
            ),
            leading: const Icon(Icons.map),
            trailing: Text(
              district.province.toString(),
              style: AppTextStyles.mediumLight.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              'Confirmed',
              style: AppTextStyles.smallLight,
            ),
            leading: const Icon(Icons.local_hospital, color: Colors.red),
            trailing: Text(
              district.cases.length.toString(),
              style: AppTextStyles.mediumLight.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
