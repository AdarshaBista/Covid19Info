import 'dart:convert';

import 'package:meta/meta.dart';

class Coord {
  final double latitude;
  final double longitude;

  Coord({
    @required this.latitude,
    @required this.longitude,
  });

  Coord copyWith({
    double latitude,
    double longitude,
  }) {
    return Coord(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  static Coord fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Coord(
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  String toJson() => json.encode(toMap());

  static Coord fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Coord(latitude: $latitude, longitude: $longitude)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Coord && o.latitude == latitude && o.longitude == longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}
