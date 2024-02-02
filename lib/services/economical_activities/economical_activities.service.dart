import 'package:communitybank/models/data/economical_activity/economical_activity.model.dart';
import 'package:communitybank/models/tables/economical_activity/economical_activity_table.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EconomicalActivtiesService {
  static Future<Map<String, dynamic>?> create(
      {required EconomicalActivity economicalActivity}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // insert data in database
      response = await supabase
          .from(EconomicalActivityTable.tableName)
          .insert(
            economicalActivity.toMap(
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
          .from(EconomicalActivityTable.tableName)
          .select<List<Map<String, dynamic>>>()
          .eq(EconomicalActivityTable.id, id);
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
      // listen to EconomicalActivity table change and return a stream of all EconomicalActivity data

      var query = supabase
          .from(EconomicalActivityTable.tableName)
          .stream(primaryKey: [EconomicalActivityTable.id]).order(
        EconomicalActivityTable.name,
        ascending: true,
      );

      // return the result as stream
      yield* query.asBroadcastStream();
    } catch (error) {
      debugPrint(error.toString());
      yield [];
    }
  }

  static Future<List<Map<String, dynamic>>> searchEconomicalActivity(
      {required String name}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // get all economicalActivities which name contain "name"
      response = await supabase
          .from(EconomicalActivityTable.tableName)
          .select<List<Map<String, dynamic>>>()
          .ilike(EconomicalActivityTable.name, '%$name%');

      // return the result data
      return response;
    } catch (error) {
      debugPrint(error.toString());
    }

    return [];
  }

  static Future<Map<String, dynamic>?> update(
      {required int id, required EconomicalActivity economicalActivity}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // update a specific line
      response = await supabase.from(EconomicalActivityTable.tableName).update(
        {
          ...economicalActivity.toMap(
            isAdding: false,
          ),
          //  EconomicalActivityTable.updatedAt: DateTime.now().toIso8601String(),
        },
      ).match(
        {
          EconomicalActivityTable.id: id,
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
      {required EconomicalActivity economicalActivity}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // delete a specific line
      response = await supabase
          .from(EconomicalActivityTable.tableName)
          .delete()
          .match({EconomicalActivityTable.id: economicalActivity.id!}).select<
              List<Map<String, dynamic>>>();

      // return the delete line
      return response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }
}
