import 'package:communitybank/models/rpc/transfer_detail/transfer_detail_rpc.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TransfersDetailsService {
  static Future<List<Map<String, dynamic>>> getTransfersDetails({
    required int? agentId,
    required String? creationDate,
    required String? validationDate,
    required String? discardationDate,
    required int? issuingCustomerCardId,
    required int? issuingCustomerCardTypeId,
    required int? issuingCustomerAccountId,
    required int? issuingCustomerCollectorId,
    required int? receivingCustomerCardId,
    required int? receivingCustomerCardTypeId,
    required int? receivingCustomerAccountId,
    required int? receivingCustomerCollectorId,
  }) async {
    List<Map<String, dynamic>> response;
    final supabase = Supabase.instance.client;

    try {
      response = await supabase.rpc(TransferDetailRPC.functionName, params: {
        'agent_id': agentId,
        'creation_date': creationDate,
        'validation_date': validationDate,
        'discardation_date': discardationDate,
        'issuing_customer_card_id': issuingCustomerCardId,
        'issuing_customer_card_type_id': issuingCustomerCardTypeId,
        'issuing_customer_account_id': issuingCustomerAccountId,
        'issuing_customer_collector_id': issuingCustomerCollectorId,
        'receiving_customer_card_id': receivingCustomerCardId,
        'receiving_customer_card_type_id': receivingCustomerCardTypeId,
        'receiving_customer_account_id': receivingCustomerAccountId,
        'receiving_customer_collector_id': receivingCustomerCollectorId,
      }).select<List<Map<String, dynamic>>>();
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
