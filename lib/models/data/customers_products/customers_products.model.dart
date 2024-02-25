// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/customers_products/customers_products_rpc.model.dart';
import 'package:flutter/foundation.dart';

class CustomersProducts {
  int productId;
  String productName;
  List<dynamic> customersAccountsIds;
  List<dynamic> customersIds;
  List<String> customersNames;
  List<String> customersFirstnames;
  CustomersProducts({
    required this.productId,
    required this.productName,
    required this.customersAccountsIds,
    required this.customersIds,
    required this.customersNames,
    required this.customersFirstnames,
  });

  CustomersProducts copyWith({
    int? productId,
    String? productName,
    List<dynamic>? customersAccountsIds,
    List<dynamic>? customersIds,
    List<String>? customersNames,
    List<String>? customersFirstnames,
  }) {
    return CustomersProducts(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      customersAccountsIds: customersAccountsIds ?? this.customersAccountsIds,
      customersIds: customersIds ?? this.customersIds,
      customersNames: customersNames ?? this.customersNames,
      customersFirstnames: customersFirstnames ?? this.customersFirstnames,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CustomersProductsRPC.productId: productId,
      CustomersProductsRPC.productName: productName,
      CustomersProductsRPC.customersAccountsIds: customersAccountsIds,
      CustomersProductsRPC.customersIds: customersIds,
      CustomersProductsRPC.customersNames: customersNames,
      CustomersProductsRPC.customersFirstnames: customersFirstnames,
    };
  }

  factory CustomersProducts.fromMap(Map<String, dynamic> map) {
    return CustomersProducts(
      productId: map[CustomersProductsRPC.productId] as int,
      productName: map[CustomersProductsRPC.productName] as String,
      customersAccountsIds: List<dynamic>.from(
          (map[CustomersProductsRPC.customersAccountsIds]) as List<dynamic>),
      customersIds: List<dynamic>.from(
          (map[CustomersProductsRPC.customersIds]) as List<dynamic>),
      customersNames: List<String>.from(
          (map[CustomersProductsRPC.customersNames]) as List<String>),
      customersFirstnames: List<String>.from(
          (map[CustomersProductsRPC.customersFirstnames]) as List<String>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomersProducts.fromJson(String source) =>
      CustomersProducts.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomersProducts(productId: $productId, productName: $productName, customersAccountsIds: $customersAccountsIds, customersIds: $customersIds, customersNames: $customersNames, customersFirstnames: $customersFirstnames)';
  }

  @override
  bool operator ==(covariant CustomersProducts other) {
    if (identical(this, other)) return true;

    return other.productId == productId &&
        other.productName == productName &&
        listEquals(other.customersAccountsIds, customersAccountsIds) &&
        listEquals(other.customersIds, customersIds) &&
        listEquals(other.customersNames, customersNames) &&
        listEquals(other.customersFirstnames, customersFirstnames);
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        productName.hashCode ^
        customersAccountsIds.hashCode ^
        customersIds.hashCode ^
        customersNames.hashCode ^
        customersFirstnames.hashCode;
  }
}
