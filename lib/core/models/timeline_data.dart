import 'dart:convert';

import 'package:meta/meta.dart';

class TimelineData {
  final int cases;
  final int deaths;
  final int recovered;
  final String date;

  TimelineData({
    @required this.cases,
    @required this.deaths,
    @required this.recovered,
    @required this.date,
  })  : assert(cases != null),
        assert(deaths != null),
        assert(recovered != null),
        assert(date != null);

  TimelineData copyWith({
    int cases,
    int deaths,
    int recovered,
    String date,
  }) {
    return TimelineData(
      cases: cases ?? this.cases,
      deaths: deaths ?? this.deaths,
      recovered: recovered ?? this.recovered,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cases': cases,
      'deaths': deaths,
      'recovered': recovered,
      'date': date,
    };
  }

  static TimelineData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TimelineData(
      cases: map['cases'],
      deaths: map['deaths'],
      recovered: map['recovered'],
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  static TimelineData fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'CountData(cases: $cases, deaths: $deaths, recovered: $recovered, date: $date)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TimelineData &&
        o.cases == cases &&
        o.deaths == deaths &&
        o.recovered == recovered &&
        o.date == date;
  }

  @override
  int get hashCode {
    return cases.hashCode ^
        deaths.hashCode ^
        recovered.hashCode ^
        date.hashCode;
  }
}
