// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/data/product_forecast_per_collector/product_forecast_per_collector.model.dart';
import 'package:communitybank/models/rpc/product_forecast/product_forecast_rpc.model.dart';
import 'package:flutter/foundation.dart';

class ProductForecast {
  final int productId;
  final String productName;
  final double productPurcharsePrice;
  final dynamic forecastNumber;
  final dynamic forecastAmount;
  final dynamic deservingProductNumbers;
  final dynamic typesProductsNumbers;
  final dynamic typesIds;
  final dynamic typesNames;
  final dynamic typesStakes;
  final dynamic collectorsIds;
  final dynamic collectors;
  final dynamic customersAccountsIds;
  final dynamic customersIds;
  final dynamic customers;
  final dynamic customersCardsLabels;
  final dynamic customersCardsTypesNumbers;
  final dynamic customersCardsSettlementsTotals;
  final dynamic customersCardsSettlementsAmounts;
  ProductForecast({
    required this.productId,
    required this.productName,
    required this.productPurcharsePrice,
    required this.forecastNumber,
    required this.forecastAmount,
    required this.deservingProductNumbers,
    required this.typesProductsNumbers,
    required this.typesIds,
    required this.typesNames,
    required this.typesStakes,
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

  ProductForecast copyWith({
    int? productId,
    String? productName,
    double? productPurcharsePrice,
    dynamic forecastNumber,
    dynamic forecastAmount,
    dynamic deservingProductNumbers,
    dynamic typesProductsNumbers,
    dynamic typesIds,
    dynamic typesNames,
    dynamic typesStakes,
    dynamic collectorsIds,
    dynamic collectors,
    dynamic customersAccountsIds,
    dynamic customersIds,
    dynamic customers,
    dynamic customersCardsLabels,
    dynamic customersCardsTypesNumbers,
    dynamic customersCardsSettlementsTotals,
    dynamic customersCardsSettlementsAmounts,
  }) {
    return ProductForecast(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productPurcharsePrice:
          productPurcharsePrice ?? this.productPurcharsePrice,
      forecastNumber: forecastNumber ?? this.forecastNumber,
      forecastAmount: forecastAmount ?? this.forecastAmount,
      deservingProductNumbers:
          deservingProductNumbers ?? this.deservingProductNumbers,
      typesProductsNumbers: typesProductsNumbers ?? this.typesProductsNumbers,
      typesIds: typesIds ?? this.typesIds,
      typesNames: typesNames ?? this.typesNames,
      typesStakes: typesStakes ?? this.typesStakes,
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

  List<ProductForecastPerCollector> getPerCollector() {
    List<ProductForecastPerCollector> productForecastPerCollectorList = [];
    if (collectorsIds != null && collectors.isNotEmpty) {
      for (int i = 0; i < collectorsIds.length; i++) {
        dynamic collectorId = collectorsIds[i];
        dynamic collector = collectors[i];
        dynamic productDeservingProductNumbers = [];
        dynamic productTypesIds = [];
        dynamic productTypesNames = [];
        dynamic productTypesStakes = [];
        dynamic productTypesProductsNumbers = [];
        dynamic productCustomersAccountsIds = [];
        dynamic productCustomersIds = [];
        dynamic productCustomers = [];
        dynamic productCustomersCardsLabels = [];
        dynamic productCustomersCardsTypesNumbers = [];
        dynamic productCustomersCardsSettlementsTotals = [];
        dynamic productCustomersCardsSettlementsAmounts = [];
        // used for controling the loop

        int j = 0;
        while (j != customersAccountsIds.length && i != collectors.length) {
          productDeservingProductNumbers.add(deservingProductNumbers[i]);
          productTypesIds.add(typesIds[i]);
          productTypesNames.add(typesNames[i]);
          productTypesStakes.add(typesStakes[i]);
          productTypesProductsNumbers.add(typesProductsNumbers);
          productCustomersAccountsIds.add(customersAccountsIds[i]);
          productCustomersIds.add(customersIds[i]);
          productCustomers.add(customers[i]);
          productCustomersCardsLabels.add(customersCardsLabels[i]);
          productCustomersCardsTypesNumbers.add(customersCardsTypesNumbers[i]);
          productCustomersCardsSettlementsTotals
              .add(customersCardsSettlementsTotals[i]);
          productCustomersCardsSettlementsAmounts
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
        final productForecastPerCollector = ProductForecastPerCollector(
          productId: productId,
          productName: productName,
          productPurcharsePrice: productPurcharsePrice,
          forecastNumber: forecastNumber,
          forecastAmount: forecastAmount,
          deservingProductNumbers: deservingProductNumbers,
          collectorId: collectorId,
          collector: collector,
          typesIds: productTypesIds,
          typesNames: productTypesNames,
          typesStakes: productTypesStakes,
          typesProductsNumbers: productTypesProductsNumbers,
          customersAccountsIds: productCustomersAccountsIds,
          customersIds: productCustomersIds,
          customers: productCustomers,
          customersCardsLabels: productCustomersCardsLabels,
          customersCardsTypesNumbers: productCustomersCardsTypesNumbers,
          customersCardsSettlementsTotals:
              productCustomersCardsSettlementsTotals,
          customersCardsSettlementsAmounts:
              productCustomersCardsSettlementsAmounts,
        );
        productForecastPerCollectorList.add(
          productForecastPerCollector,
        );
      }
    }
    return productForecastPerCollectorList;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ProductForecastRPC.productId: productId,
      ProductForecastRPC.productName: productName,
      ProductForecastRPC.productPurcharsePrice: productPurcharsePrice,
      ProductForecastRPC.forecastNumber: forecastNumber,
      ProductForecastRPC.forecastAmount: forecastAmount,
      ProductForecastRPC.deservingProductNumbers: deservingProductNumbers,
      ProductForecastRPC.typesProductsNumbers: typesProductsNumbers,
      ProductForecastRPC.typesIds: typesIds,
      ProductForecastRPC.typesNames: typesNames,
      ProductForecastRPC.typesStakes: typesStakes,
      ProductForecastRPC.collectorsIds: collectorsIds,
      ProductForecastRPC.collectors: collectors,
      ProductForecastRPC.customersAccountsIds: customersAccountsIds,
      ProductForecastRPC.customersIds: customersIds,
      ProductForecastRPC.customers: customers,
      ProductForecastRPC.customersCardsLabels: customersCardsLabels,
      ProductForecastRPC.customersCardsTypesNumbers: customersCardsTypesNumbers,
      ProductForecastRPC.customersCardsSettlementsTotals:
          customersCardsSettlementsTotals,
      ProductForecastRPC.customersCardsSettlementsAmounts:
          customersCardsSettlementsAmounts,
    };
  }

  factory ProductForecast.fromMap(Map<String, dynamic> map) {
    // debugPrint(
    //     'Product Forecast Number: ${map[ProductForecastRPC.forecastNumber]}');
    // debugPrint(
    //     'Product Forecast Amount: ${map[ProductForecastRPC.forecastAmount]}');
    return ProductForecast(
      productId: map[ProductForecastRPC.productId] as int,
      productName: map[ProductForecastRPC.productName] as String,
      productPurcharsePrice:
          map[ProductForecastRPC.productPurcharsePrice] as double,
      forecastNumber: map[ProductForecastRPC.forecastNumber],
      forecastAmount: map[ProductForecastRPC.forecastAmount],
      deservingProductNumbers:
          map[ProductForecastRPC.deservingProductNumbers] as dynamic ?? [],
      typesProductsNumbers:
          map[ProductForecastRPC.typesProductsNumbers] as dynamic ?? [],
      typesIds: map[ProductForecastRPC.typesIds] as dynamic ?? [],
      typesNames: map[ProductForecastRPC.typesNames] as dynamic ?? [],
      typesStakes: map[ProductForecastRPC.typesStakes] as dynamic ?? [],
      collectorsIds: map[ProductForecastRPC.collectorsIds] as dynamic ?? [],
      collectors: map[ProductForecastRPC.collectors] as dynamic ?? [],
      customersAccountsIds:
          map[ProductForecastRPC.customersAccountsIds] as dynamic ?? [],
      customersIds: map[ProductForecastRPC.customersIds] as dynamic ?? [],
      customers: map[ProductForecastRPC.customers] as dynamic ?? [],
      customersCardsLabels:
          map[ProductForecastRPC.customersCardsLabels] as dynamic ?? [],
      customersCardsTypesNumbers:
          map[ProductForecastRPC.customersCardsTypesNumbers] as dynamic ?? [],
      customersCardsSettlementsTotals:
          map[ProductForecastRPC.customersCardsSettlementsTotals] as dynamic ??
              [],
      customersCardsSettlementsAmounts:
          map[ProductForecastRPC.customersCardsSettlementsAmounts] as dynamic ??
              [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductForecast.fromJson(String source) =>
      ProductForecast.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductForecast(productId: $productId, productName: $productName, productPurcharsePrice: $productPurcharsePrice, forecastNumber: $forecastNumber, forecastAmount: $forecastAmount, deservingProductNumbers: $deservingProductNumbers, typesProductsNumbers: $typesProductsNumbers, typesIds: $typesIds, typesNames: $typesNames, typesStakes: $typesStakes, collectorsIds: $collectorsIds, collectors: $collectors, customersAccountsIds: $customersAccountsIds, customersIds: $customersIds, customers: $customers, customersCardsLabels: $customersCardsLabels, customersCardsTypesNumbers: $customersCardsTypesNumbers, customersCardsSettlementsTotals: $customersCardsSettlementsTotals, customersCardsSettlementsAmounts: $customersCardsSettlementsAmounts)';
  }

  @override
  bool operator ==(covariant ProductForecast other) {
    if (identical(this, other)) return true;

    return other.productId == productId &&
        other.productName == productName &&
        other.productPurcharsePrice == productPurcharsePrice &&
        other.forecastNumber == forecastNumber &&
        other.forecastAmount == forecastAmount &&
        other.deservingProductNumbers == deservingProductNumbers &&
        listEquals(other.typesProductsNumbers, typesProductsNumbers) &&
        listEquals(other.typesIds, typesIds) &&
        listEquals(other.typesNames, typesNames) &&
        listEquals(other.typesStakes, typesStakes) &&
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
    return productId.hashCode ^
        productName.hashCode ^
        productPurcharsePrice.hashCode ^
        forecastNumber.hashCode ^
        forecastAmount.hashCode ^
        deservingProductNumbers.hashCode ^
        typesProductsNumbers.hashCode ^
        typesIds.hashCode ^
        typesNames.hashCode ^
        typesStakes.hashCode ^
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
