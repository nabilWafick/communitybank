// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/yearly_collections/yearly_collections_rpc.model.dart';

class YearlyCollections {
  final String month;
  final double collectionAmount;
  YearlyCollections({
    required this.month,
    required this.collectionAmount,
  });

  YearlyCollections copyWith({
    String? month,
    double? collectionAmount,
  }) {
    return YearlyCollections(
      month: month ?? this.month,
      collectionAmount: collectionAmount ?? this.collectionAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      YearlyCollectionsRPC.month: month,
      YearlyCollectionsRPC.collectionAmount: collectionAmount,
    };
  }

  factory YearlyCollections.fromMap(Map<String, dynamic> map) {
    return YearlyCollections(
      month: map[YearlyCollectionsRPC.month] as String,
      collectionAmount: map[YearlyCollectionsRPC.collectionAmount] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory YearlyCollections.fromJson(String source) =>
      YearlyCollections.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'YearlyCollections(month: $month, collectionAmount: $collectionAmount)';

  @override
  bool operator ==(covariant YearlyCollections other) {
    if (identical(this, other)) return true;

    return other.month == month && other.collectionAmount == collectionAmount;
  }

  @override
  int get hashCode => month.hashCode ^ collectionAmount.hashCode;
}
