import 'package:communitybank/models/rpc/yearly_collections/yearly_collections_rpc.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class YearlyCollectionsService {
  static Future<List<Map<String, dynamic>>> getYearlyCollections() async {
    List<Map<String, dynamic>> response;
    final supabase = Supabase.instance.client;

    try {
      response = await supabase
          .rpc(
            YearlyCollectionsRPC.functionName,
          )
          .select<List<Map<String, dynamic>>>();
      // return the result data
      //  debugPrint('Yearly Collections Data: $response');
      return response;
    } catch (error) {
      debugPrint('In Yearly Collections RPC');
      //  debugPrint(error.toString());
      return [];
    }
  }
}
