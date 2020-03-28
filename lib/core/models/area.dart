import 'dart:convert';

import 'package:flutter/foundation.dart';

class Area {
  final String id;
  final String displayName;
  final List<Area> areas;
  final int totalConfirmed;
  final int totalDeaths;
  final int totalRecovered;
  final DateTime lastUpdated;
  final double lat;
  final double long;
  final String parentId;

  Area({
    @required this.id,
    @required this.displayName,
    @required this.areas,
    @required this.totalConfirmed,
    @required this.totalDeaths,
    @required this.totalRecovered,
    @required this.lastUpdated,
    @required this.lat,
    @required this.long,
    @required this.parentId,
  });

  Area copyWith({
    String id,
    String displayName,
    List<Area> areas,
    int totalConfirmed,
    int totalDeaths,
    int totalRecovered,
    DateTime lastUpdated,
    double lat,
    double lng,
    String parentId,
  }) {
    return Area(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      areas: areas ?? this.areas,
      totalConfirmed: totalConfirmed ?? this.totalConfirmed,
      totalDeaths: totalDeaths ?? this.totalDeaths,
      totalRecovered: totalRecovered ?? this.totalRecovered,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      lat: lat ?? this.lat,
      long: lng ?? this.long,
      parentId: parentId ?? this.parentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'displayName': displayName,
      'areas': List<dynamic>.from(areas.map((x) => x.toMap())),
      'totalConfirmed': totalConfirmed,
      'totalDeaths': totalDeaths,
      'totalRecovered': totalRecovered,
      'lastUpdated': lastUpdated.toUtc(),
      'lat': lat,
      'long': long,
      'parentId': parentId,
    };
  }

  static Area fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Area(
      id: map['id'],
      displayName: map['displayName'],
      areas: List<Area>.from(map['areas']?.map((x) => Area.fromMap(x))),
      totalConfirmed: map['totalConfirmed'],
      totalDeaths: map['totalDeaths'],
      totalRecovered: map['totalRecovered'],
      lastUpdated: DateTime.parse(map['lastUpdated']) ?? null,
      lat: map['lat'] ?? null,
      long: map['long'] ?? null,
      parentId: map['parentId'],
    );
  }

  String toJson() => json.encode(toMap());

  static Area fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Area(id: $id, displayName: $displayName, areas: $areas, totalConfirmed: $totalConfirmed, totalDeaths: $totalDeaths, totalRecovered: $totalRecovered, lastUpdated: $lastUpdated, lat: $lat, lng: $long, parentId: $parentId)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Area &&
        o.id == id &&
        o.displayName == displayName &&
        listEquals(o.areas, areas) &&
        o.totalConfirmed == totalConfirmed &&
        o.totalDeaths == totalDeaths &&
        o.totalRecovered == totalRecovered &&
        o.lastUpdated == lastUpdated &&
        o.lat == lat &&
        o.long == long &&
        o.parentId == parentId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        displayName.hashCode ^
        areas.hashCode ^
        totalConfirmed.hashCode ^
        totalDeaths.hashCode ^
        totalRecovered.hashCode ^
        lastUpdated.hashCode ^
        lat.hashCode ^
        long.hashCode ^
        parentId.hashCode;
  }
}
