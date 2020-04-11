import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:covid19_info/api_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/country_bloc/country_bloc.dart';
import 'package:covid19_info/blocs/country_detail_bloc/country_detail_bloc.dart';

import 'package:covid19_info/core/models/country.dart';
import 'package:covid19_info/core/services/global_api_service.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/indicators/empty_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/error_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';

import 'package:covid19_info/ui/pages/country_details_page.dart';

class MapCard extends StatefulWidget {
  @override
  _MapCardState createState() => _MapCardState();
}

class _MapCardState extends State<MapCard> with TickerProviderStateMixin {
  MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryBloc, CountryState>(
      builder: (context, state) {
        if (state is InitialCountryState) {
          return const EmptyIcon();
        } else if (state is LoadedCountryState) {
          return _buildMap(state, context);
        } else if (state is ErrorCountryState) {
          return ErrorIcon(message: state.message);
        } else {
          return const BusyIndicator();
        }
      },
    );
  }

  Widget _buildMap(LoadedCountryState state, BuildContext context) {
    if (!state.shouldShowAllCountries && !state.isSearchEmpty) {
      _animateMapTo(LatLng(
        state.searchedCountries.first.lat,
        state.searchedCountries.first.lng,
      ));
    }

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        zoom: 3.0,
        minZoom: 2.0,
        maxZoom: 6.0,
        interactive: true,
      ),
      layers: [
        _buildTiles(),
        _buildMarkers(state),
      ],
    );
  }

  TileLayerOptions _buildTiles() {
    return TileLayerOptions(
      tileProvider: Platform.isWindows ? NetworkTileProvider() : const CachedNetworkTileProvider(),
      backgroundColor: AppColors.background,
      keepBuffer: 8,
      urlTemplate: "https://api.tiles.mapbox.com/v4/"
          "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
      additionalOptions: {
        'accessToken': MAPBOX_ACCESS_TOKEN,
        'id': 'mapbox.dark',
      },
    );
  }

  MarkerLayerOptions _buildMarkers(LoadedCountryState state) {
    return MarkerLayerOptions(
      markers: state.allCountries.map(
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
                backgroundColor: state.isCountryInSearch(c)
                    ? Colors.blue.withOpacity(0.4)
                    : Colors.red.withOpacity(0.4),
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  void _animateMapTo(LatLng destLocation) {
    final destZoom = 4.0;
    final _latTween = Tween<double>(
      begin: _mapController.center.latitude,
      end: destLocation.latitude,
    );
    final _lngTween = Tween<double>(
      begin: _mapController.center.longitude,
      end: destLocation.longitude,
    );
    final _zoomTween = Tween<double>(
      begin: _mapController.zoom,
      end: destZoom,
    );

    AnimationController animController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    Animation<double> animation = CurvedAnimation(
      parent: animController,
      curve: Curves.fastOutSlowIn,
    );

    animController.addListener(() {
      _mapController.move(
        LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
        _zoomTween.evaluate(animation),
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animController.dispose();
      } else if (status == AnimationStatus.dismissed) {
        animController.dispose();
      }
    });
    animController.forward();
  }

  void _navigateToDetailsPage(BuildContext context, Country country) {
    FocusScope.of(context).unfocus();
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
