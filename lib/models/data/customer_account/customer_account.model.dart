import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:communitybank/models/tables/customer_account/customer_account_table.model.dart';

class CustomerAccount {
  final int? id;
  final int customerId;
  final int collectorId;
  final List<dynamic> customerCardsIds;
  final DateTime createdAt;
  final DateTime updatedAt;
  CustomerAccount({
    this.id,
    required this.customerId,
    required this.collectorId,
    required this.customerCardsIds,
    required this.createdAt,
    required this.updatedAt,
  });

  CustomerAccount copyWith({
    ValueGetter<int?>? id,
    int? customerId,
    int? collectorId,
    List<dynamic>? customerCardsIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CustomerAccount(
      id: id != null ? id() : this.id,
      customerId: customerId ?? this.customerId,
      collectorId: collectorId ?? this.collectorId,
      customerCardsIds: customerCardsIds ?? this.customerCardsIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      CustomerAccountTable.customerId: customerId,
      CustomerAccountTable.collectorId: collectorId,
      CustomerAccountTable.customerCardsIds: customerCardsIds,
      CustomerAccountTable.createdAt: createdAt.toIso8601String(),
      CustomerAccountTable.updatedAt: updatedAt.toIso8601String(),
    };
  }

  factory CustomerAccount.fromMap(Map<String, dynamic> map) {
    return CustomerAccount(
      id: map[CustomerAccountTable.id]?.toInt(),
      customerId: map[CustomerAccountTable.customerId]?.toInt() ?? 0,
      collectorId: map[CustomerAccountTable.collectorId]?.toInt() ?? 0,
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
    return 'CustomerAccount(id: $id, customerId: $customerId, collectorId: $collectorId, customerCardsIds: $customerCardsIds, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomerAccount &&
        other.id == id &&
        other.customerId == customerId &&
        other.collectorId == collectorId &&
        listEquals(other.customerCardsIds, customerCardsIds) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customerId.hashCode ^
        collectorId.hashCode ^
        customerCardsIds.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
