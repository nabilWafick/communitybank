// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/collections_totals/collections_totals_rpc.model.dart';

class CollectionsTotals {
  final int totalNumber;
  final double totalAmount;
  CollectionsTotals({
    required this.totalNumber,
    required this.totalAmount,
  });

  CollectionsTotals copyWith({
    int? totalNumber,
    double? totalAmount,
  }) {
    return CollectionsTotals(
      totalNumber: totalNumber ?? this.totalNumber,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CollectionsTotalsRPC.totalNumber: totalNumber,
      CollectionsTotalsRPC.totalAmount: totalAmount,
    };
  }

  factory CollectionsTotals.fromMap(Map<String, dynamic> map) {
    return CollectionsTotals(
      totalNumber: map[CollectionsTotalsRPC.totalNumber] as int,
      totalAmount: map[CollectionsTotalsRPC.totalAmount] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory CollectionsTotals.fromJson(String source) =>
      CollectionsTotals.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CollectionsTotals(totalNumber: $totalNumber, totalAmount: $totalAmount)';

  @override
  bool operator ==(covariant CollectionsTotals other) {
    if (identical(this, other)) return true;

    return other.totalNumber == totalNumber && other.totalAmount == totalAmount;
  }

  @override
  int get hashCode => totalNumber.hashCode ^ totalAmount.hashCode;
}
