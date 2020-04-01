import 'dart:convert';

import 'package:meta/meta.dart';

class NepalInfectionData {
  final int total;
  final int positive;
  final int negative;
  final int isolation;
  final int deaths;

  NepalInfectionData({
    @required this.total,
    @required this.positive,
    @required this.negative,
    @required this.isolation,
    @required this.deaths,
  })  : assert(total != null),
        assert(positive != null),
        assert(negative != null),
        assert(isolation != null),
        assert(deaths != null);

  NepalInfectionData copyWith({
    int total,
    int positive,
    int negative,
    int isolation,
    int deaths,
  }) {
    return NepalInfectionData(
      total: total ?? this.total,
      positive: positive ?? this.positive,
      negative: negative ?? this.negative,
      isolation: isolation ?? this.isolation,
      deaths: deaths ?? this.deaths,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tested_total': total,
      'tested_positive': positive,
      'tested_negative': negative,
      'in_isolation': isolation,
      'deaths': deaths,
    };
  }

  static NepalInfectionData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return NepalInfectionData(
      total: map['tested_total'],
      positive: map['tested_positive'],
      negative: map['tested_negative'],
      isolation: map['in_isolation'],
      deaths: map['deaths'],
    );
  }

  String toJson() => json.encode(toMap());

  static NepalInfectionData fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() =>
      'NepalInfectionData(total: $total, positive: $positive, negative: $negative, isolation: $isolation, deaths: $deaths)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NepalInfectionData &&
        o.total == total &&
        o.positive == positive &&
        o.negative == negative &&
        o.isolation == isolation &&
        o.deaths == deaths;
  }

  @override
  int get hashCode =>
      total.hashCode ^
      positive.hashCode ^
      negative.hashCode ^
      isolation.hashCode ^
      deaths.hashCode;
}
