import 'package:flutter/foundation.dart';

import 'package:covid19_info/core/models/covid_case.dart';

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
  final List<CovidCase> cases;

  int naCount;
  int maleCount;
  int femaleCount;

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
    @required this.cases,
  })  : assert(id != null),
        assert(title != null),
        assert(province != null),
        assert(lat != null),
        assert(lng != null),
        assert(confirmed != null),
        assert(active != null),
        assert(deaths != null),
        assert(recovered != null),
        assert(cases != null) {
    naCount = cases.where((c) => c.gender.isEmpty).length;
    maleCount = cases.where((c) => c.gender == 'male').length;
    femaleCount = cases.where((c) => c.gender == 'female').length;
  }

  District copyWith({
    int id,
    String title,
    int province,
    double lat,
    double lng,
    int confirmed,
    int active,
    int deaths,
    int recovered,
    List<CovidCase> cases,
  }) {
    return District(
      id: id ?? this.id,
      title: title ?? this.title,
      province: province ?? this.province,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      confirmed: confirmed ?? this.confirmed,
      active: active ?? this.active,
      deaths: deaths ?? this.deaths,
      recovered: recovered ?? this.recovered,
      cases: cases ?? this.cases,
    );
  }

  factory District.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

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
      cases: List<CovidCase>.from((map['covid_cases'] as List)
          ?.map((x) => CovidCase.fromMap(x as Map<String, dynamic>))),
    );
  }

  @override
  String toString() {
    return 'District(id: $id, title: $title, province: $province, lat: $lat, lng: $lng, confirmed: $confirmed, active: $active, deaths: $deaths, recovered: $recovered, cases: $cases)';
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
        listEquals(o.cases, cases);
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
        cases.hashCode;
  }
}
