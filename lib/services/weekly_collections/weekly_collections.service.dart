import 'package:communitybank/models/rpc/weekly_collections/weekly_collections_rpc.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WeeklyCollectionsService {
  static Future<List<Map<String, dynamic>>> getWeeklyCollections() async {
    List<Map<String, dynamic>> response;
    final supabase = Supabase.instance.client;

    try {
      response = await supabase
          .rpc(
            WeeklyCollectionsRPC.functionName,
          )
          .select<List<Map<String, dynamic>>>();
      // return the result data
      // debugPrint('Weekly Collections Data: $response');
      return response;
    } catch (error) {
      //   debugPrint('In Weekly Collections RPC');
      debugPrint(error.toString());
      return [];
    }
  }
}
