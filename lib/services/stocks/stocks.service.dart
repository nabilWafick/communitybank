import 'package:communitybank/models/data/stock/stock.model.dart';
import 'package:communitybank/models/tables/stock/stock_table.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StocksService {
  static Future<Map<String, dynamic>?> create({
    required Stock stock,
  }) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // insert data in database
      response = await supabase
          .from(StockTable.tableName)
          .insert(
            stock.toMap(
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
          .from(StockTable.tableName)
          .select<List<Map<String, dynamic>>>()
          .eq(StockTable.id, id);
      // return the result data
      return response.isEmpty ? null : response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Stream<List<Map<String, dynamic>>> getAll({
    required int? selectedProductId,
  }) async* {
    final supabase = Supabase.instance.client;

    try {
      // listen to Stocks table change and return a stream of all Stocks data

      var query = supabase
          .from(StockTable.tableName)
          .stream(primaryKey: [StockTable.id]).order(
        StockTable.id,
        ascending: true,
      );

      // filter le list and return only Stocks which purchase prices are equal to selectedStockPrice
      if (selectedProductId != 0 && selectedProductId != null) {
        query.eq(
          StockTable.productId,
          selectedProductId,
        );
      }

      // return the result as stream
      yield* query.asBroadcastStream();
    } catch (error) {
      debugPrint(error.toString());
      yield [];
    }
  }

  static Stream<List<Map<String, dynamic>>> getAllConstrainedOutputStock({
    required int? selectedProductId,
    required String? selectedType,
  }) async* {
    final supabase = Supabase.instance.client;

    try {
      // listen to Stocks table change and return a stream of all Stocks data

      var query = supabase
          .from(StockTable.tableName)
          .stream(primaryKey: [StockTable.id]).order(
        StockTable.id,
        ascending: true,
      );

      // filter le list and return only Stocks which purchase prices are equal to selectedStockPrice
      if (selectedProductId != 0 && selectedProductId != null) {
        query.eq(
          StockTable.productId,
          selectedProductId,
        );
      }

      if (selectedType != null) {
        query.eq(
          StockTable.type,
          selectedType,
        );
      }

      // return the result as stream
      yield* query.asBroadcastStream();
    } catch (error) {
      debugPrint(error.toString());
      yield [];
    }
  }

  static Future<Map<String, dynamic>?> update({
    required int id,
    required Stock stock,
  }) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // update a specific line
      response = await supabase.from(StockTable.tableName).update(
        {
          ...stock.toMap(
            isAdding: false,
          ),
          //  StockTable.updatedAt: DateTime.now().toIso8601String(),
        },
      ).match(
        {
          StockTable.id: id,
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
    required Stock stock,
  }) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // delete a specific line
      response = await supabase.from(StockTable.tableName).delete().match(
          {StockTable.id: stock.id!}).select<List<Map<String, dynamic>>>();

      // return the delete line
      return response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }
}
