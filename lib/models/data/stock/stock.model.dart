// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:communitybank/models/tables/stock/stock_table.model.dart';

class Stock {
  final int? id;
  final int productId;
  final int initialQuantity;
  final int? inputedQuantity;
  final int? outputedQuantity;
  final int stockQuantity;
  final String? type;
  final int? customerCardId;
  final int agentId;
  final DateTime createdAt;
  final DateTime updatedAt;
  Stock({
    this.id,
    required this.productId,
    required this.initialQuantity,
    this.inputedQuantity,
    this.outputedQuantity,
    required this.stockQuantity,
    this.type,
    this.customerCardId,
    required this.agentId,
    required this.createdAt,
    required this.updatedAt,
  });

  Stock copyWith({
    int? id,
    int? productId,
    int? initialQuantity,
    int? inputedQuantity,
    int? outputedQuantity,
    int? stockQuantity,
    String? type,
    int? customerCardId,
    int? agentId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Stock(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      initialQuantity: initialQuantity ?? this.initialQuantity,
      inputedQuantity: inputedQuantity ?? this.inputedQuantity,
      outputedQuantity: outputedQuantity ?? this.outputedQuantity,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      type: type ?? this.type,
      customerCardId: customerCardId ?? this.customerCardId,
      agentId: agentId ?? this.agentId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap({required bool isAdding}) {
    final map = {
      StockTable.productId: productId,
      StockTable.initialQuantity: initialQuantity,
      StockTable.inputedQuantity: inputedQuantity,
      StockTable.outputedQuantity: outputedQuantity,
      StockTable.stockQuantity: stockQuantity,
      StockTable.type: type,
      StockTable.customerCardId: customerCardId,
      StockTable.agentId: agentId,
      StockTable.createdAt: createdAt.toIso8601String(),
    };
    if (!isAdding) {
      map[StockTable.createdAt] = createdAt.toIso8601String();
    }
    return map;
  }

  factory Stock.fromMap(Map<String, dynamic> map) {
    return Stock(
      id: map[StockTable.id] != null ? map[StockTable.id] as int : null,
      productId: map[StockTable.productId] as int,
      initialQuantity: map[StockTable.initialQuantity] as int,
      inputedQuantity: map[StockTable.inputedQuantity] != null
          ? map[StockTable.inputedQuantity] as int
          : null,
      outputedQuantity: map[StockTable.outputedQuantity] != null
          ? map[StockTable.outputedQuantity] as int
          : null,
      stockQuantity: map[StockTable.stockQuantity] as int,
      type:
          map[StockTable.type] != null ? map[StockTable.type] as String : null,
      customerCardId: map[StockTable.customerCardId] != null
          ? map[StockTable.customerCardId] as int
          : null,
      agentId: map[StockTable.agentId] as int,
      createdAt: DateTime.parse(map[StockTable.createdAt]),
      updatedAt: DateTime.parse(map[StockTable.updatedAt]),
    );
  }

  String toJson() => json.encode(
        toMap(
          isAdding: true,
        ),
      );

  factory Stock.fromJson(String source) =>
      Stock.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Stock(id: $id, productId: $productId, initialQuantity: $initialQuantity, inputedQuantity: $inputedQuantity, outputedQuantity: $outputedQuantity, stockQuantity: $stockQuantity, type: $type, customerCardId: $customerCardId, agentId: $agentId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Stock other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.productId == productId &&
        other.initialQuantity == initialQuantity &&
        other.inputedQuantity == inputedQuantity &&
        other.outputedQuantity == outputedQuantity &&
        other.stockQuantity == stockQuantity &&
        other.type == type &&
        other.customerCardId == customerCardId &&
        other.agentId == agentId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productId.hashCode ^
        initialQuantity.hashCode ^
        inputedQuantity.hashCode ^
        outputedQuantity.hashCode ^
        stockQuantity.hashCode ^
        type.hashCode ^
        customerCardId.hashCode ^
        agentId.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

class StockOutputType {
  static const String manual = 'Manuelle';
  static const String normal = 'Normale';
  static const String constraint = 'Contrainte';
}
