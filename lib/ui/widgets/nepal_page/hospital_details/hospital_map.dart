import 'package:flutter/material.dart';

import 'package:covid19_info/ui/widgets/common/map_card.dart';

class HospitalMap extends StatelessWidget {
  final double lat;
  final double long;

  const HospitalMap({
    @required this.lat,
    @required this.long,
  })  : assert(lat != null),
        assert(long != null);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: MapCard(
          lat: lat,
          long: long,
        ),
      ),
    );
  }
}
