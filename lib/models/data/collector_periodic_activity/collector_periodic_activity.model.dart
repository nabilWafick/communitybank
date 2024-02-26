// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/collector_periodic_activity/collector_periodic_activity_rpc.model.dart';
import 'package:flutter/foundation.dart';

class CollectorPeriodicActivity {
  final DateTime collectionDate;
  final int customerAccountId;
  final int customerId;
  final String customerName;
  final String customerFirstnames;
  final int collectorId;
  final String collectorName;
  final String collectorFirstnames;
  final List<dynamic> customersCardsIds;
  final List<String> customersCardsLabels;
  final List<dynamic> customersCardsTypesNumbers;
  final List<dynamic> typesIds;
  final List<dynamic> typesNames;
  final List<dynamic> customerCardSettlementsTotals;
  final List<double> customerCardSettlementsAmounts;
  CollectorPeriodicActivity({
    required this.collectionDate,
    required this.customerAccountId,
    required this.customerId,
    required this.customerName,
    required this.customerFirstnames,
    required this.collectorId,
    required this.collectorName,
    required this.collectorFirstnames,
    required this.customersCardsIds,
    required this.customersCardsLabels,
    required this.customersCardsTypesNumbers,
    required this.typesIds,
    required this.typesNames,
    required this.customerCardSettlementsTotals,
    required this.customerCardSettlementsAmounts,
  });

  CollectorPeriodicActivity copyWith({
    DateTime? collectionDate,
    int? customerAccountId,
    int? customerId,
    String? customerName,
    String? customerFirstnames,
    int? collectorId,
    String? collectorName,
    String? collectorFirstnames,
    List<dynamic>? customersCardsIds,
    List<String>? customersCardsLabels,
    List<dynamic>? customersCardsTypesNumbers,
    List<dynamic>? typesIds,
    List<dynamic>? typesNames,
    List<dynamic>? customerCardSettlementsTotals,
    List<double>? customerCardSettlementsAmounts,
  }) {
    return CollectorPeriodicActivity(
      collectionDate: collectionDate ?? this.collectionDate,
      customerAccountId: customerAccountId ?? this.customerAccountId,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerFirstnames: customerFirstnames ?? this.customerFirstnames,
      collectorId: collectorId ?? this.collectorId,
      collectorName: collectorName ?? this.collectorName,
      collectorFirstnames: collectorFirstnames ?? this.collectorFirstnames,
      customersCardsIds: customersCardsIds ?? this.customersCardsIds,
      customersCardsLabels: customersCardsLabels ?? this.customersCardsLabels,
      customersCardsTypesNumbers:
          customersCardsTypesNumbers ?? this.customersCardsTypesNumbers,
      typesIds: typesIds ?? this.typesIds,
      typesNames: typesNames ?? this.typesNames,
      customerCardSettlementsTotals:
          customerCardSettlementsTotals ?? this.customerCardSettlementsTotals,
      customerCardSettlementsAmounts:
          customerCardSettlementsAmounts ?? this.customerCardSettlementsAmounts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CollectorPeriodicActivityRPC.collectionDate:
          collectionDate.toIso8601String(),
      CollectorPeriodicActivityRPC.customerAccountId: customerAccountId,
      CollectorPeriodicActivityRPC.customerId: customerId,
      CollectorPeriodicActivityRPC.customerName: customerName,
      CollectorPeriodicActivityRPC.customerFirstnames: customerFirstnames,
      CollectorPeriodicActivityRPC.collectorId: collectorId,
      CollectorPeriodicActivityRPC.collectorName: collectorName,
      CollectorPeriodicActivityRPC.collectorFirstnames: collectorFirstnames,
      CollectorPeriodicActivityRPC.customersCardsIds: customersCardsIds,
      CollectorPeriodicActivityRPC.customersCardsLabels: customersCardsLabels,
      CollectorPeriodicActivityRPC.customersCardsTypesNumbers:
          customersCardsTypesNumbers,
      CollectorPeriodicActivityRPC.typesIds: typesIds,
      CollectorPeriodicActivityRPC.typesNames: typesNames,
      CollectorPeriodicActivityRPC.customerCardSettlementsTotals:
          customerCardSettlementsTotals,
      CollectorPeriodicActivityRPC.customerCardSettlementsAmounts:
          customerCardSettlementsAmounts,
    };
  }

