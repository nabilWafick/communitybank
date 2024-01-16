import 'dart:convert';

import 'package:communitybank/models/tables/settlement/settlement_table.model.dart';
import 'package:flutter/widgets.dart';
import 'package:communitybank/models/data/agent/agent.model.dart';

class Settlement {
  final int? id;
  final int number;
  Agent agent;
  final int? agentId;
  final DateTime createdAt;
  final DateTime updatedAt;
  Settlement({
    this.id,
    required this.number,
    required this.agent,
    this.agentId,
    required this.createdAt,
    required this.updatedAt,
  });

  Settlement copyWith({
    ValueGetter<int?>? id,
    int? number,
    Agent? agent,
    ValueGetter<int?>? agentId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Settlement(
      id: id != null ? id() : this.id,
      number: number ?? this.number,
      agent: agent ?? this.agent,
      agentId: agentId != null ? agentId() : this.agentId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      SettlementTable.number: number,
      SettlementTable.agentId: agent.id,
      SettlementTable.createdAt: createdAt.millisecondsSinceEpoch,
      SettlementTable.updatedAt: updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Settlement.fromMap(Map<String, dynamic> map) {
    return Settlement(
      id: map[SettlementTable.id]?.toInt(),
      number: map[SettlementTable.number]?.toInt() ?? 0,
      agent: Agent(
        name: '',
        firstnames: '',
        phoneNumber: '',
        address: '',
        role: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      agentId: map[SettlementTable.agentId]?.toInt(),
      createdAt: DateTime.parse(map[SettlementTable.createdAt]),
      updatedAt: DateTime.parse(map[SettlementTable.updatedAt]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Settlement.fromJson(String source) =>
      Settlement.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Settlement(id: $id, number: $number, agent: $agent, agentId: $agentId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Settlement &&
        other.id == id &&
        other.number == number &&
        other.agent == agent &&
        other.agentId == agentId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        number.hashCode ^
        agent.hashCode ^
        agentId.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
