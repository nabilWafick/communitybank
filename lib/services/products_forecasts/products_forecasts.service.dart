import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductsForecastsService {
  static Future<List<Map<String, dynamic>>> getProductsForecasts({
    required String? collectionDate,
    required int? collectorId,
  }) async {
    List<Map<String, dynamic>> response;
    final supabase = Supabase.instance.client;

    try {
      response = await supabase.rpc(
        'get_products_forecasts',
        params: {
          'collection_date': collectionDate,
          'collector_id': collectorId,
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
