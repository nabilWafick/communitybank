// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/customers_types/customers_types_rpc.model.dart';
import 'package:flutter/foundation.dart';

class CustomersTypes {
  int typeId;
  String typeName;
  List<dynamic> customersAccountsIds;
  List<dynamic> customersIds;
  List<String> customersNames;
  List<String> customersFirstnames;
  CustomersTypes({
    required this.typeId,
    required this.typeName,
    required this.customersAccountsIds,
    required this.customersIds,
    required this.customersNames,
    required this.customersFirstnames,
  });

  CustomersTypes copyWith({
    int? typeId,
    String? typeName,
    List<dynamic>? customersAccountsIds,
    List<dynamic>? customersIds,
    List<String>? customersNames,
    List<String>? customersFirstnames,
  }) {
    return CustomersTypes(
      typeId: typeId ?? this.typeId,
      typeName: typeName ?? this.typeName,
      customersAccountsIds: customersAccountsIds ?? this.customersAccountsIds,
      customersIds: customersIds ?? this.customersIds,
      customersNames: customersNames ?? this.customersNames,
      customersFirstnames: customersFirstnames ?? this.customersFirstnames,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CustomersTypesRPC.typeId: typeId,
      CustomersTypesRPC.typeName: typeName,
      CustomersTypesRPC.customersAccountsIds: customersAccountsIds,
      CustomersTypesRPC.customersIds: customersIds,
      CustomersTypesRPC.customersNames: customersNames,
      CustomersTypesRPC.customersFirstnames: customersFirstnames,
    };
  }

  factory CustomersTypes.fromMap(Map<String, dynamic> map) {
    return CustomersTypes(
      typeId: map[CustomersTypesRPC.typeId] as int,
      typeName: map[CustomersTypesRPC.typeName] as String,
      customersAccountsIds: List<dynamic>.from(
          (map[CustomersTypesRPC.customersAccountsIds]) as List<dynamic>),
      customersIds: List<dynamic>.from(
          (map[CustomersTypesRPC.customersIds]) as List<dynamic>),
      customersNames: List<String>.from(
          (map[CustomersTypesRPC.customersNames]) as List<String>),
      customersFirstnames: List<String>.from(
          (map[CustomersTypesRPC.customersFirstnames]) as List<String>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomersTypes.fromJson(String source) =>
      CustomersTypes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomersTypes(typeId: $typeId, typeName: $typeName, customersAccountsIds: $customersAccountsIds, customersIds: $customersIds, customersNames: $customersNames, customersFirstnames: $customersFirstnames)';
  }

  @override
  bool operator ==(covariant CustomersTypes other) {
    if (identical(this, other)) return true;

    return other.typeId == typeId &&
        other.typeName == typeName &&
        listEquals(other.customersAccountsIds, customersAccountsIds) &&
        listEquals(other.customersIds, customersIds) &&
        listEquals(other.customersNames, customersNames) &&
        listEquals(other.customersFirstnames, customersFirstnames);
  }

  @override
  int get hashCode {
    return typeId.hashCode ^
        typeName.hashCode ^
        customersAccountsIds.hashCode ^
        customersIds.hashCode ^
        customersNames.hashCode ^
        customersFirstnames.hashCode;
  }
}
