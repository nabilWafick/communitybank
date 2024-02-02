import 'dart:convert';

import 'package:communitybank/models/tables/type/type_table.model.dart';
import 'package:flutter/foundation.dart';

import 'package:communitybank/models/data/product/product.model.dart';

class Type {
  final int? id;
  final String name;
  final double stake;
  final List<dynamic> productsIds;
  final List<dynamic> productsNumber;
  final DateTime createdAt;
  final DateTime updatedAt;
  Type({
    this.id,
    required this.name,
    required this.stake,
    required this.productsIds,
    required this.productsNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  Type copyWith({
    int? id,
    String? name,
    double? stake,
    List<Product>? products,
    List<int>? productsIds,
    List<int>? productsNumber,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Type(
      id: id ?? this.id,
      name: name ?? this.name,
      stake: stake ?? this.stake,
      productsIds: productsIds ?? this.productsIds,
      productsNumber: productsNumber ?? this.productsNumber,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap({required bool isAdding}) {
    // hide creation and update date for avoiding time hacking
    // by unsetting the system datetime
    final map = {
      TypeTable.name: name,
      TypeTable.stake: stake,
      TypeTable.productsIds: productsIds,
      TypeTable.productsNumbers: productsNumber,
    };
    if (!isAdding) {
      map[TypeTable.createdAt] = createdAt.toIso8601String();
    }

    return map;
  }

  factory Type.fromMap(Map<String, dynamic> map) {
    return Type(
      id: map[TypeTable.id]?.toInt(),
      name: map[TypeTable.name] ?? '',
      stake: map[TypeTable.stake]?.toDouble() ?? 0.0,
      productsIds: List<dynamic>.from(map[TypeTable.productsIds]),
      productsNumber: List<dynamic>.from(map[TypeTable.productsNumbers]),
      createdAt: DateTime.parse(map[TypeTable.createdAt]),
      updatedAt: DateTime.parse(map[TypeTable.updatedAt]),
    );
  }

  String toJson() => json.encode(toMap(
        isAdding: true,
      ));

  factory Type.fromJson(String source) => Type.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Type(id: $id, name: $name, stake: $stake, productsIds: $productsIds, productsNumber: $productsNumber, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Type &&
        other.id == id &&
        other.name == name &&
        other.stake == stake &&
        listEquals(other.productsIds, productsIds) &&
        listEquals(other.productsNumber, productsNumber) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        stake.hashCode ^
        productsIds.hashCode ^
        productsNumber.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
