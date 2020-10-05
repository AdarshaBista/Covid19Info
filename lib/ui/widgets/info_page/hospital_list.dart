import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/hospital_bloc/hospital_bloc.dart';

import 'package:covid19_info/core/models/hospital.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/common/search_box.dart';
import 'package:covid19_info/ui/widgets/indicators/empty_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/error_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';
import 'package:covid19_info/ui/widgets/info_page/hospital_details/hospital_card.dart';

class HospitalList extends StatelessWidget {
  const HospitalList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 64.0),
      children: [
        const SizedBox(height: 8.0),
        SearchBox(
          hintText: 'Search Hospitals',
          onChanged: (String value) {
            context.bloc<HospitalBloc>().add(SearchHospitalEvent(
                  searchTerm: value,
                ));
          },
        ),
        const SizedBox(height: 8.0),
        BlocBuilder<HospitalBloc, HospitalState>(
          builder: (context, state) {
            if (state is InitialHospitalState) {
              return const EmptyIcon();
            } else if (state is LoadedHospitalState) {
              return _buildList(state.hospitals);
            } else if (state is ErrorHospitalState) {
              return ErrorIcon(message: state.message);
            } else {
              return const BusyIndicator();
            }
          },
        ),
      ],
    );
  }

  Widget _buildList(List<Hospital> hospitals) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: hospitals.length,
      itemBuilder: (_, index) => HospitalCard(
        hospital: hospitals[index],
        color: AppColors.accentColors[index % AppColors.accentColors.length],
      ),
    );
  }
}
