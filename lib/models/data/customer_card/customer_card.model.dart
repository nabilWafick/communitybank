import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:communitybank/models/data/type/type.model.dart';
import 'package:communitybank/models/tables/customer_card/customer_card_table.model.dart';

class CustomerCard {
  final int? id;
  final String label;
  final int typeId;
  int? customerAccountId;
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
    int? id,
    String? label,
    int? typeId,
    Type? type,
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
      customerAccountId: customerAccountId ?? this.customerAccountId,
      satisfiedAt: satisfiedAt ?? this.satisfiedAt,
      repaidAt: repaidAt ?? this.repaidAt,
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
    debugPrint('DateTime Now: ${DateTime.now()}');
    debugPrint('Parsing satisfiedAt: ${map[CustomerCardTable.satisfiedAt]}');
    debugPrint('Parsing repaidAt: ${map[CustomerCardTable.repaidAt]}');

    try {
      return CustomerCard(
        id: map[CustomerCardTable.id]?.toInt(),
        label: map[CustomerCardTable.label] ?? '',
        typeId: map[CustomerCardTable.typeId]?.toInt(),
        customerAccountId: map[CustomerCardTable.customerAccountId],
        satisfiedAt: map[CustomerCardTable.satisfiedAt] != null
            ? DateTime.parse(map[CustomerCardTable.satisfiedAt]!)
            : null,
        repaidAt: map[CustomerCardTable.repaidAt] != null
            ? DateTime.parse(map[CustomerCardTable.repaidAt]!)
            : null,
        createdAt: DateTime.parse(map[CustomerCardTable.createdAt]),
        updatedAt: DateTime.parse(map[CustomerCardTable.updatedAt]),
      );
    } catch (error) {
      debugPrint(error.toString());
    }

    return CustomerCard(
      label: 'Undefined',
      typeId: 20,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerCard.fromJson(String source) =>
      CustomerCard.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomerCard(id: $id, label: $label, typeId: $typeId, customerAccountId: $customerAccountId,  satisfiedAt: $satisfiedAt, repaidAt: $repaidAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomerCard &&
        other.id == id &&
        other.label == label &&
        other.typeId == typeId &&
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
