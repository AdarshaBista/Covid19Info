import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/district.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/common/stat_card.dart';
import 'package:covid19_info/ui/widgets/nepal_page/covid_case_card.dart';

class DistrictDetails extends StatelessWidget {
  final District district;

  const DistrictDetails({
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
        const SizedBox(height: 16.0),
        _buildStat(),
        const SizedBox(height: 16.0),
        Text(
          'Individual Cases',
          style: AppTextStyles.mediumLight,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        _buildGrid(),
      ],
    );
  }

  Widget _buildStat() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          StatCard(
            label: 'Province',
            count: district.province.toString(),
            color: Colors.grey,
            backgroundColor: AppColors.background.withOpacity(0.5),
          ),
          StatCard(
            label: 'Confirmed',
            count: district.cases.length.toString(),
            color: Colors.blue,
            backgroundColor: AppColors.background.withOpacity(0.5),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    return Center(
      child: Container(
        height: 320.0,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
          ),
          padding: const EdgeInsets.all(16.0),
          scrollDirection: Axis.horizontal,
          addAutomaticKeepAlives: true,
          itemCount: district.cases.length,
          itemBuilder: (context, index) {
            return CovidCaseCard(
              covidCase: district.cases[index],
              color: AppColors.accentColors[index % AppColors.accentColors.length],
            );
          },
        ),
      ),
    );
  }
}
