import 'package:flutter/material.dart';

import 'package:latlong/latlong.dart';
import 'package:covid19_info/core/models/district.dart';
import 'package:covid19_info/core/models/municipality.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/municipality_bloc/municipality_bloc.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/common/map_card.dart';
import 'package:covid19_info/ui/widgets/indicators/error_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/empty_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';

class DistrictMap extends StatelessWidget {
  final District district;

  const DistrictMap({
    @required this.district,
  }) : assert(district != null);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MunicipalityBloc, MunicipalityState>(
      builder: (context, state) {
        if (state is InitialMunicipalityState) {
          return const EmptyIcon();
        } else if (state is LoadedMunicipalityState) {
          return _buildMap(state);
        } else if (state is ErrorMunicipalityState) {
          return ErrorIcon(message: state.message);
        } else {
          return const BusyIndicator();
        }
      },
    );
  }

  Widget _buildMap(LoadedMunicipalityState state) {
    return MapCard(
      center: LatLng(district.lat, district.lng),
      zoom: 12.0,
      minZoom: 10.0,
      maxZoom: 15.0,
      nePanBoundary: LatLng(district.lat + 0.5, district.lng + 0.5),
      swPanBoundary: LatLng(district.lat - 0.5, district.lng - 0.5),
      markerLayer: _buildMarkers(state),
      searchLocation: () => null,
    );
  }

  MarkerLayerWidget _buildMarkers(LoadedMunicipalityState state) {
    return MarkerLayerWidget(
      options: MarkerLayerOptions(
        markers: state.municipalities.map(
          (m) {
            return Marker(
              height: 64.0,
              width: 1000.0,
              point: LatLng(m.lat, m.lng),
              builder: (context) => _buildMarker(m),
            );
          },
        ).toList(),
      ),
    );
  }

  Widget _buildMarker(Municipality m) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            '${m.title} (${m.confirmed})',
            style: AppTextStyles.extraSmallDark,
          ),
        ),
        const SizedBox(height: 2.0),
        const Icon(
          Icons.location_pin,
          size: 32.0,
          color: Colors.red,
        ),
      ],
    );
  }
}
