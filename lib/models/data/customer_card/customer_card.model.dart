import 'dart:convert';

import 'package:communitybank/models/tables/customer_card/customer_card_table.model.dart';

class CustomerCard {
  final dynamic id;
  final String label;
  final int typeId;
  final int typeNumber;
  int? customerAccountId;
  final DateTime? satisfiedAt;
  final DateTime? repaidAt;
  final DateTime? transferredAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  CustomerCard({
    this.id,
    required this.label,
    required this.typeId,
    required this.typeNumber,
    this.customerAccountId,
    this.satisfiedAt,
    this.repaidAt,
    this.transferredAt,
    required this.createdAt,
    required this.updatedAt,
  });

  CustomerCard copyWith({
    dynamic id,
    String? label,
    int? typeId,
    int? typeNumber,
    int? customerAccountId,
    DateTime? satisfiedAt,
    DateTime? repaidAt,
    DateTime? transferredAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CustomerCard(
      id: id ?? this.id,
      label: label ?? this.label,
      typeId: typeId ?? this.typeId,
      typeNumber: typeNumber ?? this.typeNumber,
      customerAccountId: customerAccountId ?? this.customerAccountId,
      satisfiedAt: satisfiedAt ?? this.satisfiedAt,
      repaidAt: repaidAt ?? this.repaidAt,
      transferredAt: transferredAt ?? this.transferredAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap({required bool isAdding}) {
    // hide creation and update date for avoiding time hacking
    // by unsetting the system datetime
    final map = {
      CustomerCardTable.label: label,
      CustomerCardTable.typeId: typeId,
      CustomerCardTable.typeNumber: typeNumber,
      CustomerCardTable.customerAccountId: customerAccountId,
      CustomerCardTable.satisfiedAt: satisfiedAt?.toIso8601String(),
      CustomerCardTable.repaidAt: repaidAt?.toIso8601String(),
      CustomerCardTable.transferredAt: transferredAt?.toIso8601String(),
    };

    if (!isAdding) {
      map[CustomerCardTable.createdAt] = createdAt.toIso8601String();
    }

    return map;
  }

  factory CustomerCard.fromMap(Map<String, dynamic> map) {
    return CustomerCard(
      id: map[CustomerCardTable.id],
      label: map[CustomerCardTable.label] ?? '',
      typeId: map[CustomerCardTable.typeId]?.toInt(),
      typeNumber: map[CustomerCardTable.typeNumber],
      customerAccountId: map[CustomerCardTable.customerAccountId]?.toInt(),
      satisfiedAt: map[CustomerCardTable.satisfiedAt] != null
          ? DateTime.parse(map[CustomerCardTable.satisfiedAt]!)
          : null,
      repaidAt: map[CustomerCardTable.repaidAt] != null
          ? DateTime.parse(map[CustomerCardTable.repaidAt]!)
          : null,
      transferredAt: map[CustomerCardTable.transferredAt] != null
          ? DateTime.parse(map[CustomerCardTable.transferredAt]!)
          : null,
      createdAt: DateTime.parse(map[CustomerCardTable.createdAt]),
      updatedAt: DateTime.parse(map[CustomerCardTable.updatedAt]),
    );
  }

  String toJson() => json.encode(toMap(isAdding: true));

  factory CustomerCard.fromJson(String source) =>
      CustomerCard.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomerCard(id: $id, label: $label, typeId: $typeId, typeNumber: $typeNumber, customerAccountId: $customerAccountId,  satisfiedAt: $satisfiedAt, repaidAt: $repaidAt, transferred: $transferredAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomerCard &&
        other.id == id &&
        other.label == label &&
        other.typeId == typeId &&
        other.typeNumber == typeNumber &&
        other.satisfiedAt == satisfiedAt &&
        other.repaidAt == repaidAt &&
        other.transferredAt == transferredAt &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        label.hashCode ^
        typeId.hashCode ^
        typeNumber.hashCode ^
        satisfiedAt.hashCode ^
        repaidAt.hashCode ^
        transferredAt.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
