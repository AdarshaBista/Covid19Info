import 'dart:convert';

import 'package:meta/meta.dart';

class DistrictCase {
  final int id;

  const DistrictCase({
    @required this.id,
  }) : assert(id != null);

  DistrictCase copyWith({
    int id,
  }) {
    return DistrictCase(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  static DistrictCase fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DistrictCase(
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  static DistrictCase fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'DistrictCase(id: $id)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DistrictCase && o.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
