import 'dart:io';

import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/models/tables/product/product_table.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductsService {
  static Future<Map<String, dynamic>?> create(
      {required Product product}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // insert data in database
      response = await supabase.from(ProductTable.tableName).insert(
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
          .from(ProductTable.tableName)
          .select<List<Map<String, dynamic>>>()
          .match({ProductTable.id: id});
      // return the result data
      return response.isEmpty ? null : response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Future<List<Map<String, dynamic>>?> getAll() async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // get a specific line
      response = await supabase
          .from(ProductTable.tableName)
          .select<List<Map<String, dynamic>>>();
      debugPrint('Get All:  $response');
      // return the result data
      return response;
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Future<Map<String, dynamic>?> update(
      {required int id, required Product product}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // update a specific line
      response = await supabase.from(ProductTable.tableName).update(
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
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Future<Map<String, dynamic>?> delete({required int id}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // get a specific line
      response = await supabase
          .from(ProductTable.tableName)
          .delete()
          .match({ProductTable.id: id}).select<List<Map<String, dynamic>>>();
      // return the result data
      return response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Future<String?> uploadPicture(
      {required String productPicturePath}) async {
    String? productPictureRemotePath;
    final supabase = Supabase.instance.client;

    try {
      productPictureRemotePath =
          await supabase.storage.from(ProductTable.tableName).upload(
                'photos/produit-${DateTime.now().millisecondsSinceEpoch}.png',
                File(productPicturePath),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );

      return productPictureRemotePath;
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }
}
