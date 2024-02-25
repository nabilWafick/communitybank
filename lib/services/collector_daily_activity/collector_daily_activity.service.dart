import 'package:communitybank/models/rpc/collector_daily_activity/collector_daily_rpc.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CollectorDailyActivityService {
  static Future<List<Map<String, dynamic>>> getCollectorDailyActivity({
    required String? collectionDate,
    required int? collectorId,
  }) async {
    List<Map<String, dynamic>> response;
    final supabase = Supabase.instance.client;

    try {
      response = await supabase.rpc(
        CollectorDailyActivityRPC.functionName,
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
