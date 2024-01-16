import 'dart:convert';

import 'package:communitybank/models/tables/card/card_table.model.dart';
import 'package:flutter/foundation.dart';

import 'package:communitybank/models/data/settlement/settlement.model.dart';
import 'package:communitybank/models/data/type/type.model.dart';

class Card {
  final int? id;
  final String label;
  Type type;
  final int typeId;
  List<Settlement> settlements;
  final List<int>? settelementsIds;
  final DateTime? satisfiedAt;
  final DateTime? repaidAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  Card({
    this.id,
    required this.label,
    required this.type,
    required this.typeId,
    required this.settlements,
    this.settelementsIds,
    this.satisfiedAt,
    this.repaidAt,
    required this.createdAt,
    required this.updatedAt,
  });

  Card copyWith({
    int? id,
    String? label,
    Type? type,
    int? typeId,
    List<Settlement>? settlements,
    ValueGetter<List<int>?>? settelementsIds,
    ValueGetter<DateTime?>? satisfiedAt,
    ValueGetter<DateTime?>? repaidAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Card(
      id: id ?? this.id,
      label: label ?? this.label,
      type: type ?? this.type,
      typeId: typeId ?? this.typeId,
      settlements: settlements ?? this.settlements,
      settelementsIds:
          settelementsIds != null ? settelementsIds() : this.settelementsIds,
      satisfiedAt: satisfiedAt != null ? satisfiedAt() : this.satisfiedAt,
      repaidAt: repaidAt != null ? repaidAt() : this.repaidAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      CardTable.label: label,
      CardTable.typeId: type.id,
      CardTable.settelementsIds:
          settlements.map((settlement) => settlement.id).toList(),
      CardTable.satisfiedAt: satisfiedAt?.toIso8601String(),
      CardTable.repaidAt: repaidAt?.toIso8601String(),
      CardTable.createdAt: createdAt.toIso8601String(),
      CardTable.updatedAt: updatedAt.toIso8601String(),
    };
  }

  factory Card.fromMap(Map<String, dynamic> map) {
    return Card(
      id: map[CardTable.id]?.toInt(),
      label: map[CardTable.label] ?? '',
      type: Type(
        name: '',
        stake: 1.0,
        products: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      typeId: map[CardTable.typeId]?.toInt() ?? 0,
      settlements: [],
      settelementsIds: List<int>.from(map[CardTable.settelementsIds]),
      satisfiedAt: map[CardTable.satisfiedAt] != null
          ? DateTime.parse(map[CardTable.satisfiedAt])
          : null,
      repaidAt: map[CardTable.repaidAt] != null
          ? DateTime.parse(map[CardTable.repaidAt])
          : null,
      createdAt: DateTime.parse(map[CardTable.createdAt]),
      updatedAt: DateTime.parse(map[CardTable.updatedAt]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Card.fromJson(String source) => Card.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Card(id: $id, label: $label, type: $type, typeId: $typeId, settlements: $settlements, settelementsIds: $settelementsIds, satisfiedAt: $satisfiedAt, repaidAt: $repaidAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Card &&
        other.id == id &&
        other.label == label &&
        other.type == type &&
        other.typeId == typeId &&
        listEquals(other.settlements, settlements) &&
        listEquals(other.settelementsIds, settelementsIds) &&
        other.satisfiedAt == satisfiedAt &&
        other.repaidAt == repaidAt &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        label.hashCode ^
        type.hashCode ^
        typeId.hashCode ^
        settlements.hashCode ^
        settelementsIds.hashCode ^
        satisfiedAt.hashCode ^
        repaidAt.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
