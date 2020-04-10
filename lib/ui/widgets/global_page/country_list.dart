import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/country_bloc/country_bloc.dart';

import 'package:covid19_info/core/models/country.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/common/search_box.dart';
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
          return _buildList(context, state.countries);
        } else if (state is ErrorCountryState) {
          return ErrorIcon(message: state.message);
        } else {
          return const BusyIndicator();
        }
      },
    );
  }

  Widget _buildList(BuildContext context, List<Country> countries) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'COUNTRIES',
          style: AppTextStyles.largeLight,
        ),
        const SizedBox(height: 16.0),
        SearchBox(
          margin: const EdgeInsets.only(top: 8.0, left: 20.0, bottom: 8.0),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.0),
            bottomLeft: Radius.circular(32.0),
          ),
          hintText: 'Search Countries',
          onChanged: (String value) {
            context.bloc<CountryBloc>()
              ..add(SearchCountryEvent(
                searchTerm: value,
              ));
          },
        ),
        ...countries.map((c) => CountryCard(country: c)).toList(),
      ],
    );
  }
}
