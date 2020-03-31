import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/hospital.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/nepal_page/hospital_card.dart';

class HospitalList extends StatelessWidget {
  final List<Hospital> hospitals;

  const HospitalList({
    @required this.hospitals,
  }) : assert(hospitals != null);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      addAutomaticKeepAlives: false,
      itemCount: hospitals.length,
      itemBuilder: (_, index) => HospitalCard(
        hospital: hospitals[index],
        color: AppColors.accentColors[index % AppColors.accentColors.length],
      ),
    );
  }
}
