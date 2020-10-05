import 'package:meta/meta.dart';

class Myth {
  final String id;
  final String myth;
  final String reality;
  final String sourceName;
  final String sourceUrl;

  Myth({
    @required this.id,
    @required this.myth,
    @required this.reality,
    @required this.sourceName,
    @required this.sourceUrl,
  });

  Myth copyWith({
    String id,
    String myth,
    String reality,
    String sourceName,
    String sourceUrl,
  }) {
    return Myth(
      id: id ?? this.id,
      myth: myth ?? this.myth,
      reality: reality ?? this.reality,
      sourceName: sourceName ?? this.sourceName,
      sourceUrl: sourceUrl ?? this.sourceUrl,
    );
  }

  factory Myth.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Myth(
      id: map['_id'] as String,
      myth: map['myth'] as String,
      reality: map['reality'] as String,
      sourceName: map['source_name'] as String,
      sourceUrl: map['source_url'] as String,
    );
  }

  @override
  String toString() {
    return 'Myth(id: $id, myth: $myth, reality: $reality, sourceName: $sourceName, sourceUrl: $sourceUrl)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Myth &&
        o.id == id &&
        o.myth == myth &&
        o.reality == reality &&
        o.sourceName == sourceName &&
        o.sourceUrl == sourceUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        myth.hashCode ^
        reality.hashCode ^
        sourceName.hashCode ^
        sourceUrl.hashCode;
  }
}
