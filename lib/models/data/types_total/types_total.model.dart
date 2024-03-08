// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/types_total/types_total_rpc.model.dart';

class TypesTotal {
  final int totalNumber;
  TypesTotal({
    required this.totalNumber,
  });

  TypesTotal copyWith({
    int? totalNumber,
  }) {
    return TypesTotal(
      totalNumber: totalNumber ?? this.totalNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      TypesTotalRPC.totalNumber: totalNumber,
    };
  }

  factory TypesTotal.fromMap(Map<String, dynamic> map) {
    return TypesTotal(
      totalNumber: map[TypesTotalRPC.totalNumber] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TypesTotal.fromJson(String source) =>
      TypesTotal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TypesTotal(totalNumber: $totalNumber)';

  @override
  bool operator ==(covariant TypesTotal other) {
    if (identical(this, other)) return true;

    return other.totalNumber == totalNumber;
  }

  @override
  int get hashCode => totalNumber.hashCode;
}
