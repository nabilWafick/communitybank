import 'package:communitybank/models/rpc/collectors_yearly_collections/collectors_yearly_collections_rpc.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CollectorsYearlyCollectionsService {
  static Future<List<Map<String, dynamic>>>
      getCollectorsYearlyCollections() async {
    List<Map<String, dynamic>> response;
    final supabase = Supabase.instance.client;

    try {
      response = await supabase
          .rpc(
            CollectorsYearlyCollectionsRPC.functionName,
          )
          .select<List<Map<String, dynamic>>>();
      // return the result data
      //  debugPrint('Collectors Yearly Collections Data: $response');

      return response;
    } catch (error) {
      //  debugPrint('In Collectors Yearly Collections RPC');
      debugPrint(error.toString());
      return [];
    }
  }
}
