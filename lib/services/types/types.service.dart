import 'package:communitybank/models/data/type/type.model.dart';
import 'package:communitybank/models/tables/type/type_table.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TypesService {
  static Future<Map<String, dynamic>?> create({required Type type}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // insert data in database
      response = await supabase
          .from(TypeTable.tableName)
          .insert(
            type.toMap(),
          )
          .select<List<Map<String, dynamic>>>();
      // return the insertion result, the type data as Map<String,dynamic>
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
          .from(TypeTable.tableName)
          .select<List<Map<String, dynamic>>>()
          .eq(TypeTable.id, id);
      // return the result data
      return response.isEmpty ? null : response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Stream<List<Map<String, dynamic>>> getAll({
    required String selectedTypeStake,
    /* required int? selectedProductId,*/
  }) async* {
    final supabase = Supabase.instance.client;

    //  debugPrint('In Service');
    //  debugPrint('selectedTypeStake: $selectedTypeStake');
    try {
      // listen to Types table change and return a stream of all Types data

      var query = supabase
          .from(TypeTable.tableName)
          .stream(primaryKey: [TypeTable.id]).order(
        TypeTable.name,
        ascending: true,
      );

      // filter le list and return only Types which stakes are equal to selectedTypeStake
      if (selectedTypeStake != '*') {
        query.eq(TypeTable.stake, selectedTypeStake);
      }

      // return the result as stream
      yield* query.asBroadcastStream();
    } catch (error) {
      debugPrint(error.toString());
      yield [];
    }
  }

  static Future<List<Map<String, dynamic>>> searchType(
      {required String name}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    //  debugPrint('In Seach Service');
    //  debugPrint('name:$name');
    try {
      // get all Types which name contain "name"
      response = await supabase
          .from(TypeTable.tableName)
          .select<List<Map<String, dynamic>>>()
          .ilike(TypeTable.name, '%$name%');

      // return the result data
      return response;
    } catch (error) {
      debugPrint(error.toString());
    }

    return [];
  }

  static Stream<List<Map<String, dynamic>>> getAllTypesStakes() async* {
    final supabase = Supabase.instance.client;

    try {
      // listen to Types table change and return a stream of all Types data
      yield* supabase
          .from(TypeTable.tableName)
          .stream(primaryKey: [TypeTable.id])
          .order(
            TypeTable.stake,
            ascending: true,
          )
          .asBroadcastStream();
    } catch (error) {
      debugPrint(error.toString());
      yield [];
    }
  }

  static Future<Map<String, dynamic>?> update(
      {required int id, required Type type}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // update a specific line
      response = await supabase.from(TypeTable.tableName).update(
        {
          ...type.toMap(),
          TypeTable.updatedAt: DateTime.now().toIso8601String(),
        },
      ).match(
        {
          TypeTable.id: id,
        },
      ).select<List<Map<String, dynamic>>>();
      // return the result data
      return response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Future<Map<String, dynamic>?> delete({required Type type}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // delete a specific line
      response = await supabase
          .from(TypeTable.tableName)
          .delete()
          .match({TypeTable.id: type.id!}).select<List<Map<String, dynamic>>>();

      // return the delete line
      return response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }
}
