// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/rpc/stock_detail/stock_detail_rpc.model.dart';

class StockDetail {
  final int stockId;
  final int productId;
  final String product;
  final int initialQuantity;
  final int? inputedQuantity;
  final int? outputedQuantity;
  final int stockQuantity;
  final String? type;
  final int agentId;
  final String agent;
  final int? customerCardId;
  final String? customerCard;
  final int? typeId;
  final String? typeName;
  final int? customerAccountId;
  final String? customer;
  final DateTime createdAt;
  final DateTime updatedAt;
  StockDetail({
    required this.stockId,
    required this.product,
    required this.productId,
    required this.initialQuantity,
    this.inputedQuantity,
    this.outputedQuantity,
    required this.stockQuantity,
    this.type,
    required this.agentId,
    required this.agent,
    this.customerCardId,
    this.customerCard,
    this.typeId,
    this.typeName,
    this.customerAccountId,
    this.customer,
    required this.createdAt,
    required this.updatedAt,
  });

  StockDetail copyWith({
    int? stockId,
    int? productId,
    String? product,
    int? initialQuantity,
    int? inputedQuantity,
    int? outputedQuantity,
    int? stockQuantity,
    String? type,
    int? agentId,
    String? agent,
    int? customerCardId,
    String? customerCard,
    int? typeId,
    String? typeName,
    int? customerAccountId,
    String? customer,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StockDetail(
      stockId: stockId ?? this.stockId,
      productId: productId ?? this.productId,
      product: product ?? this.product,
      initialQuantity: initialQuantity ?? this.initialQuantity,
      inputedQuantity: inputedQuantity ?? this.inputedQuantity,
      outputedQuantity: outputedQuantity ?? this.outputedQuantity,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      type: type ?? this.type,
      agentId: agentId ?? this.agentId,
      agent: agent ?? this.agent,
      customerCardId: customerCardId ?? this.customerCardId,
      customerCard: customerCard ?? this.customerCard,
      typeId: typeId ?? this.typeId,
      typeName: typeName ?? this.typeName,
      customerAccountId: customerAccountId ?? this.customerAccountId,
      customer: customer ?? this.customer,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      StockDetailRPC.stockId: stockId,
      StockDetailRPC.productId: productId,
      StockDetailRPC.product: product,
      StockDetailRPC.initialQuantity: initialQuantity,
      StockDetailRPC.inputedQuantity: inputedQuantity,
      StockDetailRPC.outputedQuantity: outputedQuantity,
      StockDetailRPC.stockQuantity: stockQuantity,
      StockDetailRPC.type: type,
      StockDetailRPC.agentId: agentId,
      StockDetailRPC.agent: agent,
      StockDetailRPC.customerCardId: customerCardId,
      StockDetailRPC.customerCard: customerCard,
      StockDetailRPC.typeId: typeId,
      StockDetailRPC.typeName: typeName,
      StockDetailRPC.customerAccountId: customerAccountId,
      StockDetailRPC.customer: customer,
      StockDetailRPC.createdAt: createdAt.toIso8601String(),
      StockDetailRPC.updatedAt: updatedAt.toIso8601String(),
    };
  }

  factory StockDetail.fromMap(Map<String, dynamic> map) {
    return StockDetail(
      stockId: map[StockDetailRPC.stockId] as int,
      productId: map[StockDetailRPC.productId] as int,
      product: map[StockDetailRPC.product] as String,
      initialQuantity: map[StockDetailRPC.initialQuantity] as int,
      inputedQuantity: map[StockDetailRPC.inputedQuantity] != null
          ? map[StockDetailRPC.inputedQuantity] as int
          : null,
      outputedQuantity: map[StockDetailRPC.outputedQuantity] != null
          ? map[StockDetailRPC.outputedQuantity] as int
          : null,
      stockQuantity: map[StockDetailRPC.stockQuantity] as int,
      type: map[StockDetailRPC.type] != null
          ? map[StockDetailRPC.type] as String
          : null,
      agentId: map[StockDetailRPC.agentId] as int,
      agent: map[StockDetailRPC.agent] as String,
      customerCardId: map[StockDetailRPC.customerCardId] != null
          ? map[StockDetailRPC.customerCardId] as int
          : null,
      customerCard: map[StockDetailRPC.customerCard] != null
          ? map[StockDetailRPC.customerCard] as String
          : null,
      typeId: map[StockDetailRPC.typeId] != null
          ? map[StockDetailRPC.typeId] as int
          : null,
      typeName: map[StockDetailRPC.typeName] != null
          ? map[StockDetailRPC.typeName] as String
          : null,
      customerAccountId: map[StockDetailRPC.customerAccountId] != null
          ? map[StockDetailRPC.customerAccountId] as int
          : null,
      customer: map[StockDetailRPC.customer] != null
          ? map[StockDetailRPC.customer] as String
          : null,
      createdAt: DateTime.parse(map[StockDetailRPC.createdAt]),
      updatedAt: DateTime.parse(map[StockDetailRPC.updatedAt]),
    );
  }

  String toJson() => json.encode(toMap());

  factory StockDetail.fromJson(String source) =>
      StockDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StockDetail(stockId: $stockId, productId: $productId, product: $product,  initialQuantity: $initialQuantity, inputedQuantity: $inputedQuantity, outputedQuantity: $outputedQuantity, stockQuantity: $stockQuantity, type: $type, agentId: $agentId, agent: $agent, customerCardId: $customerCardId, customerCard: $customerCard, typeId: $typeId, typeName: $typeName, customerAccountId: $customerAccountId, customer: $customer, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant StockDetail other) {
    if (identical(this, other)) return true;

    return other.stockId == stockId &&
        other.productId == productId &&
        other.product == product &&
        other.initialQuantity == initialQuantity &&
        other.inputedQuantity == inputedQuantity &&
        other.outputedQuantity == outputedQuantity &&
        other.stockQuantity == stockQuantity &&
        other.type == type &&
        other.agentId == agentId &&
        other.agent == agent &&
        other.customerCardId == customerCardId &&
        other.customerCard == customerCard &&
        other.typeId == typeId &&
        other.typeName == typeName &&
        other.customerAccountId == customerAccountId &&
        other.customer == customer &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return stockId.hashCode ^
        productId.hashCode ^
        product.hashCode ^
        initialQuantity.hashCode ^
        inputedQuantity.hashCode ^
        outputedQuantity.hashCode ^
        stockQuantity.hashCode ^
        type.hashCode ^
        agentId.hashCode ^
        agent.hashCode ^
        customerCardId.hashCode ^
        customerCard.hashCode ^
        typeId.hashCode ^
        typeName.hashCode ^
        customerAccountId.hashCode ^
        customer.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
