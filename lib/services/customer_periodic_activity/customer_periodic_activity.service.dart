import 'package:communitybank/models/rpc/customer_periodic_activity/customer_periodic_activity_rpc.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerPeriodicActivityService {
  static Future<List<Map<String, dynamic>>> getCustomerPeriodicActivity({
    required String? collectionBeginDate,
    required String? collectionEndDate,
    required int? collectorId,
    required int? customerAccountId,
    required int? settlementsTotal,
  }) async {
    List<Map<String, dynamic>> response;
    final supabase = Supabase.instance.client;

    try {
      response = await supabase.rpc(
        CustomerPeriodicActivityRPC.functionName,
        params: {
          'collection_begin_date': collectionBeginDate,
          'collection_end_date': collectionEndDate,
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
