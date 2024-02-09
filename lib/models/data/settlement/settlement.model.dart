import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:communitybank/models/tables/settlement/settlement_table.model.dart';

class Settlement {
  final int? id;
  final int number;
  final int cardId;
  final int agentId;
  final int collectionId;
  final DateTime collectedAt;
  final bool isValiated;
  final DateTime createdAt;
  final DateTime updatedAt;
  Settlement({
    this.id,
    required this.number,
    required this.cardId,
    required this.agentId,
    required this.collectionId,
    required this.collectedAt,
    required this.createdAt,
    required this.isValiated,
    required this.updatedAt,
  });

  Settlement copyWith({
    ValueGetter<int?>? id,
    int? number,
    int? cardId,
    int? agentId,
    int? collectionId,
    DateTime? collectedAt,
    bool? isValidated,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Settlement(
      id: id != null ? id() : this.id,
      number: number ?? this.number,
      cardId: cardId ?? this.cardId,
      agentId: agentId ?? this.agentId,
      collectionId: collectionId ?? this.collectionId,
      collectedAt: collectedAt ?? this.collectedAt,
      isValiated: isValiated ?? isValiated,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap({required bool isAdding}) {
    // hide creation and update date for avoiding time hacking
    // by unsetting the system datetime
    final map = {
      SettlementTable.number: number,
      SettlementTable.cardId: cardId,
      SettlementTable.agentId: agentId,
      SettlementTable.collectionId: collectionId,
      SettlementTable.collectedAt: collectedAt.toIso8601String(),
      SettlementTable.isValidated: isValiated,
    };
    if (!isAdding) {
      map[SettlementTable.createdAt] = createdAt.toIso8601String();
    }

    return map;
  }

  factory Settlement.fromMap(Map<String, dynamic> map) {
    return Settlement(
      id: map[SettlementTable.id]?.toInt(),
      number: map[SettlementTable.number]?.toInt() ?? 0,
      cardId: map[SettlementTable.cardId]?.toInt() ?? 0,
      agentId: map[SettlementTable.agentId]?.toInt() ?? 0,
      collectionId: map[SettlementTable.collectionId]?.toInt() ?? 0,
      collectedAt: DateTime.parse(map[SettlementTable.collectedAt]),
      isValiated: map[SettlementTable.isValidated] ?? false,
      createdAt: DateTime.parse(map[SettlementTable.createdAt]),
      updatedAt: DateTime.parse(map[SettlementTable.updatedAt]),
    );
  }

  String toJson() => json.encode(
        toMap(
          isAdding: true,
        ),
      );

  factory Settlement.fromJson(String source) =>
      Settlement.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Settlement(id: $id, number: $number, cardId: $cardId, agentId: $agentId, collectionId: $collectionId, collectedAt:$collectedAt, isValidated: $isValiated, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Settlement &&
        other.id == id &&
        other.number == number &&
        other.cardId == cardId &&
        other.agentId == agentId &&
        other.collectionId == collectionId &&
        other.collectedAt == collectedAt &&
        other.isValiated == isValiated &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        number.hashCode ^
        cardId.hashCode ^
        agentId.hashCode ^
        collectionId.hashCode ^
        isValiated.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
