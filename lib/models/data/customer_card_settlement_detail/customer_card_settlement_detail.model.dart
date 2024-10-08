// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/customer_card_settlement_detail/customer_card_settlement_detail_rpc.model.dart';

class CustomerCardSettlementDetail {
  final int customerCardId;
  final int typeId;
  final int settlementId;
  final String customerCardLabel;
  final String typeName;
  final int settlementNumber;
  final double settlementAmount;
  final String agentFirstnames;
  final String agentName;
  final DateTime settlementDate;
  final DateTime settlementEntryDate;

  CustomerCardSettlementDetail({
    required this.customerCardId,
    required this.typeId,
    required this.settlementId,
    required this.customerCardLabel,
    required this.typeName,
    required this.settlementNumber,
    required this.settlementAmount,
    required this.agentFirstnames,
    required this.agentName,
    required this.settlementDate,
    required this.settlementEntryDate,
  });

  CustomerCardSettlementDetail copyWith({
    int? customerCardId,
    int? typeId,
    int? settlementId,
    String? customerCardLabel,
    String? typeName,
    int? settlementNumber,
    double? settlementAmount,
    String? agentFirstnames,
    String? agentName,
    DateTime? settlementDate,
    DateTime? settlementEntryDate,
  }) {
    return CustomerCardSettlementDetail(
      customerCardId: customerCardId ?? this.customerCardId,
      typeId: typeId ?? this.typeId,
      settlementId: settlementId ?? this.settlementId,
      customerCardLabel: customerCardLabel ?? this.customerCardLabel,
      typeName: typeName ?? this.typeName,
      settlementNumber: settlementNumber ?? this.settlementNumber,
      settlementAmount: settlementAmount ?? this.settlementAmount,
      agentFirstnames: agentFirstnames ?? this.agentFirstnames,
      agentName: agentName ?? this.agentName,
      settlementDate: settlementDate ?? this.settlementDate,
      settlementEntryDate: settlementEntryDate ?? this.settlementEntryDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CustomerCardSettlementDetailRPC.customerCardId: customerCardId,
      CustomerCardSettlementDetailRPC.typeId: typeId,
      CustomerCardSettlementDetailRPC.settlementId: settlementId,
      CustomerCardSettlementDetailRPC.customerCardLabel: customerCardLabel,
      CustomerCardSettlementDetailRPC.typeName: typeName,
      CustomerCardSettlementDetailRPC.settlementNumber: settlementNumber,
      CustomerCardSettlementDetailRPC.settlementAmount: settlementAmount,
      CustomerCardSettlementDetailRPC.agentFirstnames: agentFirstnames,
      CustomerCardSettlementDetailRPC.agentName: agentName,
      CustomerCardSettlementDetailRPC.settlementDate:
          settlementDate.toIso8601String(),
      CustomerCardSettlementDetailRPC.settlementEntryDate:
          settlementEntryDate.toIso8601String(),
    };
  }

  factory CustomerCardSettlementDetail.fromMap(Map<String, dynamic> map) {
    return CustomerCardSettlementDetail(
      customerCardId:
          map[CustomerCardSettlementDetailRPC.customerCardId] as int,
      typeId: map[CustomerCardSettlementDetailRPC.typeId] as int,
      settlementId: map[CustomerCardSettlementDetailRPC.settlementId] as int,
      customerCardLabel:
          map[CustomerCardSettlementDetailRPC.customerCardLabel] as String,
      typeName: map[CustomerCardSettlementDetailRPC.typeName] as String,
      settlementNumber:
          map[CustomerCardSettlementDetailRPC.settlementNumber] as int,
      settlementAmount:
          map[CustomerCardSettlementDetailRPC.settlementAmount] as double,
      agentFirstnames:
          map[CustomerCardSettlementDetailRPC.agentFirstnames] as String,
      agentName: map[CustomerCardSettlementDetailRPC.agentName] as String,
      settlementDate:
          DateTime.parse(map[CustomerCardSettlementDetailRPC.settlementDate]),
      settlementEntryDate: DateTime.parse(
          map[CustomerCardSettlementDetailRPC.settlementEntryDate]),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerCardSettlementDetail.fromJson(String source) =>
      CustomerCardSettlementDetail.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'CustomerCardSettlementDetail(customerCardId: $customerCardId, typeId: $typeId, settlementId: $settlementId, customerCardLabel: $customerCardLabel, typeName: $typeName, settlementNumber: $settlementNumber, settlementAmount: $settlementAmount, agentFirstnames: $agentFirstnames, agentName: $agentName, settlementDate: $settlementDate, settlementEntryDate: $settlementEntryDate)';
  }

  @override
  bool operator ==(covariant CustomerCardSettlementDetail other) {
    if (identical(this, other)) return true;

    return other.customerCardId == customerCardId &&
        other.typeId == typeId &&
        other.settlementId == settlementId &&
        other.customerCardLabel == customerCardLabel &&
        other.typeName == typeName &&
        other.settlementNumber == settlementNumber &&
        other.settlementAmount == settlementAmount &&
        other.agentFirstnames == agentFirstnames &&
        other.agentName == agentName &&
        other.settlementDate == settlementDate &&
        other.settlementEntryDate == settlementEntryDate;
  }

  @override
  int get hashCode {
    return customerCardId.hashCode ^
        typeId.hashCode ^
        settlementId.hashCode ^
        customerCardLabel.hashCode ^
        typeName.hashCode ^
        settlementNumber.hashCode ^
        settlementAmount.hashCode ^
        agentFirstnames.hashCode ^
        agentName.hashCode ^
        settlementDate.hashCode ^
        settlementEntryDate.hashCode;
  }
}
