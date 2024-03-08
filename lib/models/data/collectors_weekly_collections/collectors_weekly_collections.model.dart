// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/collectors_weekly_collections/collectors_weekly_collections_rpc.model.dart';
import 'package:flutter/foundation.dart';

class CollectorsWeeklyCollections {
  final String day;
  final DateTime collectionDate;
  final List<dynamic> collectorsIds;
  final List<dynamic> collectors;
  final List<dynamic> collectionsAmounts;
  CollectorsWeeklyCollections({
    required this.day,
    required this.collectionDate,
    required this.collectorsIds,
    required this.collectors,
    required this.collectionsAmounts,
  });

  CollectorsWeeklyCollections copyWith({
    String? day,
    DateTime? collectionDate,
    List<dynamic>? collectorsIds,
    List<dynamic>? collectors,
    List<dynamic>? collectionsAmounts,
  }) {
    return CollectorsWeeklyCollections(
      day: day ?? this.day,
      collectionDate: collectionDate ?? this.collectionDate,
      collectorsIds: collectorsIds ?? this.collectorsIds,
      collectors: collectors ?? this.collectors,
      collectionsAmounts: collectionsAmounts ?? this.collectionsAmounts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CollectorsWeeklyCollectionsRPC.day: day,
      CollectorsWeeklyCollectionsRPC.collectionDate:
          collectionDate.toIso8601String(),
      CollectorsWeeklyCollectionsRPC.collectorsIds: collectorsIds,
      CollectorsWeeklyCollectionsRPC.collectors: collectors,
      CollectorsWeeklyCollectionsRPC.collectionsAmounts: collectionsAmounts,
    };
  }

  factory CollectorsWeeklyCollections.fromMap(Map<String, dynamic> map) {
    return CollectorsWeeklyCollections(
      day: map[CollectorsWeeklyCollectionsRPC.day] as String,
      collectionDate:
          DateTime.parse(map[CollectorsWeeklyCollectionsRPC.collectionDate]),
      collectorsIds: List<dynamic>.from(
          map[CollectorsWeeklyCollectionsRPC.collectorsIds] as List<dynamic>),
      collectors: List<dynamic>.from(
          map[CollectorsWeeklyCollectionsRPC.collectors] as List<dynamic>),
      collectionsAmounts: List<dynamic>.from(
          map[CollectorsWeeklyCollectionsRPC.collectionsAmounts]
              as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CollectorsWeeklyCollections.fromJson(String source) =>
      CollectorsWeeklyCollections.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CollectorsWeeklyCollections(day: $day, collectionDate: $collectionDate, collectorsIds: $collectorsIds, collectors: $collectors, collectionsAmounts: $collectionsAmounts)';
  }

  @override
  bool operator ==(covariant CollectorsWeeklyCollections other) {
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
