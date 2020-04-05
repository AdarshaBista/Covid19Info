import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/country_bloc/country_bloc.dart';

import 'package:covid19_info/core/models/country.dart';

import 'package:covid19_info/ui/widgets/global_page/country_card.dart';
import 'package:covid19_info/ui/widgets/indicators/empty_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/error_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';

class CountryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryBloc, CountryState>(
      builder: (context, state) {
        if (state is InitialCountryState) {
          return const EmptyIcon();
        } else if (state is LoadedCountryState) {
          return _buildList(state.countries);
        } else if (state is ErrorCountryState) {
          return ErrorIcon(message: state.message);
        } else {
          return const BusyIndicator();
        }
      },
    );
  }

  Widget _buildList(List<Country> countries) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: countries.map((c) => CountryCard(country: c)).toList(),
    );
  }
}
