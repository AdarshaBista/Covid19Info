import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/country_bloc/country_bloc.dart';

import 'package:covid19_info/core/models/country.dart';

import 'package:covid19_info/ui/widgets/common/search_box.dart';
import 'package:covid19_info/ui/widgets/global_page/country_card.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';
import 'package:covid19_info/ui/widgets/indicators/empty_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/error_icon.dart';

class CountryList extends StatelessWidget {
  final ScrollController controller;

  const CountryList({
    @required this.controller,
  }) : assert(controller != null);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryBloc, CountryState>(
      builder: (context, state) {
        if (state is InitialCountryState) {
          return const EmptyIcon();
        } else if (state is LoadedCountryState) {
          if (state.shouldShowAllCountries) {
            return _buildList(context, state.allCountries);
          }
          return _buildList(context, state.searchedCountries);
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
      children: [
        SearchBox(
          hintText: 'Search Countries',
          onChanged: (String value) {
            context.bloc<CountryBloc>().add(SearchCountryEvent(
                  searchTerm: value,
                ));
          },
        ),
        const SizedBox(height: 8.0),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            controller: controller,
            padding: EdgeInsets.zero,
            itemCount: countries.length,
            itemBuilder: (context, index) => CountryCard(
              country: countries[index],
            ),
          ),
        ),
      ],
    );
  }
}