  factory CollectorPeriodicActivity.fromMap(Map<String, dynamic> map) {
    return CollectorPeriodicActivity(
      collectionDate:
          DateTime.parse(map[CollectorPeriodicActivityRPC.collectionDate]),
      customerAccountId:
          map[CollectorPeriodicActivityRPC.customerAccountId] as int,
      customerId: map[CollectorPeriodicActivityRPC.customerId] as int,
      customerName: map[CollectorPeriodicActivityRPC.customerName] as String,
      customerFirstnames:
          map[CollectorPeriodicActivityRPC.customerFirstnames] as String,
      collectorId: map[CollectorPeriodicActivityRPC.collectorId] as int,
      collectorName: map[CollectorPeriodicActivityRPC.collectorName] as String,
      collectorFirstnames:
          map[CollectorPeriodicActivityRPC.collectorFirstnames] as String,
      customersCardsIds: List<dynamic>.from(
          (map[CollectorPeriodicActivityRPC.customersCardsIds])
              as List<dynamic>),
      customersCardsLabels: List<String>.from(
          (map[CollectorPeriodicActivityRPC.customersCardsLabels])
              as List<String>),
      customersCardsTypesNumbers: List<dynamic>.from(
          (map[CollectorPeriodicActivityRPC.customersCardsTypesNumbers])
              as List<dynamic>),
      typesIds: List<dynamic>.from(
          (map[CollectorPeriodicActivityRPC.typesIds]) as List<dynamic>),
      typesNames: List<dynamic>.from(
          (map[CollectorPeriodicActivityRPC.typesNames]) as List<dynamic>),
      customerCardSettlementsTotals: List<dynamic>.from(
          (map[CollectorPeriodicActivityRPC.customerCardSettlementsTotals])
              as List<dynamic>),
      customerCardSettlementsAmounts: List<double>.from(
          (map[CollectorPeriodicActivityRPC.customerCardSettlementsAmounts])
              as List<double>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CollectorPeriodicActivity.fromJson(String source) =>
      CollectorPeriodicActivity.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CollectorPeriodicActivity(collectionDate: $collectionDate, customerAccountId: $customerAccountId, customerId: $customerId, customerName: $customerName, customerFirstnames: $customerFirstnames, collectorId: $collectorId, collectorName: $collectorName, collectorFirstnames: $collectorFirstnames, customersCardsIds: $customersCardsIds, customersCardsLabels: $customersCardsLabels, customersCardsTypesNumbers: $customersCardsTypesNumbers, typesIds: $typesIds, typesNames: $typesNames, customerCardSettlementsTotals: $customerCardSettlementsTotals, customerCardSettlementsAmounts: $customerCardSettlementsAmounts)';
  }

  @override
  bool operator ==(covariant CollectorPeriodicActivity other) {
    if (identical(this, other)) return true;

    return other.collectionDate == collectionDate &&
        other.customerAccountId == customerAccountId &&
        other.customerId == customerId &&
        other.customerName == customerName &&
        other.customerFirstnames == customerFirstnames &&
        other.collectorId == collectorId &&
        other.collectorName == collectorName &&
        other.collectorFirstnames == collectorFirstnames &&
        listEquals(other.customersCardsIds, customersCardsIds) &&
        listEquals(other.customersCardsLabels, customersCardsLabels) &&
        listEquals(
            other.customersCardsTypesNumbers, customersCardsTypesNumbers) &&
        listEquals(other.typesIds, typesIds) &&
        listEquals(other.typesNames, typesNames) &&
        listEquals(other.customerCardSettlementsTotals,
            customerCardSettlementsTotals) &&
        listEquals(other.customerCardSettlementsAmounts,
            customerCardSettlementsAmounts);
  }

  @override
  int get hashCode {
    return collectionDate.hashCode ^
        customerAccountId.hashCode ^
        customerId.hashCode ^
        customerName.hashCode ^
        customerFirstnames.hashCode ^
        collectorId.hashCode ^
        collectorName.hashCode ^
        collectorFirstnames.hashCode ^
        customersCardsIds.hashCode ^
        customersCardsLabels.hashCode ^
        customersCardsTypesNumbers.hashCode ^
        typesIds.hashCode ^
        typesNames.hashCode ^
        customerCardSettlementsTotals.hashCode ^
        customerCardSettlementsAmounts.hashCode;
  }
}
