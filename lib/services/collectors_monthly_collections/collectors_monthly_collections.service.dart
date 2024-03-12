import 'package:communitybank/models/rpc/collectors_monthly_collections/collectors_monthly_collections_rpc.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CollectorsMonthlyCollectionsService {
  static Future<List<Map<String, dynamic>>>
      getCollectorsMonthlyCollections() async {
    List<Map<String, dynamic>> response;
    final supabase = Supabase.instance.client;

    try {
      response = await supabase
          .rpc(
            CollectorsMonthlyCollectionsRPC.functionName,
          )
          .select<List<Map<String, dynamic>>>();
      // return the result data
      //  debugPrint('Collectors Monthly Collections Data: $response');

      return response;
    } catch (error) {
      //  debugPrint('In Collectors Monthly Collections RPC');
      debugPrint(error.toString());
      return [];
    }
  }
}
