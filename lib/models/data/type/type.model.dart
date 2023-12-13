import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:communitybank/models/data/product/product.model.dart';

class Type {
  final int? id;
  final String nom;
  final double stake;
  final List<Product> products;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  Type({
    this.id,
    required this.nom,
    required this.stake,
    required this.products,
    this.createdAt,
    this.updatedAt,
  });

  Type copyWith({
    ValueGetter<int?>? id,
    String? nom,
    double? stake,
    List<Product>? products,
    ValueGetter<DateTime?>? createdAt,
    ValueGetter<DateTime?>? updatedAt,
  }) {
    return Type(
      id: id?.call() ?? this.id,
      nom: nom ?? this.nom,
      stake: stake ?? this.stake,
      products: products ?? this.products,
      createdAt: createdAt?.call() ?? this.createdAt,
      updatedAt: updatedAt?.call() ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'stake': stake,
      'products': products.map((x) => x.toMap()).toList(),
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory Type.fromMap(Map<String, dynamic> map) {
    return Type(
      id: map['id']?.toInt(),
      nom: map['nom'] ?? '',
      stake: map['stake']?.toDouble() ?? 0.0,
      products:
          List<Product>.from(map['products']?.map((x) => Product.fromMap(x))),
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Type.fromJson(String source) => Type.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Type(id: $id, nom: $nom, stake: $stake, products: $products, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Type &&
        other.id == id &&
        other.nom == nom &&
        other.stake == stake &&
        listEquals(other.products, products) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nom.hashCode ^
        stake.hashCode ^
        products.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
