import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/district.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/nepal_page/covid_case_card.dart';

class IndividualCasesList extends StatelessWidget {
  final District district;

  const IndividualCasesList({
    @required this.district,
  }) : assert(district != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'INDIVIDUAL CASES',
          style: AppTextStyles.mediumLight,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        _buildGrid(),
      ],
    );
  }

  Widget _buildGrid() {
    return SizedBox(
      height: 600.0,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: district.cases.length,
        itemBuilder: (context, index) {
          return CovidCaseCard(
            covidCase: district.cases[index],
            color: AppColors.accentColors[index % AppColors.accentColors.length],
          );
        },
      ),
    );
  }
}
