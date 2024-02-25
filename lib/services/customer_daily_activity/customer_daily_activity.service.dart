import 'package:communitybank/models/rpc/customer_daily_activity/customer_daily_activity_rpc.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerDailyActivityService {
  static Future<List<Map<String, dynamic>>> getCustomerDailyActivity({
    required String? collectionDate,
    required int? collectorId,
    required int? customerAccountId,
    required int? settlementsTotal,
  }) async {
    List<Map<String, dynamic>> response;
    final supabase = Supabase.instance.client;

    try {
      response = await supabase.rpc(
        CustomerDailyActivityRPC.functionName,
        params: {
          'collection_date': collectionDate,
          'collector_id': collectorId,
          'customer_account_id': customerAccountId,
          'settlements_total': settlementsTotal,
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
