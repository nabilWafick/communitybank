// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/customers_types/customers_types_rpc.model.dart';
import 'package:flutter/foundation.dart';

class CustomersTypes {
  final int typeId;
  final String typeName;
  final double typeStake;
  final List<dynamic> collectorsIds;
  final List<dynamic> collectors;
  final List<dynamic> customersAccountsIds;
  final List<dynamic> customersIds;
  final List<dynamic> customers;
  final List<dynamic> customersCardsLabels;
  final List<dynamic> customersCardsTypesNumbers;
  final List<dynamic> customerCardSettlementsTotals;
  final List<dynamic> customerCardSettlementsAmounts;
  CustomersTypes({
    required this.typeId,
    required this.typeName,
    required this.typeStake,
    required this.collectorsIds,
    required this.collectors,
    required this.customersAccountsIds,
    required this.customersIds,
    required this.customers,
    required this.customersCardsLabels,
    required this.customersCardsTypesNumbers,
    required this.customerCardSettlementsTotals,
    required this.customerCardSettlementsAmounts,
  });

  CustomersTypes copyWith({
    int? typeId,
    String? typeName,
    double? typeStake,
    List<dynamic>? collectorsIds,
    List<dynamic>? collectors,
    List<dynamic>? customersAccountsIds,
    List<dynamic>? customersIds,
    List<dynamic>? customers,
    List<dynamic>? customersCardsLabels,
    List<dynamic>? customersCardsTypesNumbers,
    List<dynamic>? customerCardSettlementsTotals,
    List<dynamic>? customerCardSettlementsAmounts,
  }) {
    return CustomersTypes(
      typeId: typeId ?? this.typeId,
      typeName: typeName ?? this.typeName,
      typeStake: typeStake ?? this.typeStake,
      collectorsIds: collectorsIds ?? this.collectorsIds,
      collectors: collectors ?? this.collectors,
      customersAccountsIds: customersAccountsIds ?? this.customersAccountsIds,
      customersIds: customersIds ?? this.customersIds,
      customers: customers ?? this.customers,
      customersCardsLabels: customersCardsLabels ?? this.customersCardsLabels,
      customersCardsTypesNumbers:
          customersCardsTypesNumbers ?? this.customersCardsTypesNumbers,
      customerCardSettlementsTotals:
          customerCardSettlementsTotals ?? this.customerCardSettlementsTotals,
      customerCardSettlementsAmounts:
          customerCardSettlementsAmounts ?? this.customerCardSettlementsAmounts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CustomersTypesRPC.typeId: typeId,
      CustomersTypesRPC.typeName: typeName,
      CustomersTypesRPC.typeStake: typeStake,
      CustomersTypesRPC.collectorsIds: collectorsIds,
      CustomersTypesRPC.collectors: collectors,
      CustomersTypesRPC.customersAccountsIds: customersAccountsIds,
      CustomersTypesRPC.customersIds: customersIds,
      CustomersTypesRPC.customers: customers,
      CustomersTypesRPC.customersCardsLabels: customersCardsLabels,
      CustomersTypesRPC.customersCardsTypesNumbers: customersCardsTypesNumbers,
      CustomersTypesRPC.customerCardSettlementsTotals:
          customerCardSettlementsTotals,
      CustomersTypesRPC.customerCardSettlementsAmounts:
          customerCardSettlementsAmounts,
    };
  }

  factory CustomersTypes.fromMap(Map<String, dynamic> map) {
    return CustomersTypes(
      typeId: map[CustomersTypesRPC.typeId] as int,
      typeName: map[CustomersTypesRPC.typeName] as String,
      typeStake: map[CustomersTypesRPC.typeStake] as double,
      collectorsIds: List<dynamic>.from(
          map[CustomersTypesRPC.collectorsIds] as List<dynamic>),
      collectors: List<dynamic>.from(
          map[CustomersTypesRPC.collectors] as List<dynamic>),
      customersAccountsIds: List<dynamic>.from(
          map[CustomersTypesRPC.customersAccountsIds] as List<dynamic>),
      customersIds: List<dynamic>.from(
          map[CustomersTypesRPC.customersIds] as List<dynamic>),
      customers:
          List<dynamic>.from(map[CustomersTypesRPC.customers] as List<dynamic>),
      customersCardsLabels: List<dynamic>.from(
          map[CustomersTypesRPC.customersCardsLabels] as List<dynamic>),
      customersCardsTypesNumbers: List<dynamic>.from(
          map[CustomersTypesRPC.customersCardsTypesNumbers] as List<dynamic>),
      customerCardSettlementsTotals: List<dynamic>.from(
          map[CustomersTypesRPC.customerCardSettlementsTotals]
              as List<dynamic>),
      customerCardSettlementsAmounts: List<dynamic>.from(
          map[CustomersTypesRPC.customerCardSettlementsAmounts]
              as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomersTypes.fromJson(String source) =>
      CustomersTypes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomersTypes(typeId: $typeId, typeName: $typeName, typeStake: $typeStake, collectorsIds: $collectorsIds, collectors: $collectors, customersAccountsIds: $customersAccountsIds, customersIds: $customersIds, customers: $customers, customersCardsLabels: $customersCardsLabels, customersCardsTypesNumbers: $customersCardsTypesNumbers, customerCardSettlementsTotals: $customerCardSettlementsTotals, customerCardSettlementsAmounts: $customerCardSettlementsAmounts)';
  }

  @override
  bool operator ==(covariant CustomersTypes other) {
    if (identical(this, other)) return true;

    return other.typeId == typeId &&
        other.typeName == typeName &&
        other.typeStake == typeStake &&
        listEquals(other.collectorsIds, collectorsIds) &&
        listEquals(other.collectors, collectors) &&
        listEquals(other.customersAccountsIds, customersAccountsIds) &&
        listEquals(other.customersIds, customersIds) &&
        listEquals(other.customers, customers) &&
        listEquals(other.customersCardsLabels, customersCardsLabels) &&
        listEquals(
            other.customersCardsTypesNumbers, customersCardsTypesNumbers) &&
        listEquals(other.customerCardSettlementsTotals,
            customerCardSettlementsTotals) &&
        listEquals(other.customerCardSettlementsAmounts,
            customerCardSettlementsAmounts);
  }

  @override
  int get hashCode {
    return typeId.hashCode ^
        typeName.hashCode ^
        typeStake.hashCode ^
        collectorsIds.hashCode ^
        collectors.hashCode ^
        customersAccountsIds.hashCode ^
        customersIds.hashCode ^
        customers.hashCode ^
        customersCardsLabels.hashCode ^
        customersCardsTypesNumbers.hashCode ^
        customerCardSettlementsTotals.hashCode ^
        customerCardSettlementsAmounts.hashCode;
  }
}
