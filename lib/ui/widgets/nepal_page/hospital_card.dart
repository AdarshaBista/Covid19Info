import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/hospital.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:covid19_info/ui/widgets/common/icon_row.dart';

class HospitalCard extends StatelessWidget {
  final Color color;
  final Hospital hospital;

  const HospitalCard({
    @required this.hospital,
    this.color = AppColors.dark,
  }) : assert(hospital != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconRow(
            label: hospital.name,
            iconData: LineAwesomeIcons.hospital_o,
            labelStyle: AppTextStyles.mediumLight,
            color: color,
          ),
          const SizedBox(height: 8.0),
          IconRow(
            label: hospital.address,
            iconData: LineAwesomeIcons.map,
            labelStyle: AppTextStyles.smallLight,
            color: color,
          ),
          const SizedBox(height: 8.0),
          IconRow(
            label: hospital.phone,
            iconData: LineAwesomeIcons.phone,
            labelStyle: AppTextStyles.smallLight,
            color: color,
          ),
        ],
      ),
    );
  }
}
