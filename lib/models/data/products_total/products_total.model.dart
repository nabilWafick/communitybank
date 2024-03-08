// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/products_total/products_total_rpc.model.dart';

class ProductsTotal {
  final int totalNumber;
  ProductsTotal({
    required this.totalNumber,
  });

  ProductsTotal copyWith({
    int? totalNumber,
  }) {
    return ProductsTotal(
      totalNumber: totalNumber ?? this.totalNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ProductsTotalRPC.totalNumber: totalNumber,
    };
  }

  factory ProductsTotal.fromMap(Map<String, dynamic> map) {
    return ProductsTotal(
      totalNumber: map[ProductsTotalRPC.totalNumber] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductsTotal.fromJson(String source) =>
      ProductsTotal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ProductsTotal(totalNumber: $totalNumber)';

  @override
  bool operator ==(covariant ProductsTotal other) {
    if (identical(this, other)) return true;

    return other.totalNumber == totalNumber;
  }

  @override
  int get hashCode => totalNumber.hashCode;
}
