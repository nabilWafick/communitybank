// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/collector_periodic_activity/collector_periodic_activity_rpc.model.dart';
import 'package:flutter/foundation.dart';

class CollectorPeriodicActivity {
  final DateTime collectionDate;
  final int customerAccountId;
  final int customerId;
  final String customer;
  final int collectorId;
  final String collector;
  final List<dynamic> customersCardsIds;
  final List<dynamic> customersCardsLabels;
  final List<dynamic> customersCardsTypesNumbers;
  final List<dynamic> typesIds;
  final List<dynamic> typesNames;
  final List<dynamic> customerCardSettlementsTotals;
  final List<dynamic> customerCardSettlementsAmounts;
  CollectorPeriodicActivity({
    required this.collectionDate,
    required this.customerAccountId,
    required this.customerId,
    required this.customer,
    required this.collectorId,
    required this.collector,
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
    String? customer,
    int? collectorId,
    String? collector,
    List<dynamic>? customersCardsIds,
    List<dynamic>? customersCardsLabels,
    List<dynamic>? customersCardsTypesNumbers,
    List<dynamic>? typesIds,
    List<dynamic>? typesNames,
    List<dynamic>? customerCardSettlementsTotals,
    List<dynamic>? customerCardSettlementsAmounts,
  }) {
    return CollectorPeriodicActivity(
      collectionDate: collectionDate ?? this.collectionDate,
      customerAccountId: customerAccountId ?? this.customerAccountId,
      customerId: customerId ?? this.customerId,
      customer: customer ?? this.customer,
      collectorId: collectorId ?? this.collectorId,
      collector: collector ?? this.collector,
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
      CollectorPeriodicActivityRPC.customer: customer,
      CollectorPeriodicActivityRPC.collectorId: collectorId,
      CollectorPeriodicActivityRPC.collector: collector,
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
    try {
      return CollectorPeriodicActivity(
        collectionDate:
            DateTime.parse(map[CollectorPeriodicActivityRPC.collectionDate]),
        customerAccountId:
            map[CollectorPeriodicActivityRPC.customerAccountId] as int,
        customerId: map[CollectorPeriodicActivityRPC.customerId] as int,
        customer: map[CollectorPeriodicActivityRPC.customer] as String,
        collectorId: map[CollectorPeriodicActivityRPC.collectorId] as int,
        collector: map[CollectorPeriodicActivityRPC.collector] as String,
        customersCardsIds: List<dynamic>.from(
            (map[CollectorPeriodicActivityRPC.customersCardsIds])
                as List<dynamic>),
        customersCardsLabels: List<dynamic>.from(
            (map[CollectorPeriodicActivityRPC.customersCardsLabels])
                as List<dynamic>),
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
        customerCardSettlementsAmounts: List<dynamic>.from(
            (map[CollectorPeriodicActivityRPC.customerCardSettlementsAmounts])
                as List<dynamic>),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
    return CollectorPeriodicActivity(
      collectionDate: DateTime.now(),
      customerAccountId: 0,
      customerId: 0,
      customer: 'Customer',
      collectorId: 0,
      collector: 'Collector',
      customersCardsIds: [],
      customersCardsLabels: [],
      customersCardsTypesNumbers: [],
      typesIds: [],
      typesNames: [],
      customerCardSettlementsTotals: [],
      customerCardSettlementsAmounts: [],
    );
  }

  String toJson() => json.encode(toMap());

  factory CollectorPeriodicActivity.fromJson(String source) =>
      CollectorPeriodicActivity.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CollectorPeriodicActivity(collectionDate: $collectionDate, customerAccountId: $customerAccountId, customerId: $customerId, customer: $customer, collectorId: $collectorId, collector: $collector,  customersCardsIds: $customersCardsIds, customersCardsLabels: $customersCardsLabels, customersCardsTypesNumbers: $customersCardsTypesNumbers, typesIds: $typesIds, typesNames: $typesNames, customerCardSettlementsTotals: $customerCardSettlementsTotals, customerCardSettlementsAmounts: $customerCardSettlementsAmounts)';
  }

  @override
  bool operator ==(covariant CollectorPeriodicActivity other) {
    if (identical(this, other)) return true;

    return other.collectionDate == collectionDate &&
        other.customerAccountId == customerAccountId &&
        other.customerId == customerId &&
        other.customer == customer &&
        other.collectorId == collectorId &&
        other.collector == collector &&
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
        customer.hashCode ^
        collectorId.hashCode ^
        collector.hashCode ^
        customersCardsIds.hashCode ^
        customersCardsLabels.hashCode ^
        customersCardsTypesNumbers.hashCode ^
        typesIds.hashCode ^
        typesNames.hashCode ^
        customerCardSettlementsTotals.hashCode ^
        customerCardSettlementsAmounts.hashCode;
  }
}
