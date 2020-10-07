import 'package:flutter/foundation.dart';

class District {
  final int id;
  final String title;
  final int province;
  final double lat;
  final double lng;
  final int confirmed;
  final int active;
  final int deaths;
  final int recovered;
  final int naCount;
  final int maleCount;
  final int femaleCount;

  District({
    @required this.id,
    @required this.title,
    @required this.province,
    @required this.lat,
    @required this.lng,
    @required this.confirmed,
    @required this.active,
    @required this.deaths,
    @required this.recovered,
    @required this.naCount,
    @required this.maleCount,
    @required this.femaleCount,
  })  : assert(id != null),
        assert(title != null),
        assert(province != null),
        assert(lat != null),
        assert(lng != null),
        assert(confirmed != null),
        assert(active != null),
        assert(deaths != null),
        assert(recovered != null),
        assert(naCount != null),
        assert(maleCount != null),
        assert(femaleCount != null);

  factory District.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    final cases = map['covid_cases'] as List;
    return District(
      id: map['id'] as int,
      title: map['title'] as String,
      province: map['province'] as int,
      lat: (map['centroid']['coordinates'][1] as num).toDouble(),
      lng: (map['centroid']['coordinates'][0] as num).toDouble(),
      confirmed: map['covid_summary']['cases'] as int,
      active: map['covid_summary']['active'] as int,
      deaths: map['covid_summary']['death'] as int,
      recovered: map['covid_summary']['recovered'] as int,
      naCount: cases.where((c) => c['gender'] == null).length,
      maleCount: cases.where((c) => c['gender'] == 'male').length,
      femaleCount: cases.where((c) => c['gender'] == 'female').length,
    );
  }

  @override
  String toString() {
    return 'District(id: $id, title: $title, province: $province, lat: $lat, lng: $lng, confirmed: $confirmed, active: $active, deaths: $deaths, recovered: $recovered, naCount: $naCount, maleCount: $maleCount, femaleCount: $femaleCount)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is District &&
        o.id == id &&
        o.title == title &&
        o.province == province &&
        o.lat == lat &&
        o.lng == lng &&
        o.confirmed == confirmed &&
        o.active == active &&
        o.deaths == deaths &&
        o.recovered == recovered &&
        o.naCount == naCount &&
        o.maleCount == maleCount &&
        o.femaleCount == femaleCount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        province.hashCode ^
        lat.hashCode ^
        lng.hashCode ^
        confirmed.hashCode ^
        active.hashCode ^
        deaths.hashCode ^
        recovered.hashCode ^
        naCount.hashCode ^
        maleCount.hashCode ^
        femaleCount.hashCode;
  }
}
