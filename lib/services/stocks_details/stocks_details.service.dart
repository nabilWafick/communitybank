import 'package:communitybank/models/rpc/stock_detail/stock_detail_rpc.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StocksDetailsService {
  static Future<List<Map<String, dynamic>>> getStocksDetails({
    required int? productId,
    required int? agentId,
    required int? customerCardId,
    required int? customerAccountId,
    required int? typeId,
    required String? stockType,
    required String? stockMovementDate,
  }) async {
    List<Map<String, dynamic>> response;
    final supabase = Supabase.instance.client;

    try {
      response = await supabase.rpc(
        StockDetailRPC.functionName,
        params: {
          'product_id': productId,
          'agent_id': agentId,
          'customer_card_id': customerCardId,
          'customer_account_id': customerAccountId,
          'type_id': typeId,
          'stock_type': stockType,
          'stock_movement_date': stockMovementDate,
        },
      ).select<List<Map<String, dynamic>>>();
      // return the result data

      return response;
    } catch (error) {
      // debugPrint('In RPC');
      debugPrint(error.toString());
      return [];
    }
  }
}
