import 'package:meta/meta.dart';

import 'package:covid19_info/core/models/capacity.dart';

class Hospital {
  final String id;
  final String name;
  final String contactPerson;
  final String contactPersonNumber;
  final String address;
  final String phone;
  final String website;
  final String email;
  final Capacity capacity;

  Hospital({
    @required this.id,
    @required this.name,
    @required this.contactPerson,
    @required this.contactPersonNumber,
    @required this.address,
    @required this.phone,
    @required this.website,
    @required this.email,
    @required this.capacity,
  });

  Hospital copyWith({
    String id,
    bool isFull,
    bool isGovApproved,
    String name,
    String contactPerson,
    String contactPersonNumber,
    String address,
    String phone,
    String website,
    String email,
    Capacity capacity,
  }) {
    return Hospital(
      id: id ?? this.id,
      name: name ?? this.name,
      contactPerson: contactPerson ?? this.contactPerson,
      contactPersonNumber: contactPersonNumber ?? this.contactPersonNumber,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      email: email ?? this.email,
      capacity: capacity ?? this.capacity,
    );
  }

  bool get isValid =>
      !capacity.isEmpty && name.isNotEmpty && phone.isNotEmpty && address.isNotEmpty;

  factory Hospital.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Hospital(
      id: map['id'] as String,
      name: map['name'] as String,
      contactPerson: map['contact_person'] as String,
      contactPersonNumber: map['contact_person_number'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
      website: map['website'] as String,
      email: map['email'] as String,
      capacity: Capacity.fromMap(map['capacity'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() {
    return 'Hospital(id: $id, name: $name, contactPerson: $contactPerson, contactPersonName: $contactPersonNumber, address: $address, phone: $phone, website: $website, email: $email, capacity: $capacity)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Hospital &&
        o.id == id &&
        o.name == name &&
        o.contactPerson == contactPerson &&
        o.contactPersonNumber == contactPersonNumber &&
        o.address == address &&
        o.phone == phone &&
        o.website == website &&
        o.email == email &&
        o.capacity == capacity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        contactPerson.hashCode ^
        contactPersonNumber.hashCode ^
        address.hashCode ^
        phone.hashCode ^
        website.hashCode ^
        email.hashCode ^
        capacity.hashCode;
  }
}
