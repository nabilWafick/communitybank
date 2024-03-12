// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/monthly_collections/monthly_collections_rpc.model.dart';

class MonthlyCollections {
  final String day;
  final DateTime collectionDate;
  final dynamic collectionAmount;
  MonthlyCollections({
    required this.day,
    required this.collectionDate,
    required this.collectionAmount,
  });

  MonthlyCollections copyWith({
    String? day,
    DateTime? collectionDate,
    dynamic collectionAmount,
  }) {
    return MonthlyCollections(
      day: day ?? this.day,
      collectionDate: collectionDate ?? this.collectionDate,
      collectionAmount: collectionAmount ?? this.collectionAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      MonthlyCollectionsRPC.day: day,
      MonthlyCollectionsRPC.collectionDate: collectionDate.toIso8601String(),
      MonthlyCollectionsRPC.collectionAmount: collectionAmount,
    };
  }

  factory MonthlyCollections.fromMap(Map<String, dynamic> map) {
    return MonthlyCollections(
      day: map[MonthlyCollectionsRPC.day] as String,
      collectionDate: DateTime.parse(map[MonthlyCollectionsRPC.collectionDate]),
      collectionAmount: map[MonthlyCollectionsRPC.collectionAmount] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory MonthlyCollections.fromJson(String source) =>
      MonthlyCollections.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MonthlyCollections(day: $day, collectionDate: $collectionDate, collectionAmount: $collectionAmount)';

  @override
  bool operator ==(covariant MonthlyCollections other) {
    if (identical(this, other)) return true;

    return other.day == day &&
        other.collectionDate == collectionDate &&
        other.collectionAmount == collectionAmount;
  }

  @override
  int get hashCode =>
      day.hashCode ^ collectionDate.hashCode ^ collectionAmount.hashCode;
}
