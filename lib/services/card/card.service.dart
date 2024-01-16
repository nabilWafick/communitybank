import 'package:communitybank/models/data/card/card.model.dart';
import 'package:communitybank/models/tables/card/card_table.model.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CardsService {
  static Future<Map<String, dynamic>?> create({required Card card}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // insert data in database
      response = await supabase
          .from(CardTable.tableName)
          .insert(
            card.toMap(),
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
          .from(CardTable.tableName)
          .select<List<Map<String, dynamic>>>()
          .eq(CardTable.id, id);
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
      // listen to Cards table change and return a stream of all Cards data

      var query = supabase
          .from(CardTable.tableName)
          .stream(primaryKey: [CardTable.id]).order(
        CardTable.id,
        ascending: true,
      );

      // return the result as stream
      yield* query.asBroadcastStream();
    } catch (error) {
      debugPrint(error.toString());
      yield [];
    }
  }

  static Future<List<Map<String, dynamic>>> searchCard(
      {required String name}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // get all Cards which name contain "name"
      response = await supabase
              .from(CardTable.tableName)
              .select<List<Map<String, dynamic>>>()
              .ilike(CardTable.label, '%$name%')

          //.or(filters)
          // .ilike(CardTable.firstnames, '%$name%');
          ;

      // return the result data
      return response;
    } catch (error) {
      debugPrint(error.toString());
    }

    return [];
  }

  static Future<Map<String, dynamic>?> update(
      {required int id, required Card card}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // update a specific line
      response = await supabase.from(CardTable.tableName).update(
        {
          ...card.toMap(),
          CardTable.updatedAt: DateTime.now().toIso8601String(),
        },
      ).match(
        {
          CardTable.id: id,
        },
      ).select<List<Map<String, dynamic>>>();
      // return the result data
      return response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Future<Map<String, dynamic>?> delete({required Card card}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // delete a specific line
      response = await supabase
          .from(CardTable.tableName)
          .delete()
          .match({CardTable.id: card.id!}).select<List<Map<String, dynamic>>>();

      // return the delete line
      return response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }
}
