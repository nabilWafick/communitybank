// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/tables/transfer/transfer_table.model.dart';

class Transfer {
  int? id;
  int customerAccountId;
  int issuingCustomerCardId;
  int receivingCustomerCardId;
  int agentId;
  DateTime? validatedAt;
  DateTime createdAt;
  DateTime updatedAt;
  Transfer({
    this.id,
    required this.customerAccountId,
    required this.issuingCustomerCardId,
    required this.receivingCustomerCardId,
    required this.agentId,
    this.validatedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  Transfer copyWith({
    int? id,
    int? customerAccount,
    int? issuingCustomerCardId,
    int? receivingCustomerCardId,
    int? agentId,
    DateTime? validatedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Transfer(
      id: id ?? this.id,
      customerAccountId: customerAccountId,
      issuingCustomerCardId:
          issuingCustomerCardId ?? this.issuingCustomerCardId,
      receivingCustomerCardId:
          receivingCustomerCardId ?? this.receivingCustomerCardId,
      agentId: agentId ?? this.agentId,
      validatedAt: validatedAt ?? this.validatedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap({required bool isAdding}) {
    final map = {
      TransferTable.customerAccountId: customerAccountId,
      TransferTable.issuingCustomerCardId: issuingCustomerCardId,
      TransferTable.receivingCustomerCardId: receivingCustomerCardId,
      TransferTable.agentId: agentId,
      TransferTable.validatedAt: validatedAt?.toIso8601String(),
    };
    if (isAdding) {
      map[TransferTable.createdAt] = createdAt.toIso8601String();
    }

    return map;
  }

  factory Transfer.fromMap(Map<String, dynamic> map) {
    return Transfer(
      id: map[TransferTable.id] != null ? map[TransferTable.id] as int : null,
      customerAccountId: map[TransferTable.customerAccountId] as int,
      issuingCustomerCardId: map[TransferTable.issuingCustomerCardId] as int,
      receivingCustomerCardId:
          map[TransferTable.receivingCustomerCardId] as int,
      agentId: map[TransferTable.agentId] as int,
      validatedAt: map[TransferTable.validatedAt] != null
          ? DateTime.parse(map[TransferTable.validatedAt])
          : null,
      createdAt: DateTime.parse(map[TransferTable.createdAt]),
      updatedAt: DateTime.parse(map[TransferTable.updatedAt]),
    );
  }

  String toJson() => json.encode(
        toMap(
          isAdding: false,
        ),
      );

  factory Transfer.fromJson(String source) =>
      Transfer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transfer(id: $id, customerAccountId: $customerAccountId, issuingCustomerCardId: $issuingCustomerCardId, receivingCustomerCardId: $receivingCustomerCardId, agentId: $agentId, validatedAt: $validatedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Transfer other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.customerAccountId == customerAccountId &&
        other.issuingCustomerCardId == issuingCustomerCardId &&
        other.receivingCustomerCardId == receivingCustomerCardId &&
        other.agentId == agentId &&
        other.validatedAt == validatedAt &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customerAccountId.hashCode ^
        issuingCustomerCardId.hashCode ^
        receivingCustomerCardId.hashCode ^
        agentId.hashCode ^
        validatedAt.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
