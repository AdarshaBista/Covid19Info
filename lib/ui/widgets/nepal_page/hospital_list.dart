import 'dart:math';

import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/hospital.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/common/search_box.dart';
import 'package:covid19_info/ui/widgets/nepal_page/hospital_card.dart';

class HospitalList extends StatelessWidget {
  final List<Hospital> hospitals;

  const HospitalList({
    @required this.hospitals,
  }) : assert(hospitals != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'HOSPITALS',
          style: AppTextStyles.largeLight,
        ),
        const SizedBox(height: 16.0),
        Column(
          children: [
            SearchBox(
              onChanged: (String value) {},
            ),
            ...hospitals
                .map(
                  (h) => HospitalCard(
                    hospital: h,
                    color: AppColors.accentColors[
                        Random().nextInt(AppColors.accentColors.length)],
                  ),
                )
                .toList(),
          ],
        ),
      ],
    );
  }
}
