import 'dart:convert';

import 'package:meta/meta.dart';

class NepalInfectionData {
  final String total;
  final String positive;
  final String negative;

  NepalInfectionData({
    @required this.total,
    @required this.positive,
    @required this.negative,
  })  : assert(total != null),
        assert(positive != null),
        assert(negative != null);

  NepalInfectionData copyWith({
    String total,
    String positive,
    String negative,
  }) {
    return NepalInfectionData(
      total: total ?? this.total,
      positive: positive ?? this.positive,
      negative: negative ?? this.negative,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tested_total': total,
      'tested_positive': positive,
      'tested_negative': negative,
    };
  }

  static NepalInfectionData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return NepalInfectionData(
      total: map['tested_total'],
      positive: map['tested_positive'],
      negative: map['tested_negative'],
    );
  }

  String toJson() => json.encode(toMap());

  static NepalInfectionData fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() =>
      'NepalInfectionData(total: $total, positive: $positive, negative: $negative)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NepalInfectionData &&
        o.total == total &&
        o.positive == positive &&
        o.negative == negative;
  }

  @override
  int get hashCode => total.hashCode ^ positive.hashCode ^ negative.hashCode;
}
