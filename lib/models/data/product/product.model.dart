import 'dart:convert';

import 'package:flutter/widgets.dart';

class Product {
  final int? id;
  final String nom;
  final double purchasePrice;
  final String photo;
  final int? number;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  Product({
    this.id,
    required this.nom,
    required this.purchasePrice,
    required this.photo,
    this.number,
    this.createdAt,
    this.updatedAt,
  });

  Product copyWith({
    ValueGetter<int?>? id,
    String? nom,
    double? purchasePrice,
    String? photo,
    ValueGetter<int?>? number,
    ValueGetter<DateTime?>? createdAt,
    ValueGetter<DateTime?>? updatedAt,
  }) {
    return Product(
      id: id?.call() ?? this.id,
      nom: nom ?? this.nom,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      photo: photo ?? this.photo,
      number: number?.call() ?? this.number,
      createdAt: createdAt?.call() ?? this.createdAt,
      updatedAt: updatedAt?.call() ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'purchasePrice': purchasePrice,
      'photo': photo,
      'number': number,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id']?.toInt(),
      nom: map['nom'] ?? '',
      purchasePrice: map['purchasePrice']?.toDouble() ?? 0.0,
      photo: map['photo'] ?? '',
      number: map['number']?.toInt(),
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, nom: $nom, purchasePrice: $purchasePrice, photo: $photo, number: $number, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.nom == nom &&
        other.purchasePrice == purchasePrice &&
        other.photo == photo &&
        other.number == number &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nom.hashCode ^
        purchasePrice.hashCode ^
        photo.hashCode ^
        number.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
