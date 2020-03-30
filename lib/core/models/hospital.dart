import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:covid19_info/core/models/coord.dart';
import 'package:covid19_info/core/models/capacity.dart';

class Hospital {
  final String id;
  final Coord coord;
  final bool isFull;
  final bool isGovApproved;
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
    @required this.coord,
    @required this.isFull,
    @required this.isGovApproved,
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
    Coord coord,
    bool isFull,
    bool isGovApproved,
    String name,
    String contactPerson,
    String contactPersonName,
    String address,
    String phone,
    String website,
    String email,
    Capacity capacity,
  }) {
    return Hospital(
      id: id ?? this.id,
      coord: coord ?? this.coord,
      isFull: isFull ?? this.isFull,
      isGovApproved: isGovApproved ?? this.isGovApproved,
      name: name ?? this.name,
      contactPerson: contactPerson ?? this.contactPerson,
      contactPersonNumber: contactPersonName ?? this.contactPersonNumber,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      email: email ?? this.email,
      capacity: capacity ?? this.capacity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'coord': coord.toMap(),
      'is_full': isFull,
      'government_approved': isGovApproved,
      'name': name,
      'contact_person': contactPerson,
      'contact_person_number': contactPersonNumber,
      'address': address,
      'phone': phone,
      'website': website,
      'email': email,
      'capacity': capacity.toMap(),
    };
  }

  static Hospital fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    double lat = map['location']['coordinates'][0];
    double long = map['location']['coordinates'][1];
    if (lat > long) {
      lat = map['location']['coordinates'][1];
      long = map['location']['coordinates'][0];
    }

    return Hospital(
      id: map['id'],
      coord: Coord.fromMap({
        'latitude': lat,
        'longitude': long,
      }),
      isFull: map['is_full'],
      isGovApproved: map['government_approved'],
      name: map['name'],
      contactPerson: map['contact_person'],
      contactPersonNumber: map['contact_person_number'],
      address: map['address'],
      phone: map['phone'],
      website: map['website'],
      email: map['email'],
      capacity: Capacity.fromMap(map['capacity']),
    );
  }

  String toJson() => json.encode(toMap());

  static Hospital fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Hospital(id: $id, coord: $coord, isFull: $isFull, isGovApproved: $isGovApproved, name: $name, contactPerson: $contactPerson, contactPersonName: $contactPersonNumber, address: $address, phone: $phone, website: $website, email: $email, capacity: $capacity)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Hospital &&
        o.id == id &&
        o.coord == coord &&
        o.isFull == isFull &&
        o.isGovApproved == isGovApproved &&
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
        coord.hashCode ^
        isFull.hashCode ^
        isGovApproved.hashCode ^
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
