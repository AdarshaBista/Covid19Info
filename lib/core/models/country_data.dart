import 'dart:convert';

import 'package:meta/meta.dart';

class CountryData {
  final String name;
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int active;
  final int critical;
  final double casesPerMillion;
  final double deathsPerMillion;

  CountryData({
    @required this.name,
    @required this.cases,
    @required this.todayCases,
    @required this.deaths,
    @required this.todayDeaths,
    @required this.recovered,
    @required this.active,
    @required this.critical,
    @required this.casesPerMillion,
    @required this.deathsPerMillion,
  })  : assert(name != null),
        assert(cases != null),
        assert(todayCases != null),
        assert(deaths != null),
        assert(todayDeaths != null),
        assert(recovered != null),
        assert(active != null),
        assert(critical != null),
        assert(casesPerMillion != null),
        assert(deathsPerMillion != null);

  CountryData copyWith({
    String name,
    int cases,
    int todayCases,
    int deaths,
    int todayDeaths,
    int recovered,
    int active,
    int critical,
    double casesPerMillion,
    double deathsPerMillion,
  }) {
    return CountryData(
      name: name ?? this.name,
      cases: cases ?? this.cases,
      todayCases: todayCases ?? this.todayCases,
      deaths: deaths ?? this.deaths,
      todayDeaths: todayDeaths ?? this.todayDeaths,
      recovered: recovered ?? this.recovered,
      active: active ?? this.active,
      critical: critical ?? this.critical,
      casesPerMillion: casesPerMillion ?? this.casesPerMillion,
      deathsPerMillion: deathsPerMillion ?? this.deathsPerMillion,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'country': name,
      'cases': cases,
      'todayCases': todayCases,
      'deaths': deaths,
      'todayDeaths': todayDeaths,
      'recovered': recovered,
      'active': active,
      'critical': critical,
      'casesPerOneMillion': casesPerMillion,
      'deathsPerOneMillion': deathsPerMillion,
    };
  }

  static CountryData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CountryData(
      name: map['country'],
      cases: map['cases'],
      todayCases: map['todayCases'],
      deaths: map['deaths'],
      todayDeaths: map['todayDeaths'],
      recovered: map['recovered'],
      active: map['active'],
      critical: map['critical'],
      casesPerMillion: (map['casesPerOneMillion'] as num).toDouble(),
      deathsPerMillion: (map['deathsPerOneMillion'] as num).toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  static CountryData fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Country(name: $name, cases: $cases, todayCases: $todayCases, deaths: $deaths, todayDeaths: $todayDeaths, recovered: $recovered, active: $active, critical: $critical, casesPerMillion: $casesPerMillion, deathsPerMillion: $deathsPerMillion)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CountryData &&
        o.name == name &&
        o.cases == cases &&
        o.todayCases == todayCases &&
        o.deaths == deaths &&
        o.todayDeaths == todayDeaths &&
        o.recovered == recovered &&
        o.active == active &&
        o.critical == critical &&
        o.casesPerMillion == casesPerMillion &&
        o.deathsPerMillion == deathsPerMillion;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        cases.hashCode ^
        todayCases.hashCode ^
        deaths.hashCode ^
        todayDeaths.hashCode ^
        recovered.hashCode ^
        active.hashCode ^
        critical.hashCode ^
        casesPerMillion.hashCode ^
        deathsPerMillion.hashCode;
  }
}
