import 'package:communitybank/models/rpc/collections_totals/collections_totals_rpc.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CollectionsTotalsService {
  static Future<List<Map<String, dynamic>>> getTotals() async {
    List<Map<String, dynamic>> response;
    final supabase = Supabase.instance.client;

    try {
      response = await supabase
          .rpc(
            CollectionsTotalsRPC.functionName,
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
