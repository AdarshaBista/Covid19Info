import 'package:flutter/material.dart';

import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:covid19_info/api_keys.dart';

import 'package:covid19_info/ui/styles/styles.dart';

class MapCard extends StatefulWidget {
  final bool interactive;
  final LatLng center;
  final double zoom;
  final double minZoom;
  final double maxZoom;
  final LatLng nePanBoundary;
  final LatLng swPanBoundary;
  final MarkerLayerWidget markerLayer;
  final LatLng Function() searchLocation;

  const MapCard({
    this.interactive = true,
    this.center,
    this.nePanBoundary,
    this.swPanBoundary,
    this.markerLayer,
    @required this.zoom,
    @required this.minZoom,
    @required this.maxZoom,
    @required this.searchLocation,
  })  : assert(zoom != null),
        assert(minZoom != null),
        assert(maxZoom != null),
        assert(searchLocation != null);

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
    _animateMapTo(widget.searchLocation());

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        interactive: widget.interactive,
        center: widget.center,
        zoom: widget.zoom,
        minZoom: widget.minZoom,
        maxZoom: widget.maxZoom,
        nePanBoundary: widget.nePanBoundary,
        swPanBoundary: widget.swPanBoundary,
      ),
      children: [
        _buildTiles(),
        if (widget.markerLayer != null) widget.markerLayer,
      ],
    );
  }

  TileLayerWidget _buildTiles() {
    return TileLayerWidget(
      options: TileLayerOptions(
        keepBuffer: 8,
        tileSize: 512,
        zoomOffset: -1,
        backgroundColor: AppColors.background.withOpacity(0.5),
        urlTemplate:
            "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}@2x?access_token={accessToken}",
        additionalOptions: {
          'accessToken': MAPBOX_ACCESS_TOKEN,
          'id': 'mapbox/dark-v10',
        },
      ),
    );
  }

  void _animateMapTo(LatLng destLocation) {
    if (destLocation == null) return;

    final destZoom = widget.maxZoom - 2.0;
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

    final AnimationController animController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    final Animation<double> animation = CurvedAnimation(
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
}
