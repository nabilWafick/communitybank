// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/data/customers_types_per_collector/customers_types_per_collector.model.dart';
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
  final List<dynamic> customersCardsSettlementsTotals;
  final List<dynamic> customersCardsSettlementsAmounts;
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
    required this.customersCardsSettlementsTotals,
    required this.customersCardsSettlementsAmounts,
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
    List<dynamic>? customersCardsSettlementsTotals,
    List<dynamic>? customersCardsSettlementsAmounts,
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
      customersCardsSettlementsTotals: customersCardsSettlementsTotals ??
          this.customersCardsSettlementsTotals,
      customersCardsSettlementsAmounts: customersCardsSettlementsAmounts ??
          this.customersCardsSettlementsAmounts,
    );
  }

  List<CustomersTypesPerCollector> getPerCollector() {
    List<CustomersTypesPerCollector> customersTypesPerCollectorList = [];
    for (int i = 0; i < collectorsIds.length; i++) {
      dynamic collectorId = collectorsIds[i];
      dynamic collector = collectors[i];
      List<dynamic> typeCustomersAccountsIds = [];
      List<dynamic> typeCustomersIds = [];
      List<dynamic> typeCustomers = [];
      List<dynamic> typeCustomersCardsLabels = [];
      List<dynamic> typeCustomersCardsTypesNumbers = [];
      List<dynamic> typeCustomersCardsSettlementsTotals = [];
      List<dynamic> typeCustomersCardsSettlementsAmounts = [];
      // used for controling the loop
      int j = 0;
      while (j != customersAccountsIds.length && i != collectors.length) {
        typeCustomersAccountsIds.add(customersAccountsIds[i]);
        typeCustomersIds.add(customersIds[i]);
        typeCustomers.add(customers[i]);
        typeCustomersCardsLabels.add(customersCardsLabels[i]);
        typeCustomersCardsTypesNumbers.add(customersCardsTypesNumbers[i]);
        typeCustomersCardsSettlementsTotals
            .add(customersCardsSettlementsTotals[i]);
        typeCustomersCardsSettlementsAmounts
            .add(customersCardsSettlementsAmounts[i]);

        if (i != collectors.length - 1 &&
            collectorsIds[i] != collectorsIds[i + 1]) {
          // for stopping while loop
          j = collectorsIds.length;
        } else {
          // increment j for a good looping
          ++j;
          // increment i because, at this step, it still in the loop
          // and will be used to stop the loop
          ++i;
        }
      }
      final customersTypesPerCollector = CustomersTypesPerCollector(
        typeId: typeId,
        typeName: typeName,
        typeStake: typeStake,
        collectorId: collectorId,
        collector: collector,
        customersAccountsIds: typeCustomersAccountsIds,
        customersIds: typeCustomersIds,
        customers: typeCustomers,
        customersCardsLabels: typeCustomersCardsLabels,
        customersCardsTypesNumbers: typeCustomersCardsTypesNumbers,
        customersCardsSettlementsTotals: typeCustomersCardsSettlementsTotals,
        customersCardsSettlementsAmounts: typeCustomersCardsSettlementsAmounts,
      );
      customersTypesPerCollectorList.add(
        customersTypesPerCollector,
      );
    }
    return customersTypesPerCollectorList;
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
      CustomersTypesRPC.customersCardsSettlementsTotals:
          customersCardsSettlementsTotals,
      CustomersTypesRPC.customersCardsSettlementsAmounts:
          customersCardsSettlementsAmounts,
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
      customersCardsSettlementsTotals: List<dynamic>.from(
          map[CustomersTypesRPC.customersCardsSettlementsTotals]
              as List<dynamic>),
      customersCardsSettlementsAmounts: List<dynamic>.from(
          map[CustomersTypesRPC.customersCardsSettlementsAmounts]
              as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomersTypes.fromJson(String source) =>
      CustomersTypes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomersTypes(typeId: $typeId, typeName: $typeName, typeStake: $typeStake, collectorsIds: $collectorsIds, collectors: $collectors, customersAccountsIds: $customersAccountsIds, customersIds: $customersIds, customers: $customers, customersCardsLabels: $customersCardsLabels, customersCardsTypesNumbers: $customersCardsTypesNumbers, customersCardsSettlementsTotals: $customersCardsSettlementsTotals, customersCardsSettlementsAmounts: $customersCardsSettlementsAmounts)';
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
        collectorsIds.hashCode ^
        collectors.hashCode ^
        customersAccountsIds.hashCode ^
        customersIds.hashCode ^
        customers.hashCode ^
        customersCardsLabels.hashCode ^
        customersCardsTypesNumbers.hashCode ^
        customersCardsSettlementsTotals.hashCode ^
        customersCardsSettlementsAmounts.hashCode;
  }
}
