import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:covid19_info/core/models/country_data.dart';
import 'package:covid19_info/core/models/timeline_data.dart';

class Country {
  final List<TimelineData> timeline;
  final CountryData data;
  final String code;

  Country({
    @required this.timeline,
    @required this.data,
    @required this.code,
  })  : assert(timeline != null),
        assert(data != null),
        assert(code != null);

  Country copyWith({
    List<TimelineData> timeline,
    CountryData countryData,
    String code,
  }) {
    return Country(
      timeline: timeline ?? this.timeline,
      data: countryData ?? this.data,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timeline': List<dynamic>.from(timeline.map((x) => x.toMap())),
      'countryData': data.toMap(),
      'code': code,
    };
  }

  static Country fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Country(
      timeline: map.containsKey('timeline')
          ? List<TimelineData>.from(map['timeline']?.map((x) => TimelineData.fromMap(x)))
          : [],
      data: CountryData.fromMap(map['countryData']),
      code: map['code'],
    );
  }

  String toJson() => json.encode(toMap());

  static Country fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Country(timeline: $timeline, countryData: $data, code: $code)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Country &&
        listEquals(o.timeline, timeline) &&
        o.data == data &&
        o.code == code;
  }

  @override
  int get hashCode => timeline.hashCode ^ data.hashCode ^ code.hashCode;
}
