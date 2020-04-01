import 'dart:convert';

import 'package:flutter/material.dart';

class Country {
  final String id;
  final String name;
  final int totalCases;
  final int newCases;
  final int totalDeaths;
  final int newDeaths;
  final int activeCases;
  final int totalRecovered;
  final int criticalCases;

  Country({
    @required this.id,
    @required this.name,
    @required this.totalCases,
    @required this.newCases,
    @required this.totalDeaths,
    @required this.newDeaths,
    @required this.activeCases,
    @required this.totalRecovered,
    @required this.criticalCases,
  })  : assert(id != null),
        assert(name != null),
        assert(totalCases != null),
        assert(newCases != null),
        assert(totalDeaths != null),
        assert(newDeaths != null),
        assert(activeCases != null),
        assert(totalRecovered != null),
        assert(criticalCases != null);

  Country copyWith({
    String id,
    String name,
    int totalCases,
    int newCases,
    int totalDeaths,
    int newDeaths,
    int activeCases,
    int totalRecovered,
    int criticalCases,
  }) {
    return Country(
      id: id ?? this.id,
      name: name ?? this.name,
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
      'name': name,
      'totalCases': totalCases,
      'newCases': newCases,
      'totalDeaths': totalDeaths,
      'newDeaths': newDeaths,
      'activeCases': activeCases,
      'totalRecovered': totalRecovered,
      'criticalCases': criticalCases,
    };
  }

  static Country fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Country(
      id: map['_id'],
      name: map['name'],
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

  static Country fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Country(id: $id, name: $name, totalCases: $totalCases, newCases: $newCases, totalDeaths: $totalDeaths, newDeaths: $newDeaths, activeCases: $activeCases, totalRecovered: $totalRecovered, criticalCases: $criticalCases)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Country &&
        o.id == id &&
        o.name == name &&
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
        name.hashCode ^
        totalCases.hashCode ^
        newCases.hashCode ^
        totalDeaths.hashCode ^
        newDeaths.hashCode ^
        activeCases.hashCode ^
        totalRecovered.hashCode ^
        criticalCases.hashCode;
  }
}
