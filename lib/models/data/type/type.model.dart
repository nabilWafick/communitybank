import 'dart:convert';

import 'package:communitybank/models/tables/product/product_table.model.dart';
import 'package:communitybank/models/tables/type/type_table.model.dart';
import 'package:flutter/foundation.dart';
import 'package:communitybank/models/data/product/product.model.dart';

class Type {
  final int? id;
  final String name;
  final double stake;
  final List<Product> products;
  final DateTime createdAt;
  final DateTime updatedAt;
  Type({
    this.id,
    required this.name,
    required this.stake,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
  });

  Type copyWith({
    ValueGetter<int?>? id,
    String? name,
    double? stake,
    List<Product>? products,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Type(
      id: id?.call() ?? this.id,
      name: name ?? this.name,
      stake: stake ?? this.stake,
      products: products ?? this.products,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      //   TypeTable.id: id,
      TypeTable.name: name,
      TypeTable.stake: stake,
      TypeTable.products: products
          .map(
            (product) => {
              ProductTable.id: product.id,
              ProductTable.number: product.number ?? 1,
            },
          )
          .toList(),
      TypeTable.createdAt: createdAt.toIso8601String(),
      TypeTable.updatedAt: updatedAt.toIso8601String(),
    };
  }

  factory Type.fromMap(Map<String, dynamic> map) {
    return Type(
      id: map[TypeTable.id]?.toInt(),
      name: map[TypeTable.name] ?? '',
      stake: map[TypeTable.stake]?.toDouble() ?? 0.0,
      products: List<Product>.from(
          map[TypeTable.products]?.map((x) => Product.fromMap(x))),
      createdAt: DateTime.parse(map[TypeTable.createdAt]),
      updatedAt: DateTime.parse(map[TypeTable.updatedAt]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Type.fromJson(String source) => Type.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Type(id: $id, name: $name, stake: $stake, products: $products, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Type &&
        other.id == id &&
        other.name == name &&
        other.stake == stake &&
        listEquals(other.products, products) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        stake.hashCode ^
        products.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
