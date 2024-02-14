import 'package:communitybank/models/rpc/customer_card_settlement_detail/customer_card_settlement_detail_rpc.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerCardSettlementsDetailsService {
  static Future<List<Map<String, dynamic>>> getCustomerCardSettlementsDetails({
    required int customerCardId,
  }) async {
    List<Map<String, dynamic>> response;
    final supabase = Supabase.instance.client;

    try {
      // get customer card details
      response = await supabase.rpc(
        CustomerCardSettlementDetailRPC.functionName,
        params: {
          'customer_card_id': customerCardId,
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
