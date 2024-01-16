import 'dart:convert';

import 'package:communitybank/models/tables/card/card_table.model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class Card {
  final int? id;
  final String label;
  final int typeId;
  final int? customerAccountId;
  final DateTime? satisfiedAt;
  final DateTime? repaidAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  Card({
    this.id,
    required this.label,
    required this.typeId,
    this.customerAccountId,
    this.satisfiedAt,
    this.repaidAt,
    required this.createdAt,
    required this.updatedAt,
  });

  Card copyWith({
    ValueGetter<int?>? id,
    String? label,
    int? typeId,
    ValueGetter<int?>? customerAccountId,
    ValueGetter<DateTime?>? satisfiedAt,
    ValueGetter<DateTime?>? repaidAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Card(
      id: id != null ? id() : this.id,
      label: label ?? this.label,
      typeId: typeId ?? this.typeId,
      customerAccountId: customerAccountId != null
          ? customerAccountId()
          : this.customerAccountId,
      satisfiedAt: satisfiedAt != null ? satisfiedAt() : this.satisfiedAt,
      repaidAt: repaidAt != null ? repaidAt() : this.repaidAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      CardTable.label: label,
      CardTable.typeId: typeId,
      CardTable.customerAccountId: customerAccountId,
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
      typeId: map[CardTable.typeId]?.toInt() ?? 0,
      customerAccountId: map[CardTable.customerAccountId]?.toInt(),
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
    return 'Card(id: $id, label: $label, typeId: $typeId, customerAccountId: $customerAccountId, satisfiedAt: $satisfiedAt, repaidAt: $repaidAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Card &&
        other.id == id &&
        other.label == label &&
        other.typeId == typeId &&
        other.customerAccountId == customerAccountId &&
        other.satisfiedAt == satisfiedAt &&
        other.repaidAt == repaidAt &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        label.hashCode ^
        typeId.hashCode ^
        customerAccountId.hashCode ^
        satisfiedAt.hashCode ^
        repaidAt.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
