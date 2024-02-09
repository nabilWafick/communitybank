import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:communitybank/models/tables/customer_card/customer_card_table.model.dart';

class CustomerCard {
  final int? id;
  final String label;
  final int typeId;
  final int typeNumber;
  int? customerAccountId;
  final DateTime? satisfiedAt;
  final DateTime? repaidAt;
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
    required this.createdAt,
    required this.updatedAt,
  });

  CustomerCard copyWith({
    int? id,
    String? label,
    int? typeId,
    int? typeNumber,
    int? customerAccountId,
    DateTime? satisfiedAt,
    DateTime? repaidAt,
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
      CustomerCardTable.customerAccountId: customerAccountId,
      CustomerCardTable.satisfiedAt: satisfiedAt?.toIso8601String(),
      CustomerCardTable.repaidAt: repaidAt?.toIso8601String(),
    };

    if (!isAdding) {
      map[CustomerCardTable.createdAt] = createdAt.toIso8601String();
    }

    return map;
  }

  factory CustomerCard.fromMap(Map<String, dynamic> map) {
    return CustomerCard(
      id: map[CustomerCardTable.id]?.toInt(),
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
      createdAt: DateTime.parse(map[CustomerCardTable.createdAt]),
      updatedAt: DateTime.parse(map[CustomerCardTable.updatedAt]),
    );
  }

  String toJson() => json.encode(toMap(isAdding: true));

  factory CustomerCard.fromJson(String source) =>
      CustomerCard.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomerCard(id: $id, label: $label, typeId: $typeId, typeNumber: $typeNumber, customerAccountId: $customerAccountId,  satisfiedAt: $satisfiedAt, repaidAt: $repaidAt, createdAt: $createdAt, updatedAt: $updatedAt)';
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
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

class Test {
  int? id;
  num number;
  DateTime? date;
  Test({
    this.id,
    required this.number,
    this.date,
  });

  Test copyWith({
    ValueGetter<int?>? id,
    num? number,
    ValueGetter<DateTime?>? date,
  }) {
    return Test(
      id: id != null ? id() : this.id,
      number: number ?? this.number,
      date: date != null ? date() : this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'number': number,
      'date': date?.millisecondsSinceEpoch,
    };
  }

  factory Test.fromMap(Map<String, dynamic> map) {
    return Test(
      id: map['id']?.toInt(),
      number: map['number'] ?? 0,
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Test.fromJson(String source) => Test.fromMap(json.decode(source));

  @override
  String toString() => 'Test(id: $id, number: $number, date: $date)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Test &&
        other.id == id &&
        other.number == number &&
        other.date == date;
  }

  @override
  int get hashCode => id.hashCode ^ number.hashCode ^ date.hashCode;
}
