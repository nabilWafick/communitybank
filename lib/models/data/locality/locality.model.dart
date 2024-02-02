import 'dart:convert';

import 'package:communitybank/models/tables/locality/locality_table.model.dart';
import 'package:flutter/widgets.dart';

class Locality {
  final int? id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  Locality({
    this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  Locality copyWith({
    ValueGetter<int?>? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Locality(
      id: id?.call() ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap({required bool isAdding}) {
    // hide creation and update date for avoiding time hacking
    // by unsetting the system datetime
    final map = {
      LocalityTable.name: name,
    };
    if (!isAdding) {
      map[LocalityTable.createdAt] = createdAt.toIso8601String();
    }

    return map;
  }

  factory Locality.fromMap(Map<String, dynamic> map) {
    return Locality(
      id: map[LocalityTable.id]?.toInt(),
      name: map[LocalityTable.name] ?? '',
      createdAt: DateTime.parse(map[LocalityTable.createdAt]),
      updatedAt: DateTime.parse(map[LocalityTable.updatedAt]),
    );
  }

  String toJson() => json.encode(toMap(isAdding: true));

  factory Locality.fromJson(String source) =>
      Locality.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Locality(id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Locality &&
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
