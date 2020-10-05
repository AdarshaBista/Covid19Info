import 'package:meta/meta.dart';

class Capacity {
  final String beds;
  final String ventilators;
  final String isolationBeds;
  final String occupiedBeds;
  final String doctors;
  final String nurses;

  Capacity({
    @required this.beds,
    @required this.ventilators,
    @required this.isolationBeds,
    @required this.occupiedBeds,
    @required this.doctors,
    @required this.nurses,
  });

  Capacity copyWith({
    String beds,
    String ventilators,
    String isolationBeds,
    String occupiedBeds,
    String doctors,
    String nurses,
  }) {
    return Capacity(
      beds: beds ?? this.beds,
      ventilators: ventilators ?? this.ventilators,
      isolationBeds: isolationBeds ?? this.isolationBeds,
      occupiedBeds: occupiedBeds ?? this.occupiedBeds,
      doctors: doctors ?? this.doctors,
      nurses: nurses ?? this.nurses,
    );
  }

  bool get isEmpty =>
      beds.isEmpty &&
      ventilators.isEmpty &&
      isolationBeds.isEmpty &&
      occupiedBeds.isEmpty &&
      doctors.isEmpty &&
      nurses.isEmpty;

  factory Capacity.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Capacity(
      beds: map['beds'] as String,
      ventilators: map['ventilators'] as String,
      isolationBeds: map['isolation_beds'] as String,
      occupiedBeds: map['occupied_beds'] as String,
      doctors: map['doctors'] as String,
      nurses: map['nurses'] as String,
    );
  }

  @override
  String toString() {
    return 'Capacity(beds: $beds, ventilators: $ventilators, isolationBeds: $isolationBeds, occupiedBeds: $occupiedBeds, doctors: $doctors, nurses: $nurses)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Capacity &&
        o.beds == beds &&
        o.ventilators == ventilators &&
        o.isolationBeds == isolationBeds &&
        o.occupiedBeds == occupiedBeds &&
        o.doctors == doctors &&
        o.nurses == nurses;
  }

  @override
  int get hashCode {
    return beds.hashCode ^
        ventilators.hashCode ^
        isolationBeds.hashCode ^
        occupiedBeds.hashCode ^
        doctors.hashCode ^
        nurses.hashCode;
  }
}
