import 'dart:convert';

import 'package:communitybank/models/tables/collection/collection_table.model.dart';
import 'package:flutter/widgets.dart';

class Collection {
  final int? id;
  final int collectorId;
  final double amount;
  final double rest;
  final double agentId;
  final DateTime collectedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  Collection({
    this.id,
    required this.collectorId,
    required this.amount,
    required this.rest,
    required this.agentId,
    required this.collectedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  Collection copyWith({
    ValueGetter<int?>? id,
    int? collectorId,
    double? amount,
    double? rest,
    double? agentId,
    DateTime? collectedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Collection(
      id: id != null ? id() : this.id,
      collectorId: collectorId ?? this.collectorId,
      amount: amount ?? this.amount,
      rest: rest ?? this.rest,
      agentId: agentId ?? this.agentId,
      collectedAt: collectedAt ?? this.collectedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap({required bool isAdding}) {
    final map = {
      CollectionTable.collectorId: collectorId,
      CollectionTable.amount: amount,
      CollectionTable.rest: rest,
      CollectionTable.agentId: agentId,
      CollectionTable.collectedAt: collectedAt.toIso8601String(),
    };

    if (!isAdding) {
      map[CollectionTable.createdAt] = collectedAt.toIso8601String();
    }
    return map;
  }

  factory Collection.fromMap(Map<String, dynamic> map) {
    return Collection(
      id: map['id']?.toInt(),
      collectorId: map['collectorId']?.toInt() ?? 0,
      amount: map['amount']?.toDouble() ?? 0.0,
      rest: map['rest']?.toDouble() ?? 0.0,
      agentId: map['agentId']?.toDouble() ?? 0.0,
      collectedAt: DateTime.parse(map['collectedAt']),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(
        toMap(
          isAdding: true,
        ),
      );

  factory Collection.fromJson(String source) =>
      Collection.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Collection(id: $id, collectorId: $collectorId, amount: $amount, rest: $rest, agentId: $agentId, collectedAt: $collectedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Collection &&
        other.id == id &&
        other.collectorId == collectorId &&
        other.amount == amount &&
        other.rest == rest &&
        other.agentId == agentId &&
        other.collectedAt == collectedAt &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        collectorId.hashCode ^
        amount.hashCode ^
        rest.hashCode ^
        agentId.hashCode ^
        collectedAt.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
