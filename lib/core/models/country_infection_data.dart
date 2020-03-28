import 'dart:convert';

import 'package:meta/meta.dart';

class CountryInfectionData {
  final String id;
  final String country; // Blank name gives global count
  final int totalCases;
  final int newCases;
  final int totalDeaths;
  final int newDeaths;
  final int activeCases;
  final int totalRecovered;
  final int criticalCases;

  CountryInfectionData({
    @required this.id,
    @required this.country,
    @required this.totalCases,
    @required this.newCases,
    @required this.totalDeaths,
    @required this.newDeaths,
    @required this.activeCases,
    @required this.totalRecovered,
    @required this.criticalCases,
  });

  CountryInfectionData copyWith({
    String id,
    String country,
    int totalCases,
    int newCases,
    int totalDeaths,
    int newDeaths,
    int activeCases,
    int totalRecovered,
    int criticalCases,
  }) {
    return CountryInfectionData(
      id: id ?? this.id,
      country: country ?? this.country,
      totalCases: totalCases ?? this.totalCases,
      newCases: newCases ?? this.newCases,
      totalDeaths: totalDeaths ?? this.totalDeaths,
      newDeaths: newDeaths ?? this.newDeaths,
      activeCases: activeCases ?? this.activeCases,
      totalRecovered: totalRecovered ?? this.totalRecovered,
      criticalCases: criticalCases ?? this.criticalCases,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'country': country,
      'totalCases': totalCases,
      'newCases': newCases,
      'totalDeaths': totalDeaths,
      'newDeaths': newDeaths,
      'activeCases': activeCases,
      'totalRecovered': totalRecovered,
      'criticalCases': criticalCases,
    };
  }

  static CountryInfectionData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CountryInfectionData(
      id: map['_id'],
      country: map['country'],
      totalCases: map['totalCases'],
      newCases: map['newCases'],
      totalDeaths: map['totalDeaths'],
      newDeaths: map['newDeaths'],
      activeCases: map['activeCases'],
      totalRecovered: map['totalRecovered'],
      criticalCases: map['criticalCases'],
    );
  }

  String toJson() => json.encode(toMap());

  static CountryInfectionData fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() {
    return 'CountryInfectionData(id: $id, country: $country, totalCases: $totalCases, newCases: $newCases, totalDeaths: $totalDeaths, newDeaths: $newDeaths, activeCases: $activeCases, totalRecovered: $totalRecovered, criticalCases: $criticalCases)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CountryInfectionData &&
        o.id == id &&
        o.country == country &&
        o.totalCases == totalCases &&
        o.newCases == newCases &&
        o.totalDeaths == totalDeaths &&
        o.newDeaths == newDeaths &&
        o.activeCases == activeCases &&
        o.totalRecovered == totalRecovered &&
        o.criticalCases == criticalCases;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        country.hashCode ^
        totalCases.hashCode ^
        newCases.hashCode ^
        totalDeaths.hashCode ^
        newDeaths.hashCode ^
        activeCases.hashCode ^
        totalRecovered.hashCode ^
        criticalCases.hashCode;
  }
}
