import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/district.dart';

import 'package:covid19_info/ui/styles/styles.dart';

class DistrictHeader extends StatelessWidget {
  final District district;

  const DistrictHeader({
    @required this.district,
  }) : assert(district != null);

  @override
  Widget build(BuildContext context) {
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
            leading: const Icon(
              Icons.map,
              color: AppColors.primary,
            ),
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
