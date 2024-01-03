import 'dart:convert';

import 'package:communitybank/models/tables/personal_status/personal_status_table.model.dart';
import 'package:flutter/widgets.dart';

class PersonalStatus {
  final int? id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  PersonalStatus({
    this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  PersonalStatus copyWith({
    ValueGetter<int?>? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PersonalStatus(
      id: id?.call() ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      //   PersonalStatusTable.id: id,
      PersonalStatusTable.name: name,
      PersonalStatusTable.createdAt: createdAt.toIso8601String(),
      PersonalStatusTable.updatedAt: updatedAt.toIso8601String(),
    };
  }

  factory PersonalStatus.fromMap(Map<String, dynamic> map) {
    return PersonalStatus(
      id: map[PersonalStatusTable.id]?.toInt(),
      name: map[PersonalStatusTable.name] ?? '',
      createdAt: DateTime.parse(map[PersonalStatusTable.createdAt]),
      updatedAt: DateTime.parse(map[PersonalStatusTable.updatedAt]),
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonalStatus.fromJson(String source) =>
      PersonalStatus.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PersonalStatus(id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PersonalStatus &&
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
