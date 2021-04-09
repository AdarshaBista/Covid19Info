import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/country_bloc/country_bloc.dart';
import 'package:covid19_info/blocs/country_detail_bloc/country_detail_bloc.dart';

import 'package:covid19_info/core/models/country.dart';
import 'package:covid19_info/core/services/api_service.dart';

import 'package:covid19_info/ui/widgets/common/map_card.dart';
import 'package:covid19_info/ui/widgets/indicators/empty_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/error_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';

import 'package:covid19_info/ui/pages/country_page.dart';

class GlobalMap extends StatelessWidget {
  const GlobalMap();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryBloc, CountryState>(
      builder: (context, state) {
        if (state is InitialCountryState) {
          return const EmptyIcon();
        } else if (state is LoadedCountryState) {
          return _buildMap(state);
        } else if (state is ErrorCountryState) {
          return ErrorIcon(message: state.message);
        } else {
          return const BusyIndicator();
        }
      },
    );
  }

  Widget _buildMap(LoadedCountryState state) {
    return MapCard(
      zoom: 3.0,
      minZoom: 2.0,
      maxZoom: 6.0,
      markerLayer: _buildMarkers(state),
      searchLocation: () {
        if (!state.shouldShowAllCountries && !state.isSearchEmpty) {
          return LatLng(
            state.searchedCountries.first.lat,
            state.searchedCountries.first.lng,
          );
        }
        return null;
      },
    );
  }

  MarkerLayerWidget _buildMarkers(LoadedCountryState state) {
    return MarkerLayerWidget(
      options: MarkerLayerOptions(
        markers: state.allCountries.map(
          (c) {
            int metric;
            Color color;

            switch (state.filterType) {
              case CountryFilterType.Confirmed:
                metric = c.totalConfirmed;
                color = Colors.blue;
                break;
              case CountryFilterType.Active:
                metric = c.activeCases;
                color = Colors.yellow;
                break;
              case CountryFilterType.Recovered:
                metric = c.totalRecovered;
                color = Colors.green;
                break;
              case CountryFilterType.Deaths:
                metric = c.totalDeaths;
                color = Colors.red;
                break;

              default:
            }

            final double diameter = (math.sqrt(metric.toDouble()) / 30.0)
                .clamp(12.0, double.maxFinite)
                .toDouble();
            return Marker(
              height: diameter,
              width: diameter,
              point: LatLng(c.lat, c.lng),
              builder: (context) => GestureDetector(
                onTap: () => _navigateToDetailsPage(context, c),
                child: CircleAvatar(
                  backgroundColor: state.isCountryInSearch(c)
                      ? Colors.deepPurple.withOpacity(0.4)
                      : color.withOpacity(0.4),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  void _navigateToDetailsPage(BuildContext context, Country country) {
    FocusScope.of(context).unfocus();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => CountryDetailBloc(
            apiService: context.read<ApiService>(),
          )..add(GetCountryDetailEvent(country: country)),
          child: CountryPage(
            country: country,
          ),
        ),
      ),
    );
  }
}
