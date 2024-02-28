import 'package:communitybank/models/data/collection/collection.model.dart';
import 'package:communitybank/models/tables/collection/collection_table.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CollectionsService {
  static Future<Map<String, dynamic>?> create(
      {required Collection collection}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // insert data in database
      response = await supabase
          .from(CollectionTable.tableName)
          .insert(
            collection.toMap(
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
          .from(CollectionTable.tableName)
          .select<List<Map<String, dynamic>>>()
          .eq(CollectionTable.id, id);
      // return the result data
      return response.isEmpty ? null : response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Stream<List<Map<String, dynamic>>> getAll(
      /*{
    required int? collectorId,
    required int? agentId,
  }*/
      ) async* {
    final supabase = Supabase.instance.client;

    try {
      // listen to Collections table change and return a stream of all Collections data

      var query = supabase
          .from(CollectionTable.tableName)
          .stream(primaryKey: [CollectionTable.id]).order(
        CollectionTable.collectedAt,
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
  static Future<List<Map<String, dynamic>>> searchCollection(
      {required String name}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // get all Collections which name contain "name"
      response = await supabase
              .from(CollectionTable.tableName)
              .select<List<Map<String, dynamic>>>()
              .ilike(CollectionTable.name, '%$name%')

          //.or(filters)
          // .ilike(CollectionTable.firstnames, '%$name%');
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
      {required int id, required Collection collection}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // update a specific line
      response = await supabase.from(CollectionTable.tableName).update(
        {
          ...collection.toMap(
            isAdding: false,
          ),
          //  CollectionTable.updatedAt: DateTime.now().toIso8601String(),
        },
      ).match(
        {
          CollectionTable.id: id,
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
    required Collection collection,
  }) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // delete a specific line
      response = await supabase.from(CollectionTable.tableName).delete().match({
        CollectionTable.id: collection.id!
      }).select<List<Map<String, dynamic>>>();

      // return the delete line
      return response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }
}
