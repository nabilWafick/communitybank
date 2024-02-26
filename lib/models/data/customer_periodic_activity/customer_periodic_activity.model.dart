// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/customer_periodic_activity/customer_periodic_activity_rpc.model.dart';
import 'package:flutter/foundation.dart';

class CustomerPeriodicActivity {
  final DateTime collectionDate;
  final int customerAccountId;
  final int customerId;
  final String customerName;
  final String customerFirstnames;
  final int collectorId;
  final String collectorName;
  final String collectorFirstnames;
  final List<dynamic> customersCardsIds;
  final List<dynamic> customersCardsLabels;
  final List<dynamic> customersCardsTypesNumbers;
  final List<dynamic> typesIds;
  final List<dynamic> typesNames;
  final List<dynamic> customerCardSettlementsTotals;
  final List<dynamic> customerCardSettlementsAmounts;
  CustomerPeriodicActivity({
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

  CustomerPeriodicActivity copyWith({
    DateTime? collectionDate,
    int? customerAccountId,
    int? customerId,
    String? customerName,
    String? customerFirstnames,
    int? collectorId,
    String? collectorName,
    String? collectorFirstnames,
    List<dynamic>? customersCardsIds,
    List<dynamic>? customersCardsLabels,
    List<dynamic>? customersCardsTypesNumbers,
    List<dynamic>? typesIds,
    List<dynamic>? typesNames,
    List<dynamic>? customerCardSettlementsTotals,
    List<dynamic>? customerCardSettlementsAmounts,
  }) {
    return CustomerPeriodicActivity(
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
      CustomerPeriodicActivityRPC.collectionDate:
          collectionDate.toIso8601String(),
      CustomerPeriodicActivityRPC.customerAccountId: customerAccountId,
      CustomerPeriodicActivityRPC.customerId: customerId,
      CustomerPeriodicActivityRPC.customerName: customerName,
      CustomerPeriodicActivityRPC.customerFirstnames: customerFirstnames,
      CustomerPeriodicActivityRPC.collectorId: collectorId,
      CustomerPeriodicActivityRPC.collectorName: collectorName,
      CustomerPeriodicActivityRPC.collectorFirstnames: collectorFirstnames,
      CustomerPeriodicActivityRPC.customersCardsIds: customersCardsIds,
      CustomerPeriodicActivityRPC.customersCardsLabels: customersCardsLabels,
      CustomerPeriodicActivityRPC.customersCardsTypesNumbers:
          customersCardsTypesNumbers,
      CustomerPeriodicActivityRPC.typesIds: typesIds,
      CustomerPeriodicActivityRPC.typesNames: typesNames,
      CustomerPeriodicActivityRPC.customerCardSettlementsTotals:
          customerCardSettlementsTotals,
      CustomerPeriodicActivityRPC.customerCardSettlementsAmounts:
          customerCardSettlementsAmounts,
    };
  }

  factory CustomerPeriodicActivity.fromMap(Map<String, dynamic> map) {
    try {
      return CustomerPeriodicActivity(
        collectionDate:
            DateTime.parse(map[CustomerPeriodicActivityRPC.collectionDate]),
        customerAccountId:
            map[CustomerPeriodicActivityRPC.customerAccountId] as int,
        customerId: map[CustomerPeriodicActivityRPC.customerId] as int,
        customerName: map[CustomerPeriodicActivityRPC.customerName] as String,
        customerFirstnames:
            map[CustomerPeriodicActivityRPC.customerFirstnames] as String,
        collectorId: map[CustomerPeriodicActivityRPC.collectorId] as int,
        collectorName: map[CustomerPeriodicActivityRPC.collectorName] as String,
        collectorFirstnames:
            map[CustomerPeriodicActivityRPC.collectorFirstnames] as String,
        customersCardsIds: List<dynamic>.from(
            (map[CustomerPeriodicActivityRPC.customersCardsIds])
                as List<dynamic>),
        customersCardsLabels: List<dynamic>.from(
            (map[CustomerPeriodicActivityRPC.customersCardsLabels])
                as List<dynamic>),
        customersCardsTypesNumbers: List<dynamic>.from(
            (map[CustomerPeriodicActivityRPC.customersCardsTypesNumbers])
                as List<dynamic>),
        typesIds: List<dynamic>.from(
            (map[CustomerPeriodicActivityRPC.typesIds]) as List<dynamic>),
        typesNames: List<dynamic>.from(
            (map[CustomerPeriodicActivityRPC.typesNames]) as List<dynamic>),
        customerCardSettlementsTotals: List<dynamic>.from(
            (map[CustomerPeriodicActivityRPC.customerCardSettlementsTotals])
                as List<dynamic>),
        customerCardSettlementsAmounts: List<dynamic>.from(
            (map[CustomerPeriodicActivityRPC.customerCardSettlementsAmounts])
                as List<dynamic>),
      );
    } catch (e) {
      debugPrint(e.toString());
    }

    return CustomerPeriodicActivity(
      collectionDate: DateTime.now(),
      customerAccountId: 0,
      customerId: 0,
      customerName: 'customerName',
      customerFirstnames: 'customerFirstnames',
      collectorId: 0,
      collectorName: 'collectorName',
      collectorFirstnames: 'collectorFirstnames',
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

  factory CustomerPeriodicActivity.fromJson(String source) =>
      CustomerPeriodicActivity.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomerPeriodicActivity(collectionDate: $collectionDate, customerAccountId: $customerAccountId, customerId: $customerId, customerName: $customerName, customerFirstnames: $customerFirstnames, collectorId: $collectorId, collectorName: $collectorName, collectorFirstnames: $collectorFirstnames, customersCardsIds: $customersCardsIds, customersCardsLabels: $customersCardsLabels, customersCardsTypesNumbers: $customersCardsTypesNumbers, typesIds: $typesIds, typesNames: $typesNames, customerCardSettlementsTotals: $customerCardSettlementsTotals, customerCardSettlementsAmounts: $customerCardSettlementsAmounts)';
  }

  @override
  bool operator ==(covariant CustomerPeriodicActivity other) {
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
