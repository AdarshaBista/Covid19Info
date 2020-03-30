import 'package:flutter/material.dart';

import 'package:covid19_info/api_keys.dart';

import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:line_awesome_icons/line_awesome_icons.dart';

class MapCard extends StatefulWidget {
  final double lat;
  final double long;

  const MapCard({
    this.lat = 28.3949,
    this.long = 84.1240,
  })  : assert(lat != null),
        assert(long != null);

  @override
  MapCardState createState() {
    return MapCardState();
  }
}

class MapCardState extends State<MapCard> with TickerProviderStateMixin {
  MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  void _animateMapTo(LatLng destLocation) {
    final destZoom = 15.0;
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
          LatLng(
            _latTween.evaluate(animation),
            _lngTween.evaluate(animation),
          ),
          _zoomTween.evaluate(animation));
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

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        zoom: 16.0,
        center: LatLng(widget.lat, widget.long),
      ),
      layers: [
        TileLayerOptions(
          keepBuffer: 8,
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
          additionalOptions: {
            'accessToken': MAPBOX_ACCESS_TOKEN,
            'id': 'mapbox.dark',
          },
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 64.0,
              height: 64.0,
              point: LatLng(widget.lat, widget.long),
              builder: (BuildContext context) => Icon(
                LineAwesomeIcons.map_marker,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
