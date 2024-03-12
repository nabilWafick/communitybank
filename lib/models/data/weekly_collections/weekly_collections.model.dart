// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/weekly_collections/weekly_collections_rpc.model.dart';

class WeeklyCollections {
  final String day;
  final DateTime collectionDate;
  final dynamic collectionAmount;
  WeeklyCollections({
    required this.day,
    required this.collectionDate,
    required this.collectionAmount,
  });

  WeeklyCollections copyWith({
    String? day,
    DateTime? collectionDate,
    dynamic collectionAmount,
  }) {
    return WeeklyCollections(
      day: day ?? this.day,
      collectionDate: collectionDate ?? this.collectionDate,
      collectionAmount: collectionAmount ?? this.collectionAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      WeeklyCollectionsRPC.day: day,
      WeeklyCollectionsRPC.collectionDate:
          collectionDate.millisecondsSinceEpoch,
      WeeklyCollectionsRPC.collectionAmount: collectionAmount,
    };
  }

  factory WeeklyCollections.fromMap(Map<String, dynamic> map) {
    return WeeklyCollections(
      day: map[WeeklyCollectionsRPC.day] as String,
      collectionDate: DateTime.parse(map[WeeklyCollectionsRPC.collectionDate]),
      collectionAmount: map[WeeklyCollectionsRPC.collectionAmount] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeeklyCollections.fromJson(String source) =>
      WeeklyCollections.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'WeeklyCollections(day: $day, collectionDate: $collectionDate, collectionAmount: $collectionAmount)';

  @override
  bool operator ==(covariant WeeklyCollections other) {
    if (identical(this, other)) return true;

    return other.day == day &&
        other.collectionDate == collectionDate &&
        other.collectionAmount == collectionAmount;
  }

  @override
  int get hashCode =>
      day.hashCode ^ collectionDate.hashCode ^ collectionAmount.hashCode;
}
