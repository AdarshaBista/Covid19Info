import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/common/stat_card.dart';
import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/district.dart';

class DistrictDetails extends StatelessWidget {
  final District district;

  const DistrictDetails({
    @required this.district,
  }) : assert(district != null);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(
          district.title,
          style: AppTextStyles.mediumLight,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 16.0),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              StatCard(
                label: 'Confirmed',
                count: district.cases.length.toString(),
                color: Colors.blue,
                backgroundColor: AppColors.background.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
