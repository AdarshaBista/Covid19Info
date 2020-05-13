import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/hospital.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/info_page/hospital_details/action_row.dart';
import 'package:covid19_info/ui/widgets/info_page/hospital_details/contact_card.dart';
import 'package:covid19_info/ui/widgets/info_page/hospital_details/capacity_card.dart';
import 'package:covid19_info/ui/widgets/info_page/hospital_details/hospital_info.dart';

class HospitalDetails extends StatelessWidget {
  final Hospital hospital;
  final Color color;

  const HospitalDetails({
    @required this.hospital,
    @required this.color,
  })  : assert(hospital != null),
        assert(color != null);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        Text(
          hospital.name,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: AppTextStyles.largeLight,
        ),
        Divider(
          height: 16.0,
          color: AppColors.light.withOpacity(0.2),
        ),
        HospitalInfo(
          hospital: hospital,
          color: color,
        ),
        const SizedBox(height: 16.0),
        ActionRow(
          hospital: hospital,
          color: color,
        ),
        const SizedBox(height: 16.0),
        if (hospital.contactPerson.isNotEmpty)
          ContactCard(
            name: hospital.contactPerson,
            number: hospital.contactPersonNumber,
            color: color,
          ),
        if (!hospital.capacity.isEmpty)
          CapacityCard(
            capacity: hospital.capacity,
          ),
      ],
    );
  }
}
