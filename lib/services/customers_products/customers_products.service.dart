import 'package:communitybank/models/rpc/customers_products/customers_products_rpc.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomersProductsService {
  static Future<List<Map<String, dynamic>>> getCustomersProducts({
    required int? customerAccountId,
    required int? productId,
  }) async {
    List<Map<String, dynamic>> response;
    final supabase = Supabase.instance.client;

    try {
      response = await supabase.rpc(
        CustomersProductsRPC.functionName,
        params: {
          'customer_account_id': customerAccountId,
          'product_id': productId,
        },
      ).select<List<Map<String, dynamic>>>();
      // return the result data
      return response;
    } catch (error) {
      debugPrint(error.toString());
      return [];
    }
  }
}
