import 'dart:convert';

import 'package:communitybank/models/tables/customers_category/customers_category_table.model.dart';
import 'package:flutter/widgets.dart';

class CustomerCategory {
  final int? id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  CustomerCategory({
    this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  CustomerCategory copyWith({
    ValueGetter<int?>? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CustomerCategory(
      id: id?.call() ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      //  CustomerCategoryTable.id: id,
      CustomerCategoryTable.name: name,
      CustomerCategoryTable.createdAt: createdAt.toIso8601String(),
      CustomerCategoryTable.updatedAt: updatedAt.toIso8601String(),
    };
  }

  factory CustomerCategory.fromMap(Map<String, dynamic> map) {
    return CustomerCategory(
      id: map[CustomerCategoryTable.id]?.toInt(),
      name: map[CustomerCategoryTable.name] ?? '',
      createdAt: DateTime.parse(map[CustomerCategoryTable.createdAt]),
      updatedAt: DateTime.parse(map[CustomerCategoryTable.updatedAt]),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerCategory.fromJson(String source) =>
      CustomerCategory.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomerCategory(id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomerCategory &&
        other.id == id &&
        other.name == name &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
