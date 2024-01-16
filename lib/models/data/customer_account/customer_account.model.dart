import 'dart:convert';

import 'package:communitybank/models/data/customers_category/customers_category.model.dart';
import 'package:communitybank/models/data/economical_activity/economical_activity.model.dart';
import 'package:communitybank/models/data/locality/locality.model.dart';
import 'package:communitybank/models/data/personal_status/personal_status.model.dart';
import 'package:communitybank/models/tables/customer_account/customer_account_table.model.dart';
import 'package:flutter/foundation.dart';

import 'package:communitybank/models/data/card/card.model.dart';
import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/models/data/customer/customer.model.dart';

class CustomerAccount {
  final int? id;
  Customer customer;
  final int? customerId;
  List<Card> cards;
  final List<int>? cardsIds;
  Collector collector;
  final int? collectorId;
  final DateTime createdAt;
  final DateTime updatedAt;
  CustomerAccount({
    this.id,
    required this.customer,
    this.customerId,
    required this.cards,
    this.cardsIds,
    required this.collector,
    this.collectorId,
    required this.createdAt,
    required this.updatedAt,
  });

  CustomerAccount copyWith({
    ValueGetter<int?>? id,
    Customer? customer,
    ValueGetter<int?>? customerId,
    List<Card>? cards,
    ValueGetter<List<int>?>? cardsIds,
    Collector? collector,
    ValueGetter<int?>? collectorId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CustomerAccount(
      id: id != null ? id() : this.id,
      customer: customer ?? this.customer,
      customerId: customerId != null ? customerId() : this.customerId,
      cards: cards ?? this.cards,
      cardsIds: cardsIds != null ? cardsIds() : this.cardsIds,
      collector: collector ?? this.collector,
      collectorId: collectorId != null ? collectorId() : this.collectorId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerId': customer.id,
      'cardsIds': cards
          .map(
            (card) => card.id,
          )
          .toList(),
      'collectorId': collector.id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory CustomerAccount.fromMap(Map<String, dynamic> map) {
    return CustomerAccount(
      id: map[CustomerAccountTable.id]?.toInt(),
      customer: Customer(
        name: 'Non défini',
        firstnames: '',
        phoneNumber: '',
        address: '',
        profession: '',
        nicNumber: 1,
        category: CustomerCategory(
          name: 'Non défini',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        economicalActivity: EconomicalActivity(
          name: 'Non défini',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        personalStatus: PersonalStatus(
          name: 'Non défini',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        locality: Locality(
          name: 'Non défini',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      customerId: map[CustomerAccountTable.customerId]?.toInt(),
      cards: [],
      cardsIds: List<int>.from(map[CustomerAccountTable.cardsIds]),
      collector: Collector(
        name: '',
        firstnames: '',
        phoneNumber: '',
        address: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      collectorId: map[CustomerAccountTable.collectorId]?.toInt(),
      createdAt: DateTime.parse(map[CustomerAccountTable.createdAt]),
      updatedAt: DateTime.parse(map[CustomerAccountTable.updatedAt]),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerAccount.fromJson(String source) =>
      CustomerAccount.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomerAccount(id: $id, customer: $customer, customerId: $customerId, cards: $cards, cardsIds: $cardsIds, collector: $collector, collectorId: $collectorId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomerAccount &&
        other.id == id &&
        other.customer == customer &&
        other.customerId == customerId &&
        listEquals(other.cards, cards) &&
        listEquals(other.cardsIds, cardsIds) &&
        other.collector == collector &&
        other.collectorId == collectorId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customer.hashCode ^
        customerId.hashCode ^
        cards.hashCode ^
        cardsIds.hashCode ^
        collector.hashCode ^
        collectorId.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
