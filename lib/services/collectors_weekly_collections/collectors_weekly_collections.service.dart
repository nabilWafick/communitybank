import 'package:communitybank/models/rpc/collectors_weekly_collections/collectors_weekly_collections_rpc.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CollectorsWeeklyCollectionsService {
  static Future<List<Map<String, dynamic>>>
      getCollectorsWeeklyCollections() async {
    List<Map<String, dynamic>> response;
    final supabase = Supabase.instance.client;

    try {
      response = await supabase
          .rpc(
            CollectorsWeeklyCollectionsRPC.functionName,
          )
          .select<List<Map<String, dynamic>>>();
      // return the result data
      //  debugPrint('Collectors Weekly Collections Data: $response');
      return response;
    } catch (error) {
      // debugPrint('In Collectors Weekly Collections RPC');
      debugPrint(error.toString());
      return [];
    }
  }
}
