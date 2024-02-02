import 'package:communitybank/models/data/personal_status/personal_status.model.dart';
import 'package:communitybank/models/tables/personal_status/personal_status_table.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PersonalStatusService {
  static Future<Map<String, dynamic>?> create(
      {required PersonalStatus personalStatus}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // insert data in database
      response = await supabase
          .from(PersonalStatusTable.tableName)
          .insert(
            personalStatus.toMap(
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
          .from(PersonalStatusTable.tableName)
          .select<List<Map<String, dynamic>>>()
          .eq(PersonalStatusTable.id, id);
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
      // listen to PersonalStatus table change and return a stream of all PersonalStatus data

      var query = supabase
          .from(PersonalStatusTable.tableName)
          .stream(primaryKey: [PersonalStatusTable.id]).order(
        PersonalStatusTable.name,
        ascending: true,
      );

      // return the result as stream
      yield* query.asBroadcastStream();
    } catch (error) {
      debugPrint(error.toString());
      yield [];
    }
  }

  static Future<List<Map<String, dynamic>>> searchPersonalStatus(
      {required String name}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // get all personalStatus which name contain "name"
      response = await supabase
          .from(PersonalStatusTable.tableName)
          .select<List<Map<String, dynamic>>>()
          .ilike(PersonalStatusTable.name, '%$name%');

      // return the result data
      return response;
    } catch (error) {
      debugPrint(error.toString());
    }

    return [];
  }

  static Future<Map<String, dynamic>?> update(
      {required int id, required PersonalStatus personalStatus}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // update a specific line
      response = await supabase.from(PersonalStatusTable.tableName).update(
        {
          ...personalStatus.toMap(
            isAdding: false,
          ),
          //  PersonalStatusTable.updatedAt: DateTime.now().toIso8601String(),
        },
      ).match(
        {
          PersonalStatusTable.id: id,
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
      {required PersonalStatus personalStatus}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // delete a specific line
      response = await supabase
          .from(PersonalStatusTable.tableName)
          .delete()
          .match({PersonalStatusTable.id: personalStatus.id!}).select<
              List<Map<String, dynamic>>>();

      // return the delete line
      return response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }
}
