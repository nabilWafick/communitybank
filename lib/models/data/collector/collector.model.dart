import 'dart:convert';

import 'package:flutter/widgets.dart';

class Collector {
  final int? id;
  final String name;
  final String firstnames;
  final String phoneNumber;
  final String address;
  final String? profile;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  Collector({
    this.id,
    required this.name,
    required this.firstnames,
    required this.phoneNumber,
    required this.address,
    this.profile,
    this.createdAt,
    this.updatedAt,
  });

  Collector copyWith({
    ValueGetter<int?>? id,
    String? name,
    String? firstnames,
    String? phoneNumber,
    String? address,
    ValueGetter<String?>? profile,
    ValueGetter<DateTime?>? createdAt,
    ValueGetter<DateTime?>? updatedAt,
  }) {
    return Collector(
      id: id?.call() ?? this.id,
      name: name ?? this.name,
      firstnames: firstnames ?? this.firstnames,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      profile: profile?.call() ?? this.profile,
      createdAt: createdAt?.call() ?? this.createdAt,
      updatedAt: updatedAt?.call() ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'firstnames': firstnames,
      'phoneNumber': phoneNumber,
      'address': address,
      'profile': profile,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory Collector.fromMap(Map<String, dynamic> map) {
    return Collector(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      firstnames: map['firstnames'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
      profile: map['profile'],
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Collector.fromJson(String source) =>
      Collector.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Collector(id: $id, name: $name, firstnames: $firstnames, phoneNumber: $phoneNumber, address: $address, profile: $profile, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Collector &&
        other.id == id &&
        other.name == name &&
        other.firstnames == firstnames &&
        other.phoneNumber == phoneNumber &&
        other.address == address &&
        other.profile == profile &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        firstnames.hashCode ^
        phoneNumber.hashCode ^
        address.hashCode ^
        profile.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
