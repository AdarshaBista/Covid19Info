import 'dart:convert';

import 'package:meta/meta.dart';

class InfectedNepali {
  final String id;
  final String date;
  final String country;
  final int totalCases;
  final int deaths;
  final String source;
  final String sourceUrl;

  InfectedNepali({
    @required this.id,
    @required this.date,
    @required this.country,
    @required this.totalCases,
    @required this.deaths,
    @required this.source,
    @required this.sourceUrl,
  });

  InfectedNepali copyWith({
    String id,
    String date,
    String country,
    int totalCases,
    int deaths,
    String source,
    String sourceUrl,
  }) {
    return InfectedNepali(
      id: id ?? this.id,
      date: date ?? this.date,
      country: country ?? this.country,
      totalCases: totalCases ?? this.totalCases,
      deaths: deaths ?? this.deaths,
      source: source ?? this.source,
      sourceUrl: sourceUrl ?? this.sourceUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'date': date,
      'country': country,
      'totalCases': totalCases,
      'deaths': deaths,
      'source': source,
      'source_url': sourceUrl,
    };
  }

  static InfectedNepali fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return InfectedNepali(
      id: map['_id'],
      date: map['date'],
      country: map['country'],
      totalCases: map['totalCases'],
      deaths: map['deaths'],
      source: map['source'],
      sourceUrl: map['source_url'],
    );
  }

  String toJson() => json.encode(toMap());

  static InfectedNepali fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'InfectedNepali(id: $id, date: $date, country: $country, totalCases: $totalCases, deaths: $deaths, source: $source, sourceUrl: $sourceUrl)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is InfectedNepali &&
        o.id == id &&
        o.date == date &&
        o.country == country &&
        o.totalCases == totalCases &&
        o.deaths == deaths &&
        o.source == source &&
        o.sourceUrl == sourceUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        country.hashCode ^
        totalCases.hashCode ^
        deaths.hashCode ^
        source.hashCode ^
        sourceUrl.hashCode;
  }
}
