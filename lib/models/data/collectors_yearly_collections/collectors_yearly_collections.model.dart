// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/collectors_yearly_collections/collectors_yearly_collections_rpc.model.dart';
import 'package:flutter/foundation.dart';

class CollectorsYearlyCollections {
  final String month;
  final List<dynamic> collectorsIds;
  final List<dynamic> collectors;
  final List<dynamic> collectionsAmounts;
  CollectorsYearlyCollections({
    required this.month,
    required this.collectorsIds,
    required this.collectors,
    required this.collectionsAmounts,
  });

  CollectorsYearlyCollections copyWith({
    String? month,
    List<dynamic>? collectorsIds,
    List<dynamic>? collectors,
    List<dynamic>? collectionsAmounts,
  }) {
    return CollectorsYearlyCollections(
      month: month ?? this.month,
      collectorsIds: collectorsIds ?? this.collectorsIds,
      collectors: collectors ?? this.collectors,
      collectionsAmounts: collectionsAmounts ?? this.collectionsAmounts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CollectorsYearlyCollectionsRPC.month: month,
      CollectorsYearlyCollectionsRPC.collectorsIds: collectorsIds,
      CollectorsYearlyCollectionsRPC.collectors: collectors,
      CollectorsYearlyCollectionsRPC.collectionsAmounts: collectionsAmounts,
    };
  }

  factory CollectorsYearlyCollections.fromMap(Map<String, dynamic> map) {
    return CollectorsYearlyCollections(
      month: map[CollectorsYearlyCollectionsRPC.month] as String,
      collectorsIds: List<dynamic>.from(
          map[CollectorsYearlyCollectionsRPC.collectorsIds] as List<dynamic>),
      collectors: List<dynamic>.from(
          map[CollectorsYearlyCollectionsRPC.collectors] as List<dynamic>),
      collectionsAmounts: List<dynamic>.from(
          map[CollectorsYearlyCollectionsRPC.collectionsAmounts]
              as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CollectorsYearlyCollections.fromJson(String source) =>
      CollectorsYearlyCollections.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CollectorsYearlyCollections(month: $month, collectorsIds: $collectorsIds, collectors: $collectors, collectionsAmounts: $collectionsAmounts)';
  }

  @override
  bool operator ==(covariant CollectorsYearlyCollections other) {
    if (identical(this, other)) return true;

    return other.month == month &&
        listEquals(other.collectorsIds, collectorsIds) &&
        listEquals(other.collectors, collectors) &&
        listEquals(other.collectionsAmounts, collectionsAmounts);
  }

  @override
  int get hashCode {
    return month.hashCode ^
        collectorsIds.hashCode ^
        collectors.hashCode ^
        collectionsAmounts.hashCode;
  }
}
