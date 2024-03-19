import 'package:communitybank/models/data/transfer/transfer.model.dart';
import 'package:communitybank/models/tables/transfer/transfer_table.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TransfersService {
  static Future<Map<String, dynamic>?> create({
    required Transfer transfer,
  }) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // insert data in database
      response = await supabase
          .from(TransferTable.tableName)
          .insert(
            transfer.toMap(
              isAdding: true,
            ),
          )
          .select<List<Map<String, dynamic>>>();
      // return the insertion result, the poduct data as Map<String,dynamic>
      return response[0];
    } catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }

  static Future<Map<String, dynamic>?> getOne({required int id}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // get a specific line
      response = await supabase
          .from(TransferTable.tableName)
          .select<List<Map<String, dynamic>>>()
          .eq(
            TransferTable.id,
            id,
          );
      // return the result data
      return response.isEmpty ? null : response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Stream<List<Map<String, dynamic>>> getAll({
    required int? issuingCustomerCardId,
    required int? receivingCustomerCardId,
    required int? agentId,
  }) async* {
    final supabase = Supabase.instance.client;

    try {
      // listen to Settlements table change and return a stream of all Settlements data

      var query = supabase
          .from(TransferTable.tableName)
          .stream(primaryKey: [TransferTable.id]).order(
        TransferTable.id,
        ascending: true,
      );

      if (issuingCustomerCardId != null || issuingCustomerCardId != 0) {
        query = query.eq(
          TransferTable.issuingCustomerCardId,
          issuingCustomerCardId,
        );
      }

      if (receivingCustomerCardId != null || receivingCustomerCardId != 0) {
        query = query.eq(
          TransferTable.receivingCustomerCardId,
          issuingCustomerCardId,
        );
      }

      if (agentId != null || agentId != 0) {
        query = query.eq(
          TransferTable.agentId,
          agentId,
        );
      }

      // return the result as stream
      yield* query.asBroadcastStream();
    } catch (error) {
      debugPrint(error.toString());
      yield [];
    }
  }

  static Future<Map<String, dynamic>?> update({
    required int id,
    required Transfer transfer,
  }) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // update a specific line
      response = await supabase.from(TransferTable.tableName).update(
        {
          ...transfer.toMap(
            isAdding: false,
          ),
          //  TransferTable.updatedAt: DateTime.now().toIso8601String(),
        },
      ).match(
        {
          TransferTable.id: id,
        },
      ).select<List<Map<String, dynamic>>>();
      // return the result data
      return response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Future<Map<String, dynamic>?> delete({
    required Transfer transfer,
  }) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // delete a specific line
      response = await supabase.from(TransferTable.tableName).delete().match({
        TransferTable.id: transfer.id!
      }).select<List<Map<String, dynamic>>>();

      // return the delete line
      return response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }
}
