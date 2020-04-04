import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/country_bloc/country_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/global_page/country_card.dart';
import 'package:covid19_info/ui/widgets/indicators/error_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/empty_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';

class CountryGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'ALL COUNTRIES',
          style: AppTextStyles.largeLight,
        ),
        BlocBuilder<CountryBloc, CountryState>(
          builder: (context, state) {
            if (state is InitialCountryState) {
              return const EmptyIcon();
            } else if (state is LoadedCountryState) {
              return _buildGrid(state);
            } else if (state is ErrorCountryState) {
              return ErrorIcon(message: state.message);
            } else {
              return const BusyIndicator();
            }
          },
        ),
      ],
    );
  }

  Widget _buildGrid(LoadedCountryState state) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, size) => GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16.0),
          scrollDirection: Axis.horizontal,
          itemCount: state.countries.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: size.maxHeight ~/ 160.0,
            childAspectRatio: 1,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
          itemBuilder: (context, index) =>
              CountryCard(country: state.countries[index]),
        ),
      ),
    );
  }
}
