import 'package:flutter/foundation.dart';

import 'package:covid19_info/core/models/covid_case.dart';

class Municipality {
  final int id;
  final String title;
  final double lat;
  final double lng;
  final List<CovidCase> cases;

  int get confirmed => cases.length;

  const Municipality({
    @required this.id,
    @required this.title,
    @required this.lat,
    @required this.lng,
    @required this.cases,
  })  : assert(id != null),
        assert(title != null),
        assert(lat != null),
        assert(lng != null),
        assert(cases != null);

  factory Municipality.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Municipality(
      id: map['id'] as int,
      title: map['title'] as String,
      lat: (map['centroid']['coordinates'][1] as num).toDouble(),
      lng: (map['centroid']['coordinates'][0] as num).toDouble(),
      cases: List<CovidCase>.from((map['covid_cases'] as List)
          ?.map((x) => CovidCase.fromMap(x as Map<String, dynamic>))),
    );
  }

  @override
  String toString() {
    return 'Municipality(id: $id, title: $title, lat: $lat, lng: $lng, cases: $cases)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Municipality &&
        o.id == id &&
        o.title == title &&
        o.lat == lat &&
        o.lng == lng &&
        listEquals(o.cases, cases);
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ lat.hashCode ^ lng.hashCode ^ cases.hashCode;
  }
}
