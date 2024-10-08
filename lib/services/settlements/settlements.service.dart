import 'package:communitybank/models/data/settlement/settlement.model.dart';
import 'package:communitybank/models/tables/settlement/settlement_table.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettlementsService {
  static Future<Map<String, dynamic>?> create(
      {required Settlement settlement}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // insert data in database
      response = await supabase
          .from(SettlementTable.tableName)
          .insert(
            settlement.toMap(
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
          .from(SettlementTable.tableName)
          .select<List<Map<String, dynamic>>>()
          .eq(SettlementTable.id, id);
      // return the result data
      return response.isEmpty ? null : response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Future<List<Map<String, dynamic>>> getByCustomerCardId({
    required int customerCardId,
  }) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // get a specific line
      response = await supabase
          .from(SettlementTable.tableName)
          .select<List<Map<String, dynamic>>>()
          .eq(
            SettlementTable.cardId,
            customerCardId,
          );
      // return the result data
      return response;
    } catch (error) {
      debugPrint(error.toString());
    }

    return [];
  }

  static Stream<List<Map<String, dynamic>>> getAll(
      {required int? customerCardId}) async* {
    final supabase = Supabase.instance.client;

    try {
      // listen to Settlements table change and return a stream of all Settlements data

      var query = supabase
          .from(SettlementTable.tableName)
          .stream(primaryKey: [SettlementTable.id]).order(
        SettlementTable.id,
        ascending: true,
      );

      if (customerCardId != null || customerCardId != 0) {
        query = query.eq(SettlementTable.cardId, customerCardId);
      }

      // return the result as stream
      yield* query.asBroadcastStream();
    } catch (error) {
      debugPrint(error.toString());
      yield [];
    }
  }

  static Future<Map<String, dynamic>?> update(
      {required int id, required Settlement settlement}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // update a specific line
      response = await supabase.from(SettlementTable.tableName).update(
        {
          ...settlement.toMap(
            isAdding: false,
          ),
          //  SettlementTable.updatedAt: DateTime.now().toIso8601String(),
        },
      ).match(
        {
          SettlementTable.id: id,
        },
      ).select<List<Map<String, dynamic>>>();
      // return the result data
      return response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Future<Map<String, dynamic>?> delete(
      {required Settlement settlement}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // delete a specific line
      response = await supabase.from(SettlementTable.tableName).delete().match({
        SettlementTable.id: settlement.id!
      }).select<List<Map<String, dynamic>>>();

      // return the delete line
      return response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }
}
