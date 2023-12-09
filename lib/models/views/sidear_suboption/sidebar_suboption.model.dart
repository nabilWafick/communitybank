import 'dart:convert';

import 'package:flutter/material.dart';

class SidebarSubOptionModel {
  final int index;
  final IconData icon;
  final String name;
  SidebarSubOptionModel({
    required this.index,
    required this.icon,
    required this.name,
  });

  SidebarSubOptionModel copyWith({
    int? index,
    IconData? icon,
    String? name,
  }) {
    return SidebarSubOptionModel(
      index: index ?? this.index,
      icon: icon ?? this.icon,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'index': index,
      'icon': icon.codePoint,
      'name': name,
    };
  }

  factory SidebarSubOptionModel.fromMap(Map<String, dynamic> map) {
    return SidebarSubOptionModel(
      index: map['index']?.toInt() ?? 0,
      icon: IconData(map['icon'], fontFamily: 'MaterialIcons'),
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SidebarSubOptionModel.fromJson(String source) =>
      SidebarSubOptionModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'SidebarSubOptionModel(index: $index, icon: $icon, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SidebarSubOptionModel &&
        other.index == index &&
        other.icon == icon &&
        other.name == name;
  }

  @override
  int get hashCode => index.hashCode ^ icon.hashCode ^ name.hashCode;
}
