import 'package:communitybank/models/rpc/collector_periodic_activity/collector_periodic_activity_rpc.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CollectorPeriodicActivityService {
  static Future<List<Map<String, dynamic>>> getCollectorPeriodicActivity({
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
        CollectorPeriodicActivityRPC.functionName,
        params: {
          'collection_begin_date': collectionBeginDate,
          'collection_end_date': collectionEndDate,
          'collector_id': collectorId,
          'customer_account_id': customerAccountId,
          'settlements_total': settlementsTotal,
        },
      ).select<List<Map<String, dynamic>>>();
      // return the result data
      // debugPrint('collector activity data length: ${response.length}');
      return response;
    } catch (error) {
      // debugPrint('In RPC');
      debugPrint(error.toString());
      return [];
    }
  }
}
