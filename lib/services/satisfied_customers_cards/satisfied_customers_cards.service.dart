import 'package:communitybank/models/rpc/satisfied_customers_cards/satisfied_customers_cards_rpc.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SatisfiedCustomersCardsService {
  static Future<List<Map<String, dynamic>>> getSatisfiedCustomersCards({
    required String? beginDate,
    required String? endDate,
    required int? collectorId,
    required int? customerAccountId,
    required int? customerCardId,
    required int? typeId,
  }) async {
    List<Map<String, dynamic>> response;
    final supabase = Supabase.instance.client;

    try {
      response = await supabase.rpc(
        SatisfiedCustomersCardsRPC.functionName,
        params: {
          'begin_date': beginDate,
          'end_date': endDate,
          'collector_id': collectorId,
          'customer_account_id': customerAccountId,
          'customer_card_id': customerCardId,
          'type_id': typeId,
        },
      ).select<List<Map<String, dynamic>>>();
      // return the result data

      // debugPrint('transfers data: $response');
      return response;
    } catch (error) {
      // debugPrint('In RPC');
      debugPrint(error.toString());
      return [];
    }
  }
}
