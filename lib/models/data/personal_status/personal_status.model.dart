import 'dart:convert';
import 'package:flutter/widgets.dart';

class PersonalStatus {
  final int? id;
  final String nom;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  PersonalStatus({
    this.id,
    required this.nom,
    this.createdAt,
    this.updatedAt,
  });

  PersonalStatus copyWith({
    ValueGetter<int?>? id,
    String? nom,
    ValueGetter<DateTime?>? createdAt,
    ValueGetter<DateTime?>? updatedAt,
  }) {
    return PersonalStatus(
      id: id?.call() ?? this.id,
      nom: nom ?? this.nom,
      createdAt: createdAt?.call() ?? this.createdAt,
      updatedAt: updatedAt?.call() ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory PersonalStatus.fromMap(Map<String, dynamic> map) {
    return PersonalStatus(
      id: map['id']?.toInt(),
      nom: map['nom'] ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonalStatus.fromJson(String source) =>
      PersonalStatus.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PersonalStatus(id: $id, nom: $nom, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PersonalStatus &&
        other.id == id &&
        other.nom == nom &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ nom.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;
  }
}
