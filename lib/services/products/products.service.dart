import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/models/tables/product/product_table.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductsService {
  static Future<Map<String, dynamic>> create({required Product product}) async {
    final supabase = Supabase.instance.client;
    // insert data in database
    final response = await supabase.from(ProductTable.tableName).insert(
      {
        ProductTable.name: product.name,
        ProductTable.purchasePrice: product.purchasePrice,
        ProductTable.picture: product.picture,
        ProductTable.createdAt: product.createdAt.toIso8601String(),
        ProductTable.updatedAt: product.updatedAt.toIso8601String(),
      },
    ).select<List<Map<String, dynamic>>>();
    // return the insertion result, the poduct data as Map<String,dynamic>
    return response[0];
  }

  static Future<Map<String, dynamic>?> getOne({required int id}) async {
    final supabase = Supabase.instance.client;
    // get a specific line
    final response = await supabase
        .from(ProductTable.tableName)
        .select<List<Map<String, dynamic>>>()
        .match({ProductTable.id: id});
    // return the result data
    return response.isEmpty ? null : response[0];
  }

  static Future<List<Map<String, dynamic>>> getAll() async {
    final supabase = Supabase.instance.client;
    // get a specific line
    final response = await supabase
        .from(ProductTable.tableName)
        .select<List<Map<String, dynamic>>>();
    debugPrint('Get All:  $response');
    // return the result data
    return response;
  }

  static Future<Map<String, dynamic>> update(
      {required int id, required Product product}) async {
    final supabase = Supabase.instance.client;
    // update a specific line
    final response = await supabase.from(ProductTable.tableName).update(
      {
        ProductTable.name: product.name,
        ProductTable.purchasePrice: product.purchasePrice,
        ProductTable.picture: product.picture,
        ProductTable.createdAt: product.createdAt.toIso8601String(),
        ProductTable.updatedAt: DateTime.now().toIso8601String(),
      },
    ).match(
      {
        ProductTable.id: id,
      },
    ).select<List<Map<String, dynamic>>>();
    // return the result data
    return response[0];
  }

  static Future<Map<String, dynamic>> delete({required int id}) async {
    final supabase = Supabase.instance.client;
    // get a specific line
    final response = await supabase
        .from(ProductTable.tableName)
        .delete()
        .match({ProductTable.id: id}).select<List<Map<String, dynamic>>>();
    // return the result data
    return response[0];
  }
}
