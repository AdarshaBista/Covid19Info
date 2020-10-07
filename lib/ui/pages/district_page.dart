import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/district.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/common/cases_distribution.dart';
import 'package:covid19_info/ui/widgets/district_page/district_header.dart';
import 'package:covid19_info/ui/widgets/district_page/gender_bar_graph.dart';
import 'package:covid19_info/ui/widgets/district_page/district_stats_grid.dart';

class DistrictPage extends StatelessWidget {
  final District district;

  const DistrictPage({
    @required this.district,
  }) : assert(district != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8.0,
        backgroundColor: AppColors.background,
        centerTitle: true,
        title: Text(
          district.title.toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.largeLightSerif,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          DistrictHeader(
            district: district,
          ),
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
}
