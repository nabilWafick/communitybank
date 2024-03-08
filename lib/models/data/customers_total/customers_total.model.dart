// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/customers_total/customers_total_rpc.model.dart';

class CustomersTotal {
  final int totalNumber;
  CustomersTotal({
    required this.totalNumber,
  });

  CustomersTotal copyWith({
    int? totalNumber,
  }) {
    return CustomersTotal(
      totalNumber: totalNumber ?? this.totalNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CustomersTotalRPC.totalNumber: totalNumber,
    };
  }

  factory CustomersTotal.fromMap(Map<String, dynamic> map) {
    return CustomersTotal(
      totalNumber: map[CustomersTotalRPC.totalNumber] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomersTotal.fromJson(String source) =>
      CustomersTotal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CustomersTotal(totalNumber: $totalNumber)';

  @override
  bool operator ==(covariant CustomersTotal other) {
    if (identical(this, other)) return true;

    return other.totalNumber == totalNumber;
  }

  @override
  int get hashCode => totalNumber.hashCode;
}
