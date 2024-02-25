import 'package:communitybank/models/rpc/collector_periodic_activity/collector_periodic_activity_rpc.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CollectorPeriodicActivityService {
  static Future<List<Map<String, dynamic>>> getCollectorPeriodicActivity({
    required String? collectionBeginDate,
    required String? collectionEndDate,
    required int? collectorId,
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
