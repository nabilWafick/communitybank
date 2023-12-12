import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:communitybank/models/views/sidear_suboption/sidebar_suboption.model.dart';

class SidebarOptionModel {
  final IconData icon;
  final String name;
  final List<SidebarSubOptionModel> subOptions;
  final bool
      showSubOptions; //In the case where the suboptions won't be showed like dashboard otion, because the suboption is one. In other case, the unique suoptions should have been show like guide in File
  SidebarOptionModel({
    required this.icon,
    required this.name,
    required this.subOptions,
    required this.showSubOptions,
  });

  SidebarOptionModel copyWith({
    IconData? icon,
    String? name,
    List<SidebarSubOptionModel>? subOptions,
    bool? showSubOptions,
  }) {
    return SidebarOptionModel(
      icon: icon ?? this.icon,
      name: name ?? this.name,
      subOptions: subOptions ?? this.subOptions,
      showSubOptions: showSubOptions ?? this.showSubOptions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'icon': icon.codePoint,
      'name': name,
      'subOptions': subOptions.map((x) => x.toMap()).toList(),
      'showSubOptions': showSubOptions,
    };
  }

  factory SidebarOptionModel.fromMap(Map<String, dynamic> map) {
    return SidebarOptionModel(
      icon: IconData(map['icon'], fontFamily: 'MaterialIcons'),
      name: map['name'] ?? '',
      subOptions: List<SidebarSubOptionModel>.from(
          map['subOptions']?.map((x) => SidebarSubOptionModel.fromMap(x))),
      showSubOptions: map['showSubOptions'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory SidebarOptionModel.fromJson(String source) =>
      SidebarOptionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SidebarOptionModel(icon: $icon, name: $name, subOptions: $subOptions, showSubOptions: $showSubOptions)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SidebarOptionModel &&
        other.icon == icon &&
        other.name == name &&
        listEquals(other.subOptions, subOptions) &&
        other.showSubOptions == showSubOptions;
  }

  @override
  int get hashCode {
    return icon.hashCode ^
        name.hashCode ^
        subOptions.hashCode ^
        showSubOptions.hashCode;
  }
}
