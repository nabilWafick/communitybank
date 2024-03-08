// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/collectors_monthly_collections/collectors_monthly_collections_rpc.model.dart';
import 'package:flutter/foundation.dart';

class CollectorsMonthlyCollections {
  final String day;
  final DateTime collectionDate;
  final List<dynamic> collectorsIds;
  final List<dynamic> collectors;
  final List<dynamic> collectionsAmounts;
  CollectorsMonthlyCollections({
    required this.day,
    required this.collectionDate,
    required this.collectorsIds,
    required this.collectors,
    required this.collectionsAmounts,
  });

  CollectorsMonthlyCollections copyWith({
    String? day,
    DateTime? collectionDate,
    List<dynamic>? collectorsIds,
    List<dynamic>? collectors,
    List<dynamic>? collectionsAmounts,
  }) {
    return CollectorsMonthlyCollections(
      day: day ?? this.day,
      collectionDate: collectionDate ?? this.collectionDate,
      collectorsIds: collectorsIds ?? this.collectorsIds,
      collectors: collectors ?? this.collectors,
      collectionsAmounts: collectionsAmounts ?? this.collectionsAmounts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CollectorsMonthlyCollectionsRPC.day: day,
      CollectorsMonthlyCollectionsRPC.collectionDate:
          collectionDate.toIso8601String(),
      CollectorsMonthlyCollectionsRPC.collectorsIds: collectorsIds,
      CollectorsMonthlyCollectionsRPC.collectors: collectors,
      CollectorsMonthlyCollectionsRPC.collectionsAmounts: collectionsAmounts,
    };
  }

  factory CollectorsMonthlyCollections.fromMap(Map<String, dynamic> map) {
    return CollectorsMonthlyCollections(
      day: map[CollectorsMonthlyCollectionsRPC.day] as String,
      collectionDate:
          DateTime.parse(map[CollectorsMonthlyCollectionsRPC.collectionDate]),
      collectorsIds: List<dynamic>.from(
          map[CollectorsMonthlyCollectionsRPC.collectorsIds] as List<dynamic>),
      collectors: List<dynamic>.from(
          map[CollectorsMonthlyCollectionsRPC.collectors] as List<dynamic>),
      collectionsAmounts: List<dynamic>.from(
          map[CollectorsMonthlyCollectionsRPC.collectionsAmounts]
              as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CollectorsMonthlyCollections.fromJson(String source) =>
      CollectorsMonthlyCollections.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CollectorsMonthlyCollections(day: $day, collectionDate: $collectionDate, collectorsIds: $collectorsIds, collectors: $collectors, collectionsAmounts: $collectionsAmounts)';
  }

  @override
  bool operator ==(covariant CollectorsMonthlyCollections other) {
    if (identical(this, other)) return true;

    return other.day == day &&
        other.collectionDate == collectionDate &&
        listEquals(other.collectorsIds, collectorsIds) &&
        listEquals(other.collectors, collectors) &&
        listEquals(other.collectionsAmounts, collectionsAmounts);
  }

  @override
  int get hashCode {
    return day.hashCode ^
        collectionDate.hashCode ^
        collectorsIds.hashCode ^
        collectors.hashCode ^
        collectionsAmounts.hashCode;
  }
}
