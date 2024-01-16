import 'dart:convert';

import 'package:communitybank/models/tables/customer_account/customer_account_table.model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class CustomerAccount {
  final int? id;
  final int customerAccountId;
  final int collectorId;
  final DateTime createdAt;
  final DateTime updatedAt;
  CustomerAccount({
    this.id,
    required this.customerAccountId,
    required this.collectorId,
    required this.createdAt,
    required this.updatedAt,
  });

  CustomerAccount copyWith({
    ValueGetter<int?>? id,
    int? customerAccountId,
    int? collectorId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CustomerAccount(
      id: id != null ? id() : this.id,
      customerAccountId: customerAccountId ?? this.customerAccountId,
      collectorId: collectorId ?? this.collectorId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      CustomerAccountTable.customerAccountId: customerAccountId,
      CustomerAccountTable.collectorId: collectorId,
      CustomerAccountTable.createdAt: createdAt.millisecondsSinceEpoch,
      CustomerAccountTable.updatedAt: updatedAt.millisecondsSinceEpoch,
    };
  }

  factory CustomerAccount.fromMap(Map<String, dynamic> map) {
    return CustomerAccount(
      id: map[CustomerAccountTable.id]?.toInt(),
      customerAccountId:
          map[CustomerAccountTable.customerAccountId]?.toInt() ?? 0,
      collectorId: map[CustomerAccountTable.collectorId]?.toInt() ?? 0,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
          map[CustomerAccountTable.createdAt]),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
          map[CustomerAccountTable.updatedAt]),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerAccount.fromJson(String source) =>
      CustomerAccount.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomerAccount(id: $id, customerAccountId: $customerAccountId, collectorId: $collectorId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomerAccount &&
        other.id == id &&
        other.customerAccountId == customerAccountId &&
        other.collectorId == collectorId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customerAccountId.hashCode ^
        collectorId.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
