import 'package:communitybank/models/rpc/customers_types/customers_types_rpc.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomersTypesService {
  static Future<List<Map<String, dynamic>>> getCustomersTypes({
    required int? customerAccountId,
    required int? typeId,
  }) async {
    List<Map<String, dynamic>> response;
    final supabase = Supabase.instance.client;

    try {
      response = await supabase.rpc(
        CustomersTypesRPC.functionName,
        params: {
          'customer_account_id': customerAccountId,
          'type_id': typeId,
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
