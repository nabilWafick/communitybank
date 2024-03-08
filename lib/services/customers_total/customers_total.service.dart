import 'package:communitybank/models/rpc/customers_total/customers_total_rpc.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomersTotalService {
  static Future<List<Map<String, dynamic>>> getTotalNumber() async {
    List<Map<String, dynamic>> response;
    final supabase = Supabase.instance.client;

    try {
      response = await supabase
          .rpc(
            CustomersTotalRPC.functionName,
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
