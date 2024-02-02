import 'package:communitybank/models/data/customers_category/customers_category.model.dart';
import 'package:communitybank/models/tables/customers_category/customers_category_table.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomersCategoriesService {
  static Future<Map<String, dynamic>?> create(
      {required CustomerCategory customerCategory}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // insert data in database
      response = await supabase
          .from(CustomerCategoryTable.tableName)
          .insert(
            customerCategory.toMap(
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
          .from(CustomerCategoryTable.tableName)
          .select<List<Map<String, dynamic>>>()
          .eq(CustomerCategoryTable.id, id);
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
      // listen to customerCategory table change and return a stream of all customerCategory data

      var query = supabase
          .from(CustomerCategoryTable.tableName)
          .stream(primaryKey: [CustomerCategoryTable.id]).order(
        CustomerCategoryTable.name,
        ascending: true,
      );

      // return the result as stream
      yield* query.asBroadcastStream();
    } catch (error) {
      debugPrint(error.toString());
      yield [];
    }
  }

  static Future<List<Map<String, dynamic>>> searchCustomerCategory(
      {required String name}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // get all customerCategories which name contain "name"
      response = await supabase
          .from(CustomerCategoryTable.tableName)
          .select<List<Map<String, dynamic>>>()
          .ilike(CustomerCategoryTable.name, '%$name%');

      // return the result data
      return response;
    } catch (error) {
      debugPrint(error.toString());
    }

    return [];
  }

  static Future<Map<String, dynamic>?> update(
      {required int id, required CustomerCategory customerCategory}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // update a specific line
      response = await supabase.from(CustomerCategoryTable.tableName).update(
        {
          ...customerCategory.toMap(
            isAdding: false,
          ),
          //  CustomerCategoryTable.updatedAt: DateTime.now().toIso8601String(),
        },
      ).match(
        {
          CustomerCategoryTable.id: id,
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
      {required CustomerCategory customerCategory}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // delete a specific line
      response = await supabase
          .from(CustomerCategoryTable.tableName)
          .delete()
          .match({CustomerCategoryTable.id: customerCategory.id!}).select<
              List<Map<String, dynamic>>>();

      // return the delete line
      return response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }
}
