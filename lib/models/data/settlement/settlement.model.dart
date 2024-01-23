import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:communitybank/models/tables/settlement/settlement_table.model.dart';

class Settlement {
  final int? id;
  final int number;
  final int cardId;
  final int agentId;
  final DateTime collectedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  Settlement({
    this.id,
    required this.number,
    required this.cardId,
    required this.agentId,
    required this.collectedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  Settlement copyWith({
    ValueGetter<int?>? id,
    int? number,
    int? cardId,
    int? agentId,
    DateTime? collectedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Settlement(
      id: id != null ? id() : this.id,
      number: number ?? this.number,
      cardId: cardId ?? this.cardId,
      agentId: agentId ?? this.agentId,
      collectedAt: collectedAt ?? this.collectedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      SettlementTable.number: number,
      SettlementTable.cardId: cardId,
      SettlementTable.agentId: agentId,
      SettlementTable.collecteAt: collectedAt.toIso8601String(),
      SettlementTable.createdAt: createdAt.toIso8601String(),
      SettlementTable.updatedAt: updatedAt.toIso8601String(),
    };
  }

  factory Settlement.fromMap(Map<String, dynamic> map) {
    return Settlement(
      id: map[SettlementTable.id]?.toInt(),
      number: map[SettlementTable.number]?.toInt() ?? 0,
      cardId: map[SettlementTable.cardId]?.toInt() ?? 0,
      agentId: map[SettlementTable.agentId]?.toInt() ?? 0,
      collectedAt: DateTime.parse(map[SettlementTable.collecteAt]),
      createdAt: DateTime.parse(map[SettlementTable.createdAt]),
      updatedAt: DateTime.parse(map[SettlementTable.updatedAt]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Settlement.fromJson(String source) =>
      Settlement.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Settlement(id: $id, number: $number, cardId: $cardId, agentId: $agentId, collectedAt:$collectedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Settlement &&
        other.id == id &&
        other.number == number &&
        other.cardId == cardId &&
        other.agentId == agentId &&
        other.collectedAt == collectedAt &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        number.hashCode ^
        cardId.hashCode ^
        agentId.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
