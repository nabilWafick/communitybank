import 'dart:convert';

import 'package:communitybank/models/tables/economical_activity/economical_activity_table.model.dart';
import 'package:flutter/widgets.dart';

class EconomicalActivity {
  final int? id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  EconomicalActivity({
    this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  EconomicalActivity copyWith({
    ValueGetter<int?>? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EconomicalActivity(
      id: id?.call() ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      //  EconomicalActivityTable.id: id,
      EconomicalActivityTable.name: name,
      EconomicalActivityTable.createdAt: createdAt.toIso8601String(),
      EconomicalActivityTable.updatedAt: updatedAt.toIso8601String(),
    };
  }

  factory EconomicalActivity.fromMap(Map<String, dynamic> map) {
    return EconomicalActivity(
      id: map[EconomicalActivityTable.id]?.toInt(),
      name: map[EconomicalActivityTable.name] ?? '',
      createdAt: DateTime.parse(map[EconomicalActivityTable.createdAt]),
      updatedAt: DateTime.parse(map[EconomicalActivityTable.updatedAt]),
    );
  }

  String toJson() => json.encode(toMap());

  factory EconomicalActivity.fromJson(String source) =>
      EconomicalActivity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EconomicalActivity(id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EconomicalActivity &&
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
