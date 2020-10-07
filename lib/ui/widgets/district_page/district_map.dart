import 'package:flutter/material.dart';

import 'package:latlong/latlong.dart';
import 'package:covid19_info/core/models/district.dart';
import 'package:covid19_info/core/models/covid_case.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:covid19_info/ui/widgets/common/map_card.dart';

import 'package:covid19_info/ui/pages/covid_case_page.dart';

class DistrictMap extends StatelessWidget {
  final District district;

  const DistrictMap({
    @required this.district,
  }) : assert(district != null);

  @override
  Widget build(BuildContext context) {
    return MapCard(
      center: LatLng(district.lat, district.lng),
      zoom: 12.0,
      minZoom: 10.0,
      maxZoom: 15.0,
      nePanBoundary: LatLng(district.lat + 0.5, district.lng + 0.5),
      swPanBoundary: LatLng(district.lat - 0.5, district.lng - 0.5),
      markerLayer: _buildMarkers(context),
      searchLocation: () => null,
    );
  }

  MarkerLayerWidget _buildMarkers(BuildContext context) {
    return MarkerLayerWidget(
      options: MarkerLayerOptions(
        markers: district.cases.take(50).map(
          (c) {
            return Marker(
              height: 32.0,
              width: 32.0,
              point: LatLng(c.lat, c.lng),
              builder: (context) => GestureDetector(
                onTap: () => _navigateToDetailPage(context, c),
                child: Icon(
                  Icons.location_pin,
                  size: 20.0,
                  color: _getColor(c),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  Color _getColor(CovidCase covidCase) {
    if (covidCase.deathOn != null) return Colors.red;
    if (covidCase.recoveredOn != null) return Colors.green;
    return Colors.lightBlue;
  }

  void _navigateToDetailPage(BuildContext context, CovidCase covidCase) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CovidCasePage(covidCase: covidCase),
      ),
    );
  }
}
