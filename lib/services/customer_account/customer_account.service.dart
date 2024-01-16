import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/models/tables/customer_account/customer_account_table.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerAccountsService {
  static Future<Map<String, dynamic>?> create(
      {required CustomerAccount customerAccount}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // insert data in database
      response = await supabase
          .from(CustomerAccountTable.tableName)
          .insert(
            customerAccount.toMap(),
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
          .from(CustomerAccountTable.tableName)
          .select<List<Map<String, dynamic>>>()
          .eq(CustomerAccountTable.id, id);
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
      // listen to CustomerAccounts table change and return a stream of all CustomerAccounts data

      var query = supabase
          .from(CustomerAccountTable.tableName)
          .stream(primaryKey: [CustomerAccountTable.id]).order(
        CustomerAccountTable.id,
        ascending: true,
      );

      // return the result as stream
      yield* query.asBroadcastStream();
    } catch (error) {
      debugPrint(error.toString());
      yield [];
    }
  }

/*
  static Future<List<Map<String, dynamic>>> searchCustomerAccount(
      {required String name}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // get all CustomerAccounts which name contain "name"
      response = await supabase
              .from(CustomerAccountTable.tableName)
              .select<List<Map<String, dynamic>>>()
              .ilike(CustomerAccountTable.name, '%$name%')

          //.or(filters)
          // .ilike(CustomerAccountTable.firstnames, '%$name%');
          ;

      // return the result data
      return response;
    } catch (error) {
      debugPrint(error.toString());
    }

    return [];
  }
*/

  static Future<Map<String, dynamic>?> update(
      {required int id, required CustomerAccount customerAccount}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // update a specific line
      response = await supabase.from(CustomerAccountTable.tableName).update(
        {
          ...customerAccount.toMap(),
          CustomerAccountTable.updatedAt: DateTime.now().toIso8601String(),
        },
      ).match(
        {
          CustomerAccountTable.id: id,
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
      {required CustomerAccount customerAccount}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // delete a specific line
      response = await supabase
          .from(CustomerAccountTable.tableName)
          .delete()
          .match({CustomerAccountTable.id: customerAccount.id!}).select<
              List<Map<String, dynamic>>>();

      // return the delete line
      return response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }
}
