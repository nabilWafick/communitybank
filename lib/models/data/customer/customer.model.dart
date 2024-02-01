import 'dart:convert';
import 'package:communitybank/models/tables/customer/customer_table.model.dart';
import 'package:flutter/widgets.dart';

// use class nullable or not required classes in model
// for facilitating update of data requiring dropdown

class Customer {
  final int? id;
  final String name;
  final String firstnames;
  final String phoneNumber;
  final String address;
  final String? profession;
  final int? nicNumber;
  int? categoryId;
  int? economicalActivityId;
  int? personalStatusId;
  int? localityId;
  final String? profile;
  final String? signature;
  final DateTime createdAt;
  final DateTime updatedAt;
  Customer({
    this.id,
    required this.name,
    required this.firstnames,
    required this.phoneNumber,
    required this.address,
    this.profession,
    this.nicNumber,
    this.categoryId,
    this.economicalActivityId,
    this.personalStatusId,
    this.localityId,
    this.profile,
    this.signature,
    required this.createdAt,
    required this.updatedAt,
  });

  Customer copyWith({
    ValueGetter<int?>? id,
    String? name,
    String? firstnames,
    String? phoneNumber,
    String? address,
    String? profession,
    int? nicNumber,
    int? categoryId,
    int? economicalActivityId,
    int? personalStatusId,
    int? localityId,
    ValueGetter<String?>? profile,
    ValueGetter<String?>? signature,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Customer(
      id: id?.call() ?? this.id,
      name: name ?? this.name,
      firstnames: firstnames ?? this.firstnames,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      profession: profession ?? this.profession,
      nicNumber: nicNumber ?? this.nicNumber,
      categoryId: categoryId ?? this.categoryId,
      economicalActivityId: economicalActivityId ?? this.economicalActivityId,
      personalStatusId: personalStatusId ?? this.personalStatusId,
      localityId: localityId ?? this.localityId,
      profile: profile?.call() ?? this.profile,
      signature: signature?.call() ?? this.signature,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      //  CustomerTable.id: id,
      CustomerTable.name: name,
      CustomerTable.firstnames: firstnames,
      CustomerTable.phoneNumber: phoneNumber,
      CustomerTable.address: address,
      CustomerTable.profession: profession,
      CustomerTable.nciNumber: nicNumber == 0 ? null : nicNumber,
      CustomerTable.categoryId: categoryId,
      CustomerTable.economicalActivityId: economicalActivityId,
      CustomerTable.personalStatusId: personalStatusId,
      CustomerTable.localityId: localityId,
      CustomerTable.profile: profile,
      CustomerTable.signature: signature,
      CustomerTable.createdAt: createdAt.toIso8601String(),
      CustomerTable.updatedAt: updatedAt.toIso8601String(),
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map[CustomerTable.id]?.toInt(),
      name: map[CustomerTable.name] ?? '',
      firstnames: map[CustomerTable.firstnames] ?? '',
      phoneNumber: map[CustomerTable.phoneNumber] ?? '',
      address: map[CustomerTable.address] ?? '',
      profession: map[CustomerTable.profession] ?? '',
      nicNumber: map[CustomerTable.nciNumber]?.toInt(),
      categoryId: map[CustomerTable.categoryId],
      economicalActivityId: map[CustomerTable.economicalActivityId],
      personalStatusId: map[CustomerTable.personalStatusId],
      localityId: map[CustomerTable.localityId],
      profile: map[CustomerTable.profile],
      signature: map[CustomerTable.signature],
      createdAt: DateTime.parse(map[CustomerTable.createdAt]),
      updatedAt: DateTime.parse(map[CustomerTable.updatedAt]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Customer(id: $id, name: $name, firstnames: $firstnames, phoneNumber: $phoneNumber, address: $address, profession: $profession, nicNumber: $nicNumber, category: $categoryId, economicalActivityId: $economicalActivityId, personalStatus: $personalStatusId, loIdcality: $localityId, profile: $profile, signature: $signature,Id createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Customer &&
        other.id == id &&
        other.name == name &&
        other.firstnames == firstnames &&
        other.phoneNumber == phoneNumber &&
        other.address == address &&
        other.profession == profession &&
        other.nicNumber == nicNumber &&
        other.categoryId == categoryId &&
        other.economicalActivityId == economicalActivityId &&
        other.personalStatusId == personalStatusId &&
        other.localityId == localityId &&
        other.profile == profile &&
        other.signature == signature &&
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
        profession.hashCode ^
        nicNumber.hashCode ^
        categoryId.hashCode ^
        economicalActivityId.hashCode ^
        personalStatusId.hashCode ^
        localityId.hashCode ^
        profile.hashCode ^
        signature.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
