// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/customer_account_detail/customer_account_detail_rpc.model.dart';
import 'package:flutter/foundation.dart';

class CustomerAccountDetail {
  final int customerAccountId;
  final int customerId;
  final String customer;
  final int collectorId;
  final List<dynamic> cardsIds;
  final DateTime createdAt;
  final DateTime updatedAt;
  CustomerAccountDetail({
    required this.customerAccountId,
    required this.customerId,
    required this.customer,
    required this.collectorId,
    required this.cardsIds,
    required this.createdAt,
    required this.updatedAt,
  });

  CustomerAccountDetail copyWith({
    int? customerAccountId,
    int? customerId,
    String? customer,
    int? collectorId,
    List<dynamic>? cardsIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CustomerAccountDetail(
      customerAccountId: customerAccountId ?? this.customerAccountId,
      customerId: customerId ?? this.customerId,
      customer: customer ?? this.customer,
      collectorId: collectorId ?? this.collectorId,
      cardsIds: cardsIds ?? this.cardsIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CustomerAccountDetailRPC.customerAccountId: customerAccountId,
      CustomerAccountDetailRPC.customerId: customerId,
      CustomerAccountDetailRPC.customer: customer,
      CustomerAccountDetailRPC.collectorId: collectorId,
      CustomerAccountDetailRPC.cardsIds: cardsIds,
      CustomerAccountDetailRPC.createdAt: createdAt.millisecondsSinceEpoch,
      CustomerAccountDetailRPC.updatedAt: updatedAt.millisecondsSinceEpoch,
    };
  }

  factory CustomerAccountDetail.fromMap(Map<String, dynamic> map) {
    try {
      return CustomerAccountDetail(
        customerAccountId:
            map[CustomerAccountDetailRPC.customerAccountId] as int,
        customerId: map[CustomerAccountDetailRPC.customerId] as int,
        customer: map[CustomerAccountDetailRPC.customer] as String,
        collectorId: map[CustomerAccountDetailRPC.collectorId] as int,
        cardsIds: List<dynamic>.from(
            map[CustomerAccountDetailRPC.cardsIds] as List<dynamic>),
        createdAt: DateTime.parse(map[CustomerAccountDetailRPC.createdAt]),
        updatedAt: DateTime.parse(map[CustomerAccountDetailRPC.updatedAt]),
      );
    } catch (e) {
      debugPrint(e.toString());
    }

    return CustomerAccountDetail(
      customerAccountId: 0,
      customerId: 0,
      customer: 'test',
      collectorId: 0,
      cardsIds: [],
      createdAt: DateTime.parse(map[CustomerAccountDetailRPC.createdAt]),
      updatedAt: DateTime.parse(map[CustomerAccountDetailRPC.updatedAt]),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerAccountDetail.fromJson(String source) =>
      CustomerAccountDetail.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomerAccountDetail(customerAccountId: $customerAccountId, customerId: $customerId, customer: $customer, collectorId: $collectorId, cardsIds: $cardsIds, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant CustomerAccountDetail other) {
    if (identical(this, other)) return true;

    return other.customerAccountId == customerAccountId &&
        other.customerId == customerId &&
        other.customer == customer &&
        other.collectorId == collectorId &&
        listEquals(other.cardsIds, cardsIds) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return customerAccountId.hashCode ^
        customerId.hashCode ^
        customer.hashCode ^
        collectorId.hashCode ^
        cardsIds.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
