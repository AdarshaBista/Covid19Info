import 'dart:math';

import 'package:flutter/material.dart';

import 'package:covid19_info/blocs/hospital_bloc/hospital_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/nepal_page/hospital_card.dart';

class HospitalList extends StatelessWidget {
  final LoadedHospitalState state;

  const HospitalList({
    @required this.state,
  }) : assert(state != null);

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
            ...state.hospitals
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
