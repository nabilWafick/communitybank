import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/models/tables/customer_card/customer_card_table.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerCardsService {
  static Future<Map<String, dynamic>?> create(
      {required CustomerCard customerCard}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // insert data in database
      response = await supabase
          .from(CustomerCardTable.tableName)
          .insert(
            customerCard.toMap(),
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
          .from(CustomerCardTable.tableName)
          .select<List<Map<String, dynamic>>>()
          .eq(CustomerCardTable.id, id);
      // return the result data
      return response.isEmpty ? null : response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Stream<List<Map<String, dynamic>>> getAll() async* {
    final supabase = Supabase.instance.client;

    try {
      // listen to CustomerCards table change and return a stream of all CustomerCards data

      var query = supabase
          .from(CustomerCardTable.tableName)
          .stream(primaryKey: [CustomerCardTable.label]).order(
        CustomerCardTable.id,
        ascending: true,
      );

      // return the result as stream
      yield* query.asBroadcastStream();
    } catch (error) {
      debugPrint(error.toString());
      yield [];
    }
  }

  static Future<List<Map<String, dynamic>>> searchCustomerCard(
      {required String label}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // get all CustomerCards which name contain "name"
      response = await supabase
              .from(CustomerCardTable.tableName)
              .select<List<Map<String, dynamic>>>()
              .ilike(CustomerCardTable.label, '%$label%')

          //.or(filters)
          // .ilike(CustomerCardTable.firstnames, '%$name%');
          ;

      // return the result data
      return response;
    } catch (error) {
      debugPrint(error.toString());
    }

    return [];
  }

  static Future<Map<String, dynamic>?> update(
      {required int id, required CustomerCard customerCard}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // update a specific line
      response = await supabase.from(CustomerCardTable.tableName).update(
        {
          ...customerCard.toMap(),
          CustomerCardTable.updatedAt: DateTime.now().toIso8601String(),
        },
      ).match(
        {
          CustomerCardTable.id: id,
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
      {required CustomerCard customerCard}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // delete a specific line
      response = await supabase
          .from(CustomerCardTable.tableName)
          .delete()
          .match({CustomerCardTable.id: customerCard.id!}).select<
              List<Map<String, dynamic>>>();

      // return the delete line
      return response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }
}
