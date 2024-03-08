// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/customers_cards_total/customers_cards_total_rpc.model.dart';

class CustomersCardsTotal {
  final int totalNumber;
  CustomersCardsTotal({
    required this.totalNumber,
  });

  CustomersCardsTotal copyWith({
    int? totalNumber,
  }) {
    return CustomersCardsTotal(
      totalNumber: totalNumber ?? this.totalNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CustomersCardsTotalRPC.totalNumber: totalNumber,
    };
  }

  factory CustomersCardsTotal.fromMap(Map<String, dynamic> map) {
    return CustomersCardsTotal(
      totalNumber: map[CustomersCardsTotalRPC.totalNumber] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomersCardsTotal.fromJson(String source) =>
      CustomersCardsTotal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CustomersCardsTotal(totalNumber: $totalNumber)';

  @override
  bool operator ==(covariant CustomersCardsTotal other) {
    if (identical(this, other)) return true;

    return other.totalNumber == totalNumber;
  }

  @override
  int get hashCode => totalNumber.hashCode;
}
