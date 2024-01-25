import 'dart:convert';

import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:flutter/foundation.dart';

import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/models/tables/customer_account/customer_account_table.model.dart';

class CustomerAccount {
  final int? id;
  Customer? customer;
  final int customerId;
  Collector? collector;
  final int collectorId;
  List<CustomerCard> customerCards;
  final List<dynamic>? customerCardsIds;
  final DateTime createdAt;
  final DateTime updatedAt;
  CustomerAccount({
    this.id,
    this.customer,
    required this.customerId,
    this.collector,
    required this.collectorId,
    required this.customerCards,
    this.customerCardsIds,
    required this.createdAt,
    required this.updatedAt,
  });

  CustomerAccount copyWith({
    ValueGetter<int?>? id,
    int? customerId,
    int? collectorId,
    List<CustomerCard>? customerCards,
    ValueGetter<List<dynamic>?>? customerCardsIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CustomerAccount(
      id: id != null ? id() : this.id,
      customerId: customerId ?? this.customerId,
      collectorId: collectorId ?? this.collectorId,
      customerCards: customerCards ?? this.customerCards,
      customerCardsIds:
          customerCardsIds != null ? customerCardsIds() : this.customerCardsIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      CustomerAccountTable.customerId: customerId,
      CustomerAccountTable.collectorId: collectorId,
      CustomerAccountTable.customerCardsIds: customerCards
          .map(
            (customerCard) => customerCard.id,
          )
          .toList(),
      CustomerAccountTable.createdAt: createdAt.toIso8601String(),
      CustomerAccountTable.updatedAt: updatedAt.toIso8601String(),
    };
  }

  factory CustomerAccount.fromMap(Map<String, dynamic> map) {
    return CustomerAccount(
      id: map[CustomerAccountTable.id]?.toInt(),
      customer: null,
      customerId: map[CustomerAccountTable.customerId]?.toInt() ?? 0,
      collector: null,
      collectorId: map[CustomerAccountTable.collectorId]?.toInt() ?? 0,
      customerCards: [],
      customerCardsIds:
          List<dynamic>.from(map[CustomerAccountTable.customerCardsIds]),
      createdAt: DateTime.parse(map[CustomerAccountTable.createdAt]),
      updatedAt: DateTime.parse(map[CustomerAccountTable.updatedAt]),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerAccount.fromJson(String source) =>
      CustomerAccount.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomerAccount(id: $id, customerId: $customerId, collectorId: $collectorId, customerCards: $customerCards, customerCardsIds: $customerCardsIds, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomerAccount &&
        other.id == id &&
        other.customerId == customerId &&
        other.collectorId == collectorId &&
        listEquals(other.customerCards, customerCards) &&
        listEquals(other.customerCardsIds, customerCardsIds) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customerId.hashCode ^
        collectorId.hashCode ^
        customerCards.hashCode ^
        customerCardsIds.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
