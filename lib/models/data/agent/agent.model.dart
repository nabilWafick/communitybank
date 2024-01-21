import 'dart:convert';

import 'package:communitybank/models/tables/agent/agent_table.model.dart';
import 'package:flutter/widgets.dart';

class Agent {
  final int? id;
  final String name;
  final String firstnames;
  final String phoneNumber;
  final String email;
  final String address;
  final String? profile;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;
  Agent({
    this.id,
    required this.name,
    required this.firstnames,
    required this.phoneNumber,
    required this.email,
    required this.address,
    this.profile,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  Agent copyWith({
    ValueGetter<int?>? id,
    String? name,
    String? firstnames,
    String? phoneNumber,
    String? email,
    String? address,
    ValueGetter<String?>? profile,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Agent(
      id: id != null ? id() : this.id,
      name: name ?? this.name,
      firstnames: firstnames ?? this.firstnames,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      address: address ?? this.address,
      profile: profile != null ? profile() : this.profile,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      AgentTable.name: name,
      AgentTable.firstnames: firstnames,
      AgentTable.phoneNumber: phoneNumber,
      AgentTable.email: email,
      AgentTable.address: address,
      AgentTable.profile: profile,
      AgentTable.role: role,
      AgentTable.createdAt: createdAt.toIso8601String(),
      AgentTable.updatedAt: updatedAt.toIso8601String(),
    };
  }

  factory Agent.fromMap(Map<String, dynamic> map) {
    return Agent(
      id: map['id']?.toInt(),
      name: map[AgentTable.name] ?? '',
      firstnames: map[AgentTable.firstnames] ?? '',
      phoneNumber: map[AgentTable.phoneNumber] ?? '',
      email: map[AgentTable.email] ?? '',
      address: map[AgentTable.address] ?? '',
      profile: map[AgentTable.profile],
      role: map[AgentTable.role],
      createdAt: DateTime.parse(map[AgentTable.createdAt]),
      updatedAt: DateTime.parse(map[AgentTable.updatedAt]),
    );
  }
  String toJson() => json.encode(toMap());

  factory Agent.fromJson(String source) => Agent.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Agent(id: $id, name: $name, firstnames: $firstnames, phoneNumber: $phoneNumber, email: $email, address: $address, profile: $profile, role: $role, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Agent &&
        other.id == id &&
        other.name == name &&
        other.firstnames == firstnames &&
        other.phoneNumber == phoneNumber &&
        other.email == email &&
        other.address == address &&
        other.profile == profile &&
        other.role == role &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        firstnames.hashCode ^
        phoneNumber.hashCode ^
        email.hashCode ^
        address.hashCode ^
        profile.hashCode ^
        role.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
