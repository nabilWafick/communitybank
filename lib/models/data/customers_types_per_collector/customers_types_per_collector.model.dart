// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CustomersTypesPerCollector {
  final int typeId;
  final String typeName;
  final double typeStake;
  final dynamic collectorId;
  final dynamic collector;
  final List<dynamic> customersAccountsIds;
  final List<dynamic> customersIds;
  final List<dynamic> customers;
  final List<dynamic> customersCardsLabels;
  final List<dynamic> customersCardsTypesNumbers;
  final List<dynamic> customersCardsSettlementsTotals;
  final List<dynamic> customersCardsSettlementsAmounts;
  CustomersTypesPerCollector({
    required this.typeId,
    required this.typeName,
    required this.typeStake,
    required this.collectorId,
    required this.collector,
    required this.customersAccountsIds,
    required this.customersIds,
    required this.customers,
    required this.customersCardsLabels,
    required this.customersCardsTypesNumbers,
    required this.customersCardsSettlementsTotals,
    required this.customersCardsSettlementsAmounts,
  });

  CustomersTypesPerCollector copyWith({
    int? typeId,
    String? typeName,
    double? typeStake,
    int? collectorId,
    String? collector,
    List<dynamic>? customersAccountsIds,
    List<dynamic>? customersIds,
    List<dynamic>? customers,
    List<dynamic>? customersCardsLabels,
    List<dynamic>? customersCardsTypesNumbers,
    List<dynamic>? customersCardsSettlementsTotals,
    List<dynamic>? customersCardsSettlementsAmounts,
  }) {
    return CustomersTypesPerCollector(
      typeId: typeId ?? this.typeId,
      typeName: typeName ?? this.typeName,
      typeStake: typeStake ?? this.typeStake,
      collectorId: collectorId ?? this.collectorId,
      collector: collector ?? this.collector,
      customersAccountsIds: customersAccountsIds ?? this.customersAccountsIds,
      customersIds: customersIds ?? this.customersIds,
      customers: customers ?? this.customers,
      customersCardsLabels: customersCardsLabels ?? this.customersCardsLabels,
      customersCardsTypesNumbers:
          customersCardsTypesNumbers ?? this.customersCardsTypesNumbers,
      customersCardsSettlementsTotals: customersCardsSettlementsTotals ??
          this.customersCardsSettlementsTotals,
      customersCardsSettlementsAmounts: customersCardsSettlementsAmounts ??
          this.customersCardsSettlementsAmounts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'typeId': typeId,
      'typeName': typeName,
      'typeStake': typeStake,
      'collectorId': collectorId,
      'collector': collector,
      'customersAccountsIds': customersAccountsIds,
      'customersIds': customersIds,
      'customers': customers,
      'customersCardsLabels': customersCardsLabels,
      'customersCardsTypesNumbers': customersCardsTypesNumbers,
      'customersCardsSettlementsTotals': customersCardsSettlementsTotals,
      'customersCardsSettlementsAmounts': customersCardsSettlementsAmounts,
    };
  }

  factory CustomersTypesPerCollector.fromMap(Map<String, dynamic> map) {
    return CustomersTypesPerCollector(
      typeId: map['typeId'] as int,
      typeName: map['typeName'] as String,
      typeStake: map['typeStake'] as double,
      collectorId: map['collectorId'] as int,
      collector: map['collector'] as String,
      customersAccountsIds:
          List<dynamic>.from(map['customersAccountsIds'] as List<dynamic>),
      customersIds: List<dynamic>.from(map['customersIds'] as List<dynamic>),
      customers: List<dynamic>.from(map['customers'] as List<dynamic>),
      customersCardsLabels:
          List<dynamic>.from(map['customersCardsLabels'] as List<dynamic>),
      customersCardsTypesNumbers: List<dynamic>.from(
          map['customersCardsTypesNumbers'] as List<dynamic>),
      customersCardsSettlementsTotals: List<dynamic>.from(
          map['customersCardsSettlementsTotals'] as List<dynamic>),
      customersCardsSettlementsAmounts: List<dynamic>.from(
          map['customersCardsSettlementsAmounts'] as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomersTypesPerCollector.fromJson(String source) =>
      CustomersTypesPerCollector.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomersTypesPerCollector(typeId: $typeId, typeName: $typeName, typeStake: $typeStake, collectorId: $collectorId, collector: $collector, customersAccountsIds: $customersAccountsIds, customersIds: $customersIds, customers: $customers, customersCardsLabels: $customersCardsLabels, customersCardsTypesNumbers: $customersCardsTypesNumbers, customersCardsSettlementsTotals: $customersCardsSettlementsTotals, customersCardsSettlementsAmounts: $customersCardsSettlementsAmounts)';
  }

  @override
  bool operator ==(covariant CustomersTypesPerCollector other) {
    if (identical(this, other)) return true;

    return other.typeId == typeId &&
        other.typeName == typeName &&
        other.typeStake == typeStake &&
        other.collectorId == collectorId &&
        other.collector == collector &&
        listEquals(other.customersAccountsIds, customersAccountsIds) &&
        listEquals(other.customersIds, customersIds) &&
        listEquals(other.customers, customers) &&
        listEquals(other.customersCardsLabels, customersCardsLabels) &&
        listEquals(
            other.customersCardsTypesNumbers, customersCardsTypesNumbers) &&
        listEquals(other.customersCardsSettlementsTotals,
            customersCardsSettlementsTotals) &&
        listEquals(other.customersCardsSettlementsAmounts,
            customersCardsSettlementsAmounts);
  }

  @override
  int get hashCode {
    return typeId.hashCode ^
        typeName.hashCode ^
        typeStake.hashCode ^
        collectorId.hashCode ^
        collector.hashCode ^
        customersAccountsIds.hashCode ^
        customersIds.hashCode ^
        customers.hashCode ^
        customersCardsLabels.hashCode ^
        customersCardsTypesNumbers.hashCode ^
        customersCardsSettlementsTotals.hashCode ^
        customersCardsSettlementsAmounts.hashCode;
  }
}
