import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:covid19_info/api_keys.dart';
import 'package:covid19_info/core/models/country.dart';
import 'package:covid19_info/core/services/global_api_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/country_bloc/country_bloc.dart';
import 'package:covid19_info/blocs/country_detail_bloc/country_detail_bloc.dart';

import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:covid19_info/ui/pages/country_details_page.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/indicators/error_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/empty_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';

class MapCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryBloc, CountryState>(
      builder: (context, state) {
        if (state is InitialCountryState) {
          return const EmptyIcon();
        } else if (state is LoadedCountryState) {
          return _buildMap(state.countries, context);
        } else if (state is ErrorCountryState) {
          return ErrorIcon(message: state.message);
        } else {
          return const BusyIndicator();
        }
      },
    );
  }

  Widget _buildMap(List<Country> countries, BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        zoom: 3.0,
        minZoom: 2.0,
        maxZoom: 6.0,
        interactive: true,
        center: LatLng(countries.first.lat, countries.first.lng),
      ),
      layers: [
        TileLayerOptions(
          backgroundColor: AppColors.background,
          keepBuffer: 8,
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
          additionalOptions: {
            'accessToken': MAPBOX_ACCESS_TOKEN,
            'id': 'mapbox.dark',
          },
        ),
        MarkerLayerOptions(
          markers: countries.map(
            (c) {
              double radius = (math.sqrt(c.totalConfirmed.toDouble()) / 8.0).clamp(8.0, 120.0);
              return Marker(
                height: radius,
                width: radius,
                point: LatLng(c.lat, c.lng),
                builder: (context) => GestureDetector(
                  onTap: () => _navigateToDetailsPage(context, c),
                  child: CircleAvatar(
                    radius: radius,
                    backgroundColor: Colors.red.withOpacity(0.4),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }

  void _navigateToDetailsPage(BuildContext context, Country country) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => CountryDetailBloc(
            apiService: context.repository<GlobalApiService>(),
          ),
          child: CountryDetailsPage(
            country: country,
          ),
        ),
      ),
    );
  }
}
