import 'package:flutter/material.dart';

import 'package:covid19_info/api_keys.dart';
import 'package:covid19_info/core/models/country.dart';

import 'package:covid19_info/ui/pages/country_details_page.dart';
import 'package:covid19_info/core/services/global_api_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/country_bloc/country_bloc.dart';
import 'package:covid19_info/blocs/country_detail_bloc/country_detail_bloc.dart';

import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

import 'package:covid19_info/ui/widgets/indicators/error_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/empty_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';
import 'package:covid19_info/ui/widgets/common/country_stat_chart.dart';

class MapCard extends StatelessWidget {
  final MapController _mapController = MapController();

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
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          interactive: true,
          zoom: 2.0,
          center: LatLng(countries.first.lat, countries.first.lng),
        ),
        layers: [
          TileLayerOptions(
            keepBuffer: 8,
            maxZoom: 16,
            urlTemplate: "https://api.tiles.mapbox.com/v4/"
                "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
            additionalOptions: {
              'accessToken': MAPBOX_ACCESS_TOKEN,
              'id': 'mapbox.dark',
            },
          ),
          MarkerClusterLayerOptions(
            maxClusterRadius: 120,
            size: Size(40, 40),
            // fitBoundsOptions: FitBoundsOptions(
            //   padding: EdgeInsets.all(50),
            // ),
            zoomToBoundsOnClick: true,
            markers: countries
                .map((c) => Marker(
                      point: LatLng(c.lat, c.lng),
                      builder: (context) => GestureDetector(
                        onTap: () => _navigateToDetailsPage(context, c),
                        // child: CountryStatChart(
                        //   active: c.activeCases,
                        //   recovered: c.totalRecovered,
                        //   deaths: c.totalDeaths,
                        //   centerSpaceRadius: 8.0,
                        //   radius: 4.0,
                        // ),
                        child: Icon(Icons.local_airport),
                      ),
                    ))
                .toList(),
            polygonOptions: PolygonOptions(
              borderColor: Colors.blueAccent,
              color: Colors.black12,
              borderStrokeWidth: 3,
            ),
            builder: (context, markers) {
              return FloatingActionButton(
                child: Text(markers.length.toString()),
                onPressed: () {},
              );
            },
          ),
        ],
      ),
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
