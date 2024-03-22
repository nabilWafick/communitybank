// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/transfer_detail/transfer_detail_rpc.model.dart';

class TransferDetail {
  final int transferId;
  final int issuingCustomerCardId;
  final String issuingCustomerCardLabel;
  final int issuingCustomerCardTypeId;
  final String issuingCustomerCardTypeName;
  final int issuingCustomerAccountId;
  final int issuingCustomerCollectorId;
  final String issuingCustomerCollector;
  final String issuingCustomer;
  final int receivingCustomerCardId;
  final String receivingCustomerCardLabel;
  final int receivingCustomerCardTypeId;
  final String receivingCustomerCardTypeName;
  final int receivingCustomerAccountId;
  final int receivingCustomerCollectorId;
  final String receivingCustomerCollector;
  final String receivingCustomer;
  final int agentId;
  final String agent;
  final DateTime? validatedAt;
  final DateTime? discardedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  TransferDetail({
    required this.transferId,
    required this.issuingCustomerCardId,
    required this.issuingCustomerCardLabel,
    required this.issuingCustomerCardTypeId,
    required this.issuingCustomerCardTypeName,
    required this.issuingCustomerAccountId,
    required this.issuingCustomerCollectorId,
    required this.issuingCustomerCollector,
    required this.issuingCustomer,
    required this.receivingCustomerCardId,
    required this.receivingCustomerCardLabel,
    required this.receivingCustomerCardTypeId,
    required this.receivingCustomerCardTypeName,
    required this.receivingCustomerAccountId,
    required this.receivingCustomerCollectorId,
    required this.receivingCustomerCollector,
    required this.receivingCustomer,
    required this.agentId,
    required this.agent,
    this.validatedAt,
    this.discardedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  TransferDetail copyWith({
    int? transferId,
    int? issuingCustomerCardId,
    String? issuingCustomerCardLabel,
    int? issuingCustomerCardTypeId,
    String? issuingCustomerCardTypeName,
    int? issuingCustomerAccountId,
    int? issuingCustomerCollectorId,
    String? issuingCustomerCollector,
    String? issuingCustomer,
    int? receivingCustomerCardId,
    String? receivingCustomerCardLabel,
    int? receivingCustomerCardTypeId,
    String? receivingCustomerCardTypeName,
    int? receivingCustomerAccountId,
    int? receivingCustomerCollectorId,
    String? receivingCustomerCollector,
    String? receivingCustomer,
    int? agentId,
    String? agent,
    DateTime? validatedAt,
    DateTime? discardedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TransferDetail(
      transferId: transferId ?? this.transferId,
      issuingCustomerCardId:
          issuingCustomerCardId ?? this.issuingCustomerCardId,
      issuingCustomerCardLabel:
          issuingCustomerCardLabel ?? this.issuingCustomerCardLabel,
      issuingCustomerCardTypeId:
          issuingCustomerCardTypeId ?? this.issuingCustomerCardTypeId,
      issuingCustomerCardTypeName:
          issuingCustomerCardTypeName ?? this.issuingCustomerCardTypeName,
      issuingCustomerAccountId:
          issuingCustomerAccountId ?? this.issuingCustomerAccountId,
      issuingCustomerCollectorId:
          issuingCustomerCollectorId ?? this.issuingCustomerCollectorId,
      issuingCustomerCollector:
          issuingCustomerCollector ?? this.issuingCustomerCollector,
      issuingCustomer: issuingCustomer ?? this.issuingCustomer,
      receivingCustomerCardId:
          receivingCustomerCardId ?? this.receivingCustomerCardId,
      receivingCustomerCardLabel:
          receivingCustomerCardLabel ?? this.receivingCustomerCardLabel,
      receivingCustomerCardTypeId:
          receivingCustomerCardTypeId ?? this.receivingCustomerCardTypeId,
      receivingCustomerCardTypeName:
          receivingCustomerCardTypeName ?? this.receivingCustomerCardTypeName,
      receivingCustomerAccountId:
          receivingCustomerAccountId ?? this.receivingCustomerAccountId,
      receivingCustomerCollectorId:
          receivingCustomerCollectorId ?? this.receivingCustomerCollectorId,
      receivingCustomerCollector:
          receivingCustomerCollector ?? this.receivingCustomerCollector,
      receivingCustomer: receivingCustomer ?? this.receivingCustomer,
      agentId: agentId ?? this.agentId,
      agent: agent ?? this.agent,
      discardedAt: discardedAt ?? this.discardedAt,
      validatedAt: validatedAt ?? this.validatedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      TransferDetailRPC.transferId: transferId,
      TransferDetailRPC.issuingCustomerCardId: issuingCustomerCardId,
      TransferDetailRPC.issuingCustomerCardLabel: issuingCustomerCardLabel,
      TransferDetailRPC.issuingCustomerCardTypeId: issuingCustomerCardTypeId,
      TransferDetailRPC.issuingCustomerCardTypeName:
          issuingCustomerCardTypeName,
      TransferDetailRPC.issuingCustomerAccountId: issuingCustomerAccountId,
      TransferDetailRPC.issuingCustomerCollectorId: issuingCustomerCollectorId,
      TransferDetailRPC.issuingCustomerCollector: issuingCustomerCollector,
      TransferDetailRPC.issuingCustomer: issuingCustomer,
      TransferDetailRPC.receivingCustomerCardId: receivingCustomerCardId,
      TransferDetailRPC.receivingCustomerCardLabel: receivingCustomerCardLabel,
      TransferDetailRPC.receivingCustomerCardTypeId:
          receivingCustomerCardTypeId,
      TransferDetailRPC.receivingCustomerCardTypeName:
          receivingCustomerCardTypeName,
      TransferDetailRPC.receivingCustomerAccountId: receivingCustomerAccountId,
      TransferDetailRPC.receivingCustomerCollectorId:
          receivingCustomerCollectorId,
      TransferDetailRPC.receivingCustomerCollector: receivingCustomerCollector,
      TransferDetailRPC.receivingCustomer: receivingCustomer,
      TransferDetailRPC.agentId: agentId,
      TransferDetailRPC.agent: agent,
      TransferDetailRPC.validatedAt: validatedAt?.toIso8601String(),
      TransferDetailRPC.discardedAt: discardedAt?.toIso8601String(),
      TransferDetailRPC.createdAt: createdAt.toIso8601String(),
      TransferDetailRPC.updatedAt: updatedAt.toIso8601String(),
    };
  }

  factory TransferDetail.fromMap(Map<String, dynamic> map) {
    return TransferDetail(
      transferId: map[TransferDetailRPC.transferId] as int,
      issuingCustomerCardId:
          map[TransferDetailRPC.issuingCustomerCardId] as int,
      issuingCustomerCardLabel:
          map[TransferDetailRPC.issuingCustomerCardLabel] as String,
      issuingCustomerCardTypeId:
          map[TransferDetailRPC.issuingCustomerCardTypeId] as int,
      issuingCustomerCardTypeName:
          map[TransferDetailRPC.issuingCustomerCardTypeName] as String,
      issuingCustomerAccountId:
          map[TransferDetailRPC.issuingCustomerAccountId] as int,
      issuingCustomerCollectorId:
          map[TransferDetailRPC.issuingCustomerCollectorId] as int,
      issuingCustomerCollector:
          map[TransferDetailRPC.issuingCustomerCollector] as String,
      issuingCustomer: map[TransferDetailRPC.issuingCustomer] as String,
      receivingCustomerCardId:
          map[TransferDetailRPC.receivingCustomerCardId] as int,
      receivingCustomerCardLabel:
          map[TransferDetailRPC.receivingCustomerCardLabel] as String,
      receivingCustomerCardTypeId:
          map[TransferDetailRPC.receivingCustomerCardTypeId] as int,
      receivingCustomerCardTypeName:
          map[TransferDetailRPC.receivingCustomerCardTypeName] as String,
      receivingCustomerAccountId:
          map[TransferDetailRPC.receivingCustomerAccountId] as int,
      receivingCustomerCollectorId:
          map[TransferDetailRPC.receivingCustomerCollectorId] as int,
      receivingCustomerCollector:
          map[TransferDetailRPC.receivingCustomerCollector] as String,
      receivingCustomer: map[TransferDetailRPC.receivingCustomer] as String,
      agentId: map[TransferDetailRPC.agentId] as int,
      agent: map[TransferDetailRPC.agent] as String,
      validatedAt: map[TransferDetailRPC.validatedAt] != null
          ? DateTime.parse(map[TransferDetailRPC.validatedAt])
          : null,
      discardedAt: map[TransferDetailRPC.discardedAt] != null
          ? DateTime.parse(map[TransferDetailRPC.discardedAt])
          : null,
      createdAt: DateTime.parse(map[TransferDetailRPC.createdAt]),
      updatedAt: DateTime.parse(map[TransferDetailRPC.updatedAt]),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransferDetail.fromJson(String source) =>
      TransferDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TransferDetail(transferId: $transferId, issuingCustomerCardId: $issuingCustomerCardId, issuingCustomerCardLabel: $issuingCustomerCardLabel, issuingCustomerCardTypeId: $issuingCustomerCardTypeId, issuingCustomerCardTypeName: $issuingCustomerCardTypeName, issuingCustomerAccountId: $issuingCustomerAccountId, issuingCustomerCollectorId: $issuingCustomerCollectorId, issuingCustomerCollector: $issuingCustomerCollector, issuingCustomer: $issuingCustomer, receivingCustomerCardId: $receivingCustomerCardId, receivingCustomerCardLabel: $receivingCustomerCardLabel, receivingCustomerCardTypeId: $receivingCustomerCardTypeId, receivingCustomerCardTypeName: $receivingCustomerCardTypeName, receivingCustomerAccountId: $receivingCustomerAccountId, receivingCustomerCollectorId: $receivingCustomerCollectorId, receivingCustomerCollector: $receivingCustomerCollector, receivingCustomer: $receivingCustomer, agentId: $agentId, agent: $agent, validatedAt: $validatedAt, discardedAt: $discardedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant TransferDetail other) {
    if (identical(this, other)) return true;

    return other.transferId == transferId &&
        other.issuingCustomerCardId == issuingCustomerCardId &&
        other.issuingCustomerCardLabel == issuingCustomerCardLabel &&
        other.issuingCustomerCardTypeId == issuingCustomerCardTypeId &&
        other.issuingCustomerCardTypeName == issuingCustomerCardTypeName &&
        other.issuingCustomerAccountId == issuingCustomerAccountId &&
        other.issuingCustomerCollectorId == issuingCustomerCollectorId &&
        other.issuingCustomerCollector == issuingCustomerCollector &&
        other.issuingCustomer == issuingCustomer &&
        other.receivingCustomerCardId == receivingCustomerCardId &&
        other.receivingCustomerCardLabel == receivingCustomerCardLabel &&
        other.receivingCustomerCardTypeId == receivingCustomerCardTypeId &&
        other.receivingCustomerCardTypeName == receivingCustomerCardTypeName &&
        other.receivingCustomerAccountId == receivingCustomerAccountId &&
        other.receivingCustomerCollectorId == receivingCustomerCollectorId &&
        other.receivingCustomerCollector == receivingCustomerCollector &&
        other.receivingCustomer == receivingCustomer &&
        other.agentId == agentId &&
        other.agent == agent &&
        other.validatedAt == validatedAt &&
        other.discardedAt == discardedAt &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return transferId.hashCode ^
        issuingCustomerCardId.hashCode ^
        issuingCustomerCardLabel.hashCode ^
        issuingCustomerCardTypeId.hashCode ^
        issuingCustomerCardTypeName.hashCode ^
        issuingCustomerAccountId.hashCode ^
        issuingCustomerCollectorId.hashCode ^
        issuingCustomerCollector.hashCode ^
        issuingCustomer.hashCode ^
        receivingCustomerCardId.hashCode ^
        receivingCustomerCardLabel.hashCode ^
        receivingCustomerCardTypeId.hashCode ^
        receivingCustomerCardTypeName.hashCode ^
        receivingCustomerAccountId.hashCode ^
        receivingCustomerCollectorId.hashCode ^
        receivingCustomerCollector.hashCode ^
        receivingCustomer.hashCode ^
        agentId.hashCode ^
        agent.hashCode ^
        validatedAt.hashCode ^
        discardedAt.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
