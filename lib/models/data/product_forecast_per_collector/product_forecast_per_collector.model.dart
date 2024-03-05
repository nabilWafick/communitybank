// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductForecastPerCollector {
  final int productId;
  final String productName;
  final double productPurcharsePrice;
  final dynamic forecastNumber;
  final dynamic forecastAmount;
  final dynamic collectorId;
  final dynamic collector;
  final dynamic deservingProductNumbers;
  final dynamic typesProductsNumbers;
  final dynamic typesIds;
  final dynamic typesNames;
  final dynamic typesStakes;
  final dynamic customersAccountsIds;
  final dynamic customersIds;
  final dynamic customers;
  final dynamic customersCardsLabels;
  final dynamic customersCardsTypesNumbers;
  final dynamic customersCardsSettlementsTotals;
  final dynamic customersCardsSettlementsAmounts;
  ProductForecastPerCollector({
    required this.productId,
    required this.productName,
    required this.productPurcharsePrice,
    required this.forecastNumber,
    required this.forecastAmount,
    required this.collectorId,
    required this.collector,
    required this.deservingProductNumbers,
    required this.typesProductsNumbers,
    required this.typesIds,
    required this.typesNames,
    required this.typesStakes,
    required this.customersAccountsIds,
    required this.customersIds,
    required this.customers,
    required this.customersCardsLabels,
    required this.customersCardsTypesNumbers,
    required this.customersCardsSettlementsTotals,
    required this.customersCardsSettlementsAmounts,
  });

  ProductForecastPerCollector copyWith({
    int? productId,
    String? productName,
    double? productPurcharsePrice,
    dynamic forecastNumber,
    dynamic forecastAmount,
    dynamic collectorId,
    dynamic collector,
    dynamic deservingProductNumbers,
    dynamic typesProductsNumbers,
    dynamic typesIds,
    dynamic typesNames,
    dynamic typesStakes,
    dynamic customersAccountsIds,
    dynamic customersIds,
    dynamic customers,
    dynamic customersCardsLabels,
    dynamic customersCardsTypesNumbers,
    dynamic customersCardsSettlementsTotals,
    dynamic customersCardsSettlementsAmounts,
  }) {
    return ProductForecastPerCollector(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productPurcharsePrice:
          productPurcharsePrice ?? this.productPurcharsePrice,
      forecastNumber: forecastNumber ?? this.forecastNumber,
      forecastAmount: forecastAmount ?? this.forecastAmount,
      collectorId: collectorId ?? this.collectorId,
      collector: collector ?? this.collector,
      deservingProductNumbers:
          deservingProductNumbers ?? this.deservingProductNumbers,
      typesProductsNumbers: typesProductsNumbers ?? this.typesProductsNumbers,
      typesIds: typesIds ?? this.typesIds,
      typesNames: typesNames ?? this.typesNames,
      typesStakes: typesStakes ?? this.typesStakes,
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
      'productId': productId,
      'productName': productName,
      'productPurcharsePrice': productPurcharsePrice,
      'forecastNumber': forecastNumber,
      'forecastAmount': forecastAmount,
      'collectorId': collectorId,
      'collector': collector,
      'deservingProductNumbers': deservingProductNumbers,
      'typesProductsNumbers': typesProductsNumbers,
      'typesIds': typesIds,
      'typesNames': typesNames,
      'typesStakes': typesStakes,
      'customersAccountsIds': customersAccountsIds,
      'customersIds': customersIds,
      'customers': customers,
      'customersCardsLabels': customersCardsLabels,
      'customersCardsTypesNumbers': customersCardsTypesNumbers,
      'customersCardsSettlementsTotals': customersCardsSettlementsTotals,
      'customersCardsSettlementsAmounts': customersCardsSettlementsAmounts,
    };
  }

  factory ProductForecastPerCollector.fromMap(Map<String, dynamic> map) {
    return ProductForecastPerCollector(
      productId: map['productId'] as int,
      productName: map['productName'] as String,
      productPurcharsePrice: map['productPurcharsePrice'] as double,
      forecastNumber: map['forecastNumber'] as dynamic,
      forecastAmount: map['forecastAmount'] as dynamic,
      collectorId: map['collectorId'] as dynamic,
      collector: map['collector'] as dynamic,
      deservingProductNumbers: map['deservingProductNumbers'] as dynamic,
      typesProductsNumbers: map['typesProductsNumbers'] as dynamic,
      typesIds: map['typesIds'] as dynamic,
      typesNames: map['typesNames'] as dynamic,
      typesStakes: map['typesStakes'] as dynamic,
      customersAccountsIds: map['customersAccountsIds'] as dynamic,
      customersIds: map['customersIds'] as dynamic,
      customers: map['customers'] as dynamic,
      customersCardsLabels: map['customersCardsLabels'] as dynamic,
      customersCardsTypesNumbers: map['customersCardsTypesNumbers'] as dynamic,
      customersCardsSettlementsTotals:
          map['customersCardsSettlementsTotals'] as dynamic,
      customersCardsSettlementsAmounts:
          map['customersCardsSettlementsAmounts'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductForecastPerCollector.fromJson(String source) =>
      ProductForecastPerCollector.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductForecastPerCollector(productId: $productId, productName: $productName, productPurcharsePrice: $productPurcharsePrice, forecastNumber: $forecastNumber, forecastAmount: $forecastAmount, collectorId: $collectorId, collector: $collector, deservingProductNumbers: $deservingProductNumbers, typesProductsNumbers: $typesProductsNumbers, typesIds: $typesIds, typesNames: $typesNames, typesStakes: $typesStakes, customersAccountsIds: $customersAccountsIds, customersIds: $customersIds, customers: $customers, customersCardsLabels: $customersCardsLabels, customersCardsTypesNumbers: $customersCardsTypesNumbers, customersCardsSettlementsTotals: $customersCardsSettlementsTotals, customersCardsSettlementsAmounts: $customersCardsSettlementsAmounts)';
  }

  @override
  bool operator ==(covariant ProductForecastPerCollector other) {
    if (identical(this, other)) return true;

    return other.productId == productId &&
        other.productName == productName &&
        other.productPurcharsePrice == productPurcharsePrice &&
        other.forecastNumber == forecastNumber &&
        other.forecastAmount == forecastAmount &&
        other.collectorId == collectorId &&
        other.collector == collector &&
        other.deservingProductNumbers == deservingProductNumbers &&
        listEquals(other.typesProductsNumbers, typesProductsNumbers) &&
        listEquals(other.typesIds, typesIds) &&
        listEquals(other.typesNames, typesNames) &&
        listEquals(other.typesStakes, typesStakes) &&
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
    return productId.hashCode ^
        productName.hashCode ^
        productPurcharsePrice.hashCode ^
        forecastNumber.hashCode ^
        forecastAmount.hashCode ^
        collectorId.hashCode ^
        collector.hashCode ^
        deservingProductNumbers.hashCode ^
        typesProductsNumbers.hashCode ^
        typesIds.hashCode ^
        typesNames.hashCode ^
        typesStakes.hashCode ^
        customersAccountsIds.hashCode ^
        customersIds.hashCode ^
        customers.hashCode ^
        customersCardsLabels.hashCode ^
        customersCardsTypesNumbers.hashCode ^
        customersCardsSettlementsTotals.hashCode ^
        customersCardsSettlementsAmounts.hashCode;
  }
}
