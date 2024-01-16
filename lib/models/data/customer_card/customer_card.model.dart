import 'dart:convert';

import 'package:communitybank/models/tables/customer_card/customer_card_table.model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class CustomerCard {
  final int? id;
  final String label;
  final int typeId;
  final int? customerAccountId;
  final DateTime? satisfiedAt;
  final DateTime? repaidAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  CustomerCard({
    this.id,
    required this.label,
    required this.typeId,
    this.customerAccountId,
    this.satisfiedAt,
    this.repaidAt,
    required this.createdAt,
    required this.updatedAt,
  });

  CustomerCard copyWith({
    ValueGetter<int?>? id,
    String? label,
    int? typeId,
    ValueGetter<int?>? customerAccountId,
    ValueGetter<DateTime?>? satisfiedAt,
    ValueGetter<DateTime?>? repaidAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CustomerCard(
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
      CustomerCardTable.label: label,
      CustomerCardTable.typeId: typeId,
      CustomerCardTable.customerAccountId: customerAccountId,
      CustomerCardTable.satisfiedAt: satisfiedAt?.toIso8601String(),
      CustomerCardTable.repaidAt: repaidAt?.toIso8601String(),
      CustomerCardTable.createdAt: createdAt.toIso8601String(),
      CustomerCardTable.updatedAt: updatedAt.toIso8601String(),
    };
  }

  factory CustomerCard.fromMap(Map<String, dynamic> map) {
    return CustomerCard(
      id: map[CustomerCardTable.id]?.toInt(),
      label: map[CustomerCardTable.label] ?? '',
      typeId: map[CustomerCardTable.typeId]?.toInt() ?? 0,
      customerAccountId: map[CustomerCardTable.customerAccountId]?.toInt(),
      satisfiedAt: map[CustomerCardTable.satisfiedAt] != null
          ? DateTime.parse(map[CustomerCardTable.satisfiedAt])
          : null,
      repaidAt: map[CustomerCardTable.repaidAt] != null
          ? DateTime.parse(map[CustomerCardTable.repaidAt])
          : null,
      createdAt: DateTime.parse(map[CustomerCardTable.createdAt]),
      updatedAt: DateTime.parse(map[CustomerCardTable.updatedAt]),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerCard.fromJson(String source) =>
      CustomerCard.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomerCard(id: $id, label: $label, typeId: $typeId, customerAccountId: $customerAccountId, satisfiedAt: $satisfiedAt, repaidAt: $repaidAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomerCard &&
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
