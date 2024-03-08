import 'package:communitybank/models/rpc/types_total/types_total_rpc.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TypesTotalService {
  static Future<List<Map<String, dynamic>>> getTotalNumber() async {
    List<Map<String, dynamic>> response;
    final supabase = Supabase.instance.client;

    try {
      response = await supabase
          .rpc(
            TypesTotalRPC.functionName,
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
