import 'dart:convert';

import 'package:communitybank/models/tables/product/product_table.model.dart';

class Product {
  final int? id;
  final String name;
  final double purchasePrice;
  final String? picture;
  int? number;
  final DateTime createdAt;
  final DateTime updatedAt;
  Product({
    this.id,
    required this.name,
    required this.purchasePrice,
    this.picture,
    this.number,
    required this.createdAt,
    required this.updatedAt,
  });

  Product copyWith({
    int? id,
    String? name,
    double? purchasePrice,
    String? picture,
    int? number,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      picture: picture ?? this.picture,
      number: number ?? this.number,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap({required bool isAdding}) {
    // hide creation and update date for avoiding time hacking
    // by unsetting the system datetime
    final map = {
      ProductTable.name: name,
      ProductTable.purchasePrice: purchasePrice,
      ProductTable.picture: picture,
    };

    if (!isAdding) {
      map[ProductTable.createdAt] = createdAt.toIso8601String();
      map[ProductTable.updatedAt] = updatedAt.toIso8601String();
    }

    return map;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map[ProductTable.id]?.toInt(),
      name: map[ProductTable.name] ?? '',
      purchasePrice: map[ProductTable.purchasePrice]?.toDouble() ?? 0.0,
      picture: map[ProductTable.picture],
      number: map['number']?.toInt(),
      createdAt: DateTime.parse(map[ProductTable.createdAt]),
      updatedAt: DateTime.parse(map[ProductTable.updatedAt]),
    );
  }

  String toJson() => json.encode(toMap(
        isAdding: true,
      ));

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, name: $name, purchasePrice: $purchasePrice, picture: $picture, number: $number, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.purchasePrice == purchasePrice &&
        other.picture == picture &&
        other.number == number &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        purchasePrice.hashCode ^
        picture.hashCode ^
        number.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
