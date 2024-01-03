import 'package:communitybank/models/data/locality/locality.model.dart';
import 'package:communitybank/models/tables/locality/locality_table.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LocalitiesService {
  static Future<Map<String, dynamic>?> create(
      {required Locality locality}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // insert data in database
      response = await supabase
          .from(LocalityTable.tableName)
          .insert(
            locality.toMap(),
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
          .from(LocalityTable.tableName)
          .select<List<Map<String, dynamic>>>()
          .eq(LocalityTable.id, id);
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
      // listen to Locality table change and return a stream of all Locality data

      var query = supabase
          .from(LocalityTable.tableName)
          .stream(primaryKey: [LocalityTable.id]).order(
        LocalityTable.id,
        ascending: true,
      );

      // return the result as stream
      yield* query.asBroadcastStream();
    } catch (error) {
      debugPrint(error.toString());
      yield [];
    }
  }

  static Future<List<Map<String, dynamic>>> searchLocality(
      {required String name}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // get all localities which name contain "name"
      response = await supabase
          .from(LocalityTable.tableName)
          .select<List<Map<String, dynamic>>>()
          .ilike(LocalityTable.name, '%$name%');

      // return the result data
      return response;
    } catch (error) {
      debugPrint(error.toString());
    }

    return [];
  }

  static Future<Map<String, dynamic>?> update(
      {required int id, required Locality locality}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // update a specific line
      response = await supabase.from(LocalityTable.tableName).update(
        {
          ...locality.toMap(),
          LocalityTable.updatedAt: DateTime.now().toIso8601String(),
        },
      ).match(
        {
          LocalityTable.id: id,
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
      {required Locality locality}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // delete a specific line
      response = await supabase.from(LocalityTable.tableName).delete().match({
        LocalityTable.id: locality.id!
      }).select<List<Map<String, dynamic>>>();

      // return the delete line
      return response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }
}
