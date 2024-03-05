import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductsForecastsService {
  static Future<List<Map<String, dynamic>>> getProductsForecasts({
    required int? productId,
    required int? settlementsTotal,
    required int? collectorId,
    required int? customerAccountId,
  }) async {
    List<Map<String, dynamic>> response;
    final supabase = Supabase.instance.client;

    try {
      response = await supabase.rpc(
        'get_products_forecasts',
        params: {
          'product_id': productId,
          'settlements_total': settlementsTotal,
          'collector_id': collectorId,
          'customer_account_id': customerAccountId,
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
