import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:communitybank/models/data/customers_category/customers_category.model.dart';
import 'package:communitybank/models/data/economical_activity/economical_activity.model.dart';
import 'package:communitybank/models/data/locality/locality.model.dart';
import 'package:communitybank/models/data/personal_status/personal_status.model.dart';

class Customer {
  final int? id;
  final String name;
  final String firstnames;
  final String phoneNumber;
  final String address;
  final String profession;
  final int nicNumber;
  final CustomerCategory category;
  final EconomicalActivity economicalActivity;
  final PersonalStatus personalStatus;
  final Locality locality;
  final String? profile;
  final String? signature;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  Customer({
    this.id,
    required this.name,
    required this.firstnames,
    required this.phoneNumber,
    required this.address,
    required this.profession,
    required this.nicNumber,
    required this.category,
    required this.economicalActivity,
    required this.personalStatus,
    required this.locality,
    this.profile,
    this.signature,
    this.createdAt,
    this.updatedAt,
  });

  Customer copyWith({
    ValueGetter<int?>? id,
    String? name,
    String? firstnames,
    String? phoneNumber,
    String? address,
    String? profession,
    int? nicNumber,
    CustomerCategory? category,
    EconomicalActivity? economicalActivity,
    PersonalStatus? personalStatus,
    Locality? locality,
    ValueGetter<String?>? profile,
    ValueGetter<String?>? signature,
    ValueGetter<DateTime?>? createdAt,
    ValueGetter<DateTime?>? updatedAt,
  }) {
    return Customer(
      id: id?.call() ?? this.id,
      name: name ?? this.name,
      firstnames: firstnames ?? this.firstnames,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      profession: profession ?? this.profession,
      nicNumber: nicNumber ?? this.nicNumber,
      category: category ?? this.category,
      economicalActivity: economicalActivity ?? this.economicalActivity,
      personalStatus: personalStatus ?? this.personalStatus,
      locality: locality ?? this.locality,
      profile: profile?.call() ?? this.profile,
      signature: signature?.call() ?? this.signature,
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
      'profession': profession,
      'nicNumber': nicNumber,
      'category': category.toMap(),
      'economicalActivity': economicalActivity.toMap(),
      'personalStatus': personalStatus.toMap(),
      'locality': locality.toMap(),
      'profile': profile,
      'signature': signature,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      firstnames: map['firstnames'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
      profession: map['profession'] ?? '',
      nicNumber: map['nicNumber']?.toInt() ?? 0,
      category: CustomerCategory.fromMap(map['category']),
      economicalActivity: EconomicalActivity.fromMap(map['economicalActivity']),
      personalStatus: PersonalStatus.fromMap(map['personalStatus']),
      locality: Locality.fromMap(map['locality']),
      profile: map['profile'],
      signature: map['signature'],
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Customer(id: $id, name: $name, firstnames: $firstnames, phoneNumber: $phoneNumber, address: $address, profession: $profession, nicNumber: $nicNumber, category: $category, economicalActivity: $economicalActivity, personalStatus: $personalStatus, locality: $locality, profile: $profile, signature: $signature, createdAt: $createdAt, updatedAt: $updatedAt)';
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
        other.category == category &&
        other.economicalActivity == economicalActivity &&
        other.personalStatus == personalStatus &&
        other.locality == locality &&
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
        category.hashCode ^
        economicalActivity.hashCode ^
        personalStatus.hashCode ^
        locality.hashCode ^
        profile.hashCode ^
        signature.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
