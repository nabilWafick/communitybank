// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/agents_total/agents_total_rpc.model.dart';

class AgentsTotal {
  final int totalNumber;
  AgentsTotal({
    required this.totalNumber,
  });

  AgentsTotal copyWith({
    int? totalNumber,
  }) {
    return AgentsTotal(
      totalNumber: totalNumber ?? this.totalNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      AgentsTotalRPC.totalNumber: totalNumber,
    };
  }

  factory AgentsTotal.fromMap(Map<String, dynamic> map) {
    return AgentsTotal(
      totalNumber: map[AgentsTotalRPC.totalNumber] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AgentsTotal.fromJson(String source) =>
      AgentsTotal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AgentsTotal(totalNumber: $totalNumber)';

  @override
  bool operator ==(covariant AgentsTotal other) {
    if (identical(this, other)) return true;

    return other.totalNumber == totalNumber;
  }

  @override
  int get hashCode => totalNumber.hashCode;
}
