// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CustomersProductsPerCollector {
  final int productId;
  final String productName;
  final double productStake;
  final dynamic collectorId;
  final dynamic collector;
  final List<dynamic> customersAccountsIds;
  final List<dynamic> customersIds;
  final List<dynamic> customers;
  final List<dynamic> customersCardsLabels;
  final List<dynamic> customersCardsProductsNumbers;
  final List<dynamic> customersCardsSettlementsTotals;
  final List<dynamic> customersCardsSettlementsAmounts;
  CustomersProductsPerCollector({
    required this.productId,
    required this.productName,
    required this.productStake,
    required this.collectorId,
    required this.collector,
    required this.customersAccountsIds,
    required this.customersIds,
    required this.customers,
    required this.customersCardsLabels,
    required this.customersCardsProductsNumbers,
    required this.customersCardsSettlementsTotals,
    required this.customersCardsSettlementsAmounts,
  });

  CustomersProductsPerCollector copyWith({
    int? productId,
    String? productName,
    double? productStake,
    int? collectorId,
    String? collector,
    List<dynamic>? customersAccountsIds,
    List<dynamic>? customersIds,
    List<dynamic>? customers,
    List<dynamic>? customersCardsLabels,
    List<dynamic>? customersCardsProductsNumbers,
    List<dynamic>? customersCardsSettlementsTotals,
    List<dynamic>? customersCardsSettlementsAmounts,
  }) {
    return CustomersProductsPerCollector(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productStake: productStake ?? this.productStake,
      collectorId: collectorId ?? this.collectorId,
      collector: collector ?? this.collector,
      customersAccountsIds: customersAccountsIds ?? this.customersAccountsIds,
      customersIds: customersIds ?? this.customersIds,
      customers: customers ?? this.customers,
      customersCardsLabels: customersCardsLabels ?? this.customersCardsLabels,
      customersCardsProductsNumbers:
          customersCardsProductsNumbers ?? this.customersCardsProductsNumbers,
      customersCardsSettlementsTotals: customersCardsSettlementsTotals ??
          this.customersCardsSettlementsTotals,
      customersCardsSettlementsAmounts: customersCardsSettlementsAmounts ??
          this.customersCardsSettlementsAmounts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'productName': productName,
      'productStake': productStake,
      'collectorId': collectorId,
      'collector': collector,
      'customersAccountsIds': customersAccountsIds,
      'customersIds': customersIds,
      'customers': customers,
      'customersCardsLabels': customersCardsLabels,
      'customersCardsProductsNumbers': customersCardsProductsNumbers,
      'customersCardsSettlementsTotals': customersCardsSettlementsTotals,
      'customersCardsSettlementsAmounts': customersCardsSettlementsAmounts,
    };
  }

  factory CustomersProductsPerCollector.fromMap(Map<String, dynamic> map) {
    return CustomersProductsPerCollector(
      productId: map['productId'] as int,
      productName: map['productName'] as String,
      productStake: map['productStake'] as double,
      collectorId: map['collectorId'] as int,
      collector: map['collector'] as String,
      customersAccountsIds:
          List<dynamic>.from(map['customersAccountsIds'] as List<dynamic>),
      customersIds: List<dynamic>.from(map['customersIds'] as List<dynamic>),
      customers: List<dynamic>.from(map['customers'] as List<dynamic>),
      customersCardsLabels:
          List<dynamic>.from(map['customersCardsLabels'] as List<dynamic>),
      customersCardsProductsNumbers: List<dynamic>.from(
          map['customersCardsProductsNumbers'] as List<dynamic>),
      customersCardsSettlementsTotals: List<dynamic>.from(
          map['customersCardsSettlementsTotals'] as List<dynamic>),
      customersCardsSettlementsAmounts: List<dynamic>.from(
          map['customersCardsSettlementsAmounts'] as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomersProductsPerCollector.fromJson(String source) =>
      CustomersProductsPerCollector.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomersProductsPerCollector(productId: $productId, productName: $productName, productStake: $productStake, collectorId: $collectorId, collector: $collector, customersAccountsIds: $customersAccountsIds, customersIds: $customersIds, customers: $customers, customersCardsLabels: $customersCardsLabels, customersCardsProductsNumbers: $customersCardsProductsNumbers, customersCardsSettlementsTotals: $customersCardsSettlementsTotals, customersCardsSettlementsAmounts: $customersCardsSettlementsAmounts)';
  }

  @override
  bool operator ==(covariant CustomersProductsPerCollector other) {
    if (identical(this, other)) return true;

    return other.productId == productId &&
        other.productName == productName &&
        other.productStake == productStake &&
        other.collectorId == collectorId &&
        other.collector == collector &&
        listEquals(other.customersAccountsIds, customersAccountsIds) &&
        listEquals(other.customersIds, customersIds) &&
        listEquals(other.customers, customers) &&
        listEquals(other.customersCardsLabels, customersCardsLabels) &&
        listEquals(other.customersCardsProductsNumbers,
            customersCardsProductsNumbers) &&
        listEquals(other.customersCardsSettlementsTotals,
            customersCardsSettlementsTotals) &&
        listEquals(other.customersCardsSettlementsAmounts,
            customersCardsSettlementsAmounts);
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        productName.hashCode ^
        productStake.hashCode ^
        collectorId.hashCode ^
        collector.hashCode ^
        customersAccountsIds.hashCode ^
        customersIds.hashCode ^
        customers.hashCode ^
        customersCardsLabels.hashCode ^
        customersCardsProductsNumbers.hashCode ^
        customersCardsSettlementsTotals.hashCode ^
        customersCardsSettlementsAmounts.hashCode;
  }
}
