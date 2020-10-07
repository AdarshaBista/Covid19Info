import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/district.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/common/pill.dart';
import 'package:covid19_info/ui/widgets/common/cases_distribution.dart';
import 'package:covid19_info/ui/widgets/district_page/gender_bar_graph.dart';
import 'package:covid19_info/ui/widgets/district_page/district_stats_grid.dart';

class DistrictPanel extends StatelessWidget {
  final District district;
  final ScrollController controller;

  const DistrictPanel({
    @required this.district,
    @required this.controller,
  })  : assert(district != null),
        assert(controller != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 4.0),
        const Pill(),
        const SizedBox(height: 4.0),
        Text(
          district.title.toUpperCase(),
          style: AppTextStyles.mediumLight,
        ),
        const SizedBox(height: 8.0),
        const Divider(height: 8.0, indent: 32.0, endIndent: 32.0),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            controller: controller,
            children: [
              _buildStat(),
              _buildDivider(),
              DistrictStatsGrid(district: district),
              _buildDivider(),
              CasesDistribution(
                active: district.active,
                deaths: district.deaths,
                recovered: district.recovered,
              ),
              _buildDivider(),
              GenderBarGraph(district: district),
            ],
          ),
        ),
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
              district.confirmed.toString(),
              style: AppTextStyles.mediumLight.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
