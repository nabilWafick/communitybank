// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/collectors_total/collectors_total_rpc.model.dart';
import 'package:flutter/material.dart';

class CollectorsTotal {
  final int totalNumber;
  CollectorsTotal({
    required this.totalNumber,
  });

  CollectorsTotal copyWith({
    int? totalNumber,
  }) {
    return CollectorsTotal(
      totalNumber: totalNumber ?? this.totalNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CollectorsTotalRPC.totalNumber: totalNumber,
    };
  }

  factory CollectorsTotal.fromMap(Map<String, dynamic> map) {
    try {
      return CollectorsTotal(
        totalNumber: map[CollectorsTotalRPC.totalNumber] as int,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
    return CollectorsTotal(
      totalNumber: map[CollectorsTotalRPC.totalNumber] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CollectorsTotal.fromJson(String source) =>
      CollectorsTotal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CollectorsTotal(totalNumber: $totalNumber)';

  @override
  bool operator ==(covariant CollectorsTotal other) {
    if (identical(this, other)) return true;

    return other.totalNumber == totalNumber;
  }

  @override
  int get hashCode => totalNumber.hashCode;
}
