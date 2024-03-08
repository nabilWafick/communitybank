import 'package:communitybank/models/rpc/collectors_total/collectors_total_rpc.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CollectorsTotalService {
  static Future<List<Map<String, dynamic>>> getTotalNumber() async {
    List<Map<String, dynamic>> response;
    final supabase = Supabase.instance.client;

    try {
      response = await supabase
          .rpc(
            CollectorsTotalRPC.functionName,
          )
          .select<List<Map<String, dynamic>>>();
      // return the result data

      return response;
    } catch (error) {
      // debugPrint('In RPC');
      debugPrint(error.toString());
      return [];
    }
  }
}
