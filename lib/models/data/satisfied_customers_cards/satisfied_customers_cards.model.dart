// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/satisfied_customers_cards/satisfied_customers_cards_rpc.model.dart';
import 'package:flutter/foundation.dart';

class SatisfiedCustomersCards {
  final dynamic collectorId;
  final dynamic collector;
  final List<dynamic> customersAccountsIds;
  final List<dynamic> customers;
  final List<dynamic> customersCardsIds;
  final List<dynamic> customersCardsLabels;
  final List<dynamic> customersCardsTypesNumbers;
  final List<dynamic> typesIds;
  final List<dynamic> typesNames;
  final List<dynamic> repaymentsDates;
  final List<dynamic> satisfactionsDates;
  final List<dynamic> transfersDates;
  SatisfiedCustomersCards({
    required this.collectorId,
    required this.collector,
    required this.customersAccountsIds,
    required this.customers,
    required this.customersCardsIds,
    required this.customersCardsLabels,
    required this.customersCardsTypesNumbers,
    required this.typesIds,
    required this.typesNames,
    required this.repaymentsDates,
    required this.satisfactionsDates,
    required this.transfersDates,
  });

  SatisfiedCustomersCards copyWith({
    dynamic collectorId,
    dynamic collector,
    List<dynamic>? customersAccountsIds,
    List<dynamic>? customers,
    List<dynamic>? customersCardsIds,
    List<dynamic>? customersCardsLabels,
    List<dynamic>? customersCardsTypesNumbers,
    List<dynamic>? typesIds,
    List<dynamic>? typesNames,
    List<dynamic>? repaymentsDates,
    List<dynamic>? satisfactionsDates,
    List<dynamic>? transfersDates,
  }) {
    return SatisfiedCustomersCards(
      collectorId: collectorId ?? this.collectorId,
      collector: collector ?? this.collector,
      customersAccountsIds: customersAccountsIds ?? this.customersAccountsIds,
      customers: customers ?? this.customers,
      customersCardsIds: customersCardsIds ?? this.customersCardsIds,
      customersCardsLabels: customersCardsLabels ?? this.customersCardsLabels,
      customersCardsTypesNumbers:
          customersCardsTypesNumbers ?? this.customersCardsTypesNumbers,
      typesIds: typesIds ?? this.typesIds,
      typesNames: typesNames ?? this.typesNames,
      repaymentsDates: repaymentsDates ?? this.repaymentsDates,
      satisfactionsDates: satisfactionsDates ?? this.satisfactionsDates,
      transfersDates: transfersDates ?? this.transfersDates,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      SatisfiedCustomersCardsRPC.collectorId: collectorId,
      SatisfiedCustomersCardsRPC.collector: collector,
      SatisfiedCustomersCardsRPC.customersAccountsIds: customersAccountsIds,
      SatisfiedCustomersCardsRPC.customers: customers,
      SatisfiedCustomersCardsRPC.customersCardsIds: customersCardsIds,
      SatisfiedCustomersCardsRPC.customersCardsLabels: customersCardsLabels,
      SatisfiedCustomersCardsRPC.customersCardsTypesNumbers:
          customersCardsTypesNumbers,
      SatisfiedCustomersCardsRPC.typesIds: typesIds,
      SatisfiedCustomersCardsRPC.typesNames: typesNames,
      SatisfiedCustomersCardsRPC.repaymentsDates: repaymentsDates,
      SatisfiedCustomersCardsRPC.satisfactionsDates: satisfactionsDates,
      SatisfiedCustomersCardsRPC.transfersDates: transfersDates,
    };
  }

  factory SatisfiedCustomersCards.fromMap(Map<String, dynamic> map) {
    return SatisfiedCustomersCards(
      collectorId: map[SatisfiedCustomersCardsRPC.collectorId] as dynamic,
      collector: map[SatisfiedCustomersCardsRPC.collector] as dynamic,
      customersAccountsIds: List<dynamic>.from(
          map[SatisfiedCustomersCardsRPC.customersAccountsIds]
              as List<dynamic>),
      customers: List<dynamic>.from(
          map[SatisfiedCustomersCardsRPC.customers] as List<dynamic>),
      customersCardsIds: List<dynamic>.from(
          map[SatisfiedCustomersCardsRPC.customersCardsIds] as List<dynamic>),
      customersCardsLabels: List<dynamic>.from(
          map[SatisfiedCustomersCardsRPC.customersCardsLabels]
              as List<dynamic>),
      customersCardsTypesNumbers: List<dynamic>.from(
          map[SatisfiedCustomersCardsRPC.customersCardsTypesNumbers]
              as List<dynamic>),
      typesIds: List<dynamic>.from(
          map[SatisfiedCustomersCardsRPC.typesIds] as List<dynamic>),
      typesNames: List<dynamic>.from(
          map[SatisfiedCustomersCardsRPC.typesNames] as List<dynamic>),
      repaymentsDates: List<dynamic>.from(
          map[SatisfiedCustomersCardsRPC.repaymentsDates] as List<dynamic>),
      satisfactionsDates: List<dynamic>.from(
          map[SatisfiedCustomersCardsRPC.satisfactionsDates] as List<dynamic>),
      transfersDates: List<dynamic>.from(
          map[SatisfiedCustomersCardsRPC.transfersDates] as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory SatisfiedCustomersCards.fromJson(String source) =>
      SatisfiedCustomersCards.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SatisfiedCustomersCards(collectorId: $collectorId, collector: $collector, customersAccountsIds: $customersAccountsIds, customers: $customers, customersCardsIds: $customersCardsIds, customersCardsLabels: $customersCardsLabels, customersCardsTypesNumbers: $customersCardsTypesNumbers, typesIds: $typesIds, typesNames: $typesNames, repaymentsDates: $repaymentsDates, satisfactionsDates: $satisfactionsDates, transfersDates: $transfersDates)';
  }

  @override
  bool operator ==(covariant SatisfiedCustomersCards other) {
    if (identical(this, other)) return true;

    return other.collectorId == collectorId &&
        other.collector == collector &&
        listEquals(other.customersAccountsIds, customersAccountsIds) &&
        listEquals(other.customers, customers) &&
        listEquals(other.customersCardsIds, customersCardsIds) &&
        listEquals(other.customersCardsLabels, customersCardsLabels) &&
        listEquals(
            other.customersCardsTypesNumbers, customersCardsTypesNumbers) &&
        listEquals(other.typesIds, typesIds) &&
        listEquals(other.typesNames, typesNames) &&
        listEquals(other.repaymentsDates, repaymentsDates) &&
        listEquals(other.satisfactionsDates, satisfactionsDates) &&
        listEquals(other.transfersDates, transfersDates);
  }

  @override
  int get hashCode {
    return collectorId.hashCode ^
        collector.hashCode ^
        customersAccountsIds.hashCode ^
        customers.hashCode ^
        customersCardsIds.hashCode ^
        customersCardsLabels.hashCode ^
        customersCardsTypesNumbers.hashCode ^
        typesIds.hashCode ^
        typesNames.hashCode ^
        repaymentsDates.hashCode ^
        satisfactionsDates.hashCode ^
        transfersDates.hashCode;
  }
}
