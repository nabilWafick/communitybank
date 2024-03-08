// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/settlements_total/settlements_total_rpc.model.dart';

class SettlementsTotal {
  final int totalNumber;
  SettlementsTotal({
    required this.totalNumber,
  });

  SettlementsTotal copyWith({
    int? totalNumber,
  }) {
    return SettlementsTotal(
      totalNumber: totalNumber ?? this.totalNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      SettlementsTotalRPC.totalNumber: totalNumber,
    };
  }

  factory SettlementsTotal.fromMap(Map<String, dynamic> map) {
    return SettlementsTotal(
      totalNumber: map[SettlementsTotalRPC.totalNumber] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory SettlementsTotal.fromJson(String source) =>
      SettlementsTotal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SettlementsTotal(totalNumber: $totalNumber)';

  @override
  bool operator ==(covariant SettlementsTotal other) {
    if (identical(this, other)) return true;

    return other.totalNumber == totalNumber;
  }

  @override
  int get hashCode => totalNumber.hashCode;
}
