import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:communitybank/models/views/sidear_suboption/sidebar_suboption.model.dart';

class SidebarOptionModel {
  final int index;
  final IconData icon;
  final String name;
  final List<SidebarSubOptionModel> subOptions;
  SidebarOptionModel({
    required this.index,
    required this.icon,
    required this.name,
    required this.subOptions,
  });

  SidebarOptionModel copyWith({
    int? index,
    IconData? icon,
    String? name,
    List<SidebarSubOptionModel>? subOptions,
  }) {
    return SidebarOptionModel(
      index: index ?? this.index,
      icon: icon ?? this.icon,
      name: name ?? this.name,
      subOptions: subOptions ?? this.subOptions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'index': index,
      'icon': icon.codePoint,
      'name': name,
      'subOptions': subOptions.map((x) => x.toMap()).toList(),
    };
  }

  factory SidebarOptionModel.fromMap(Map<String, dynamic> map) {
    return SidebarOptionModel(
      index: map['index']?.toInt() ?? 0,
      icon: IconData(map['icon'], fontFamily: 'MaterialIcons'),
      name: map['name'] ?? '',
      subOptions: List<SidebarSubOptionModel>.from(
          map['subOptions']?.map((x) => SidebarSubOptionModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SidebarOptionModel.fromJson(String source) =>
      SidebarOptionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SidebarOptionModel(index: $index, icon: $icon, name: $name, subOptions: $subOptions)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SidebarOptionModel &&
        other.index == index &&
        other.icon == icon &&
        other.name == name &&
        listEquals(other.subOptions, subOptions);
  }

  @override
  int get hashCode {
    return index.hashCode ^ icon.hashCode ^ name.hashCode ^ subOptions.hashCode;
  }
}
