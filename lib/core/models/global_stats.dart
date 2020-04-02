import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import 'package:covid19_info/core/models/timeline_data.dart';

class GlobalStats {
  final int confirmed;
  final int deaths;
  final int recovered;
  final List<TimelineData> timeline;

  GlobalStats({
    @required this.confirmed,
    @required this.deaths,
    @required this.recovered,
    @required this.timeline,
  })  : assert(confirmed != null),
        assert(deaths != null),
        assert(recovered != null),
        assert(timeline != null);

  GlobalStats copyWith({
    int confirmed,
    int deaths,
    int recovered,
    List<TimelineData> timeline,
  }) {
    return GlobalStats(
      confirmed: confirmed ?? this.confirmed,
      deaths: deaths ?? this.deaths,
      recovered: recovered ?? this.recovered,
      timeline: timeline ?? this.timeline,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'confirmed': confirmed,
      'deaths': deaths,
      'recovered': recovered,
      'timeline': List<dynamic>.from(timeline.map((x) => x.toMap())),
    };
  }

  static GlobalStats fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return GlobalStats(
      confirmed: map['confirmed'],
      deaths: map['deaths'],
      recovered: map['recovered'],
      timeline: List<TimelineData>.from(
          map['timeline']?.map((x) => TimelineData.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static GlobalStats fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'GlobalCount(confirmed: $confirmed, deaths: $deaths, recovered: $recovered, timeline: $timeline)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is GlobalStats &&
        o.confirmed == confirmed &&
        o.deaths == deaths &&
        o.recovered == recovered &&
        listEquals(o.timeline, timeline);
  }

  @override
  int get hashCode {
    return confirmed.hashCode ^
        deaths.hashCode ^
        recovered.hashCode ^
        timeline.hashCode;
  }
}
