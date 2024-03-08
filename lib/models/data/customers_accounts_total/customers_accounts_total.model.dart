// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/customers_accounts_total/customers_accounts_total_rpc.model.dart';

class CustomersAccountsTotal {
  final int totalNumber;
  CustomersAccountsTotal({
    required this.totalNumber,
  });

  CustomersAccountsTotal copyWith({
    int? totalNumber,
  }) {
    return CustomersAccountsTotal(
      totalNumber: totalNumber ?? this.totalNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CustomersAccountsTotalRPC.totalNumber: totalNumber,
    };
  }

  factory CustomersAccountsTotal.fromMap(Map<String, dynamic> map) {
    return CustomersAccountsTotal(
      totalNumber: map[CustomersAccountsTotalRPC.totalNumber] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomersAccountsTotal.fromJson(String source) =>
      CustomersAccountsTotal.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CustomersAccountsTotal(totalNumber: $totalNumber)';

  @override
  bool operator ==(covariant CustomersAccountsTotal other) {
    if (identical(this, other)) return true;

    return other.totalNumber == totalNumber;
  }

  @override
  int get hashCode => totalNumber.hashCode;
}
