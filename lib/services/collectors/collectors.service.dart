import 'dart:io';

import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/models/tables/collector/collector_table.model.dart';
import 'package:communitybank/models/tables/collector/collector_table.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CollectorsService {
  static Future<Map<String, dynamic>?> create(
      {required Collector collector}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // insert data in database
      response = await supabase
          .from(CollectorTable.tableName)
          .insert(
            collector.toMap(),
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
          .from(CollectorTable.tableName)
          .select<List<Map<String, dynamic>>>()
          .eq(CollectorTable.id, id);
      // return the result data
      return response.isEmpty ? null : response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Stream<List<Map<String, dynamic>>> getAll(
      /*{required String selectedcollectorPrice}*/) async* {
    final supabase = Supabase.instance.client;

    try {
      // listen to collectors table change and return a stream of all collectors data

      var query = supabase
          .from(CollectorTable.tableName)
          .stream(primaryKey: [CollectorTable.id]).order(
        CollectorTable.id,
        ascending: true,
      );

      /*  // filter le list and return only collectors which purchase prices are equal to selectedcollectorPrice
      if (selectedcollectorPrice != '*') {
        query.eq(CollectorTable.firstnames, selectedcollectorPrice);
      }*/

      // return the result as stream
      yield* query.asBroadcastStream();
    } catch (error) {
      debugPrint(error.toString());
      yield [];
    }
  }

  static Future<List<Map<String, dynamic>>> searchCollector(
      {required String name}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // get a specific line
      response = await supabase
          .from(CollectorTable.tableName)
          .select<List<Map<String, dynamic>>>()
          .ilike(CollectorTable.name, '%$name%')
          .ilike(CollectorTable.firstnames, '%$name');

      // return the result data
      return response;
    } catch (error) {
      debugPrint(error.toString());
    }

    return [];
  }

  static Future<Map<String, dynamic>?> update(
      {required int id, required Collector collector}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // update a specific line
      response = await supabase.from(CollectorTable.tableName).update(
        {
          CollectorTable.name: collector.name,
          CollectorTable.firstnames: collector.firstnames,
          CollectorTable.phoneNumber: collector.phoneNumber,
          CollectorTable.address: collector.address,
          CollectorTable.profile: collector.profile,
          CollectorTable.createdAt: collector.createdAt.toIso8601String(),
          CollectorTable.updatedAt: DateTime.now().toIso8601String(),
        },
      ).match(
        {
          CollectorTable.id: id,
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
          .from(CollectorTable.tableName)
          .delete()
          .match({CollectorTable.id: id}).select<List<Map<String, dynamic>>>();
      // return the result data
      return response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Future<String?> uploadPicture(
      {required String collectorPicturePath}) async {
    String? collectorPictureRemotePath;
    final supabase = Supabase.instance.client;

    try {
      collectorPictureRemotePath =
          await supabase.storage.from(CollectorTable.tableName).upload(
                'profils/Collecteur-${DateTime.now().millisecondsSinceEpoch}.png',
                File(collectorPicturePath),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );

      return collectorPictureRemotePath;
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Future<String?> updateUploadedPicture({
    required String collectorPictureLink,
    required String newCollectorPicturePath,
  }) async {
    // will contain the remote path of the collector picture
    String? newCollectorPictureRemotePath;
    final supabase = Supabase.instance.client;

    // substract the remote path of the last picture
    final lastCollectorPictureRemotePath =
        collectorPictureLink.split('${CollectorTable.tableName}/')[1];

    try {
      // delete last object
      await supabase.storage
          .from(CollectorTable.tableName)
          .remove([lastCollectorPictureRemotePath]);

      newCollectorPictureRemotePath =
          await supabase.storage.from(CollectorTable.tableName).upload(
                lastCollectorPictureRemotePath,
                File(newCollectorPicturePath),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );

      debugPrint(
          'newCollectorPictureRemotePath: $newCollectorPictureRemotePath');

      return newCollectorPictureRemotePath;
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }
}
