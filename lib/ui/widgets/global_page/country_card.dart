import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/country.dart';

import 'package:covid19_info/ui/styles/styles.dart';

class CountryCard extends StatelessWidget {
  final Country country;

  const CountryCard({
    @required this.country,
  }) : assert(country != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            country.countryData.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.mediumLight,
          ),
          const SizedBox(height: 8.0),
          // TODO: Show some data
        ],
      ),
    );
  }
}
