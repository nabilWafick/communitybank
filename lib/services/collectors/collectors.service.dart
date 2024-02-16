import 'dart:io';

import 'package:communitybank/models/data/collector/collector.model.dart';
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
            collector.toMap(isAdding: true),
            /* {
          CollectorTable.name: collector.name,
          CollectorTable.purchasePrice: collector.purchasePrice,
          CollectorTable.picture: collector.picture,
          CollectorTable.createdAt: collector.createdAt.toIso8601String(),
          CollectorTable.updatedAt: collector.updatedAt.toIso8601String(),
        },*/
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

  static Stream<List<Map<String, dynamic>>> getAll() async* {
    final supabase = Supabase.instance.client;

    try {
      // listen to collectors table change and return a stream of all collectors data

      var query = supabase
          .from(CollectorTable.tableName)
          .stream(primaryKey: [CollectorTable.id]).order(
        CollectorTable.id,
        ascending: true,
      );

      // return the result as stream
      yield* query.asBroadcastStream();
    } catch (error) {
      debugPrint(error.toString());
      yield [];
    }
  }

  static Future<List<Map<String, dynamic>>> searchCollector({
    required String searchedCollectorName,
    required String searchedCollectorFirstnames,
    required String searchedCollectorPhoneNumber,
    required String searchedCollectorAddress,
  }) async {
    final supabase = Supabase.instance.client;

    try {
      var query = supabase
          .from(CollectorTable.tableName)
          .select<List<Map<String, dynamic>>>();

      if (searchedCollectorName != '') {
        query.ilike(CollectorTable.name, '%$searchedCollectorName%');
      }

      if (searchedCollectorFirstnames != '') {
        query.ilike(
            CollectorTable.firstnames, '%$searchedCollectorFirstnames%');
      }
      if (searchedCollectorPhoneNumber != '') {
        query.ilike(
            CollectorTable.phoneNumber, '%$searchedCollectorPhoneNumber%');
      }
      if (searchedCollectorAddress != '') {
        query.ilike(CollectorTable.address, '%$searchedCollectorAddress%');
      }

      // return the result data
      return await query;
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
          ...collector.toMap(isAdding: false),
          //  CollectorTable.updatedAt: DateTime.now().toIso8601String(),
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

  static Future<Map<String, dynamic>?> delete(
      {required Collector collector}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // delete a specific line
      response = await supabase.from(CollectorTable.tableName).delete().match({
        CollectorTable.id: collector.id!
      }).select<List<Map<String, dynamic>>>();

      // delete the collector's picture if it had before a picture
      if (collector.profile != null) {
        deleteUploadedPicture(collectorPictureLink: collector.profile!);
      }

      // return the delete line
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
                'profils/collecteur-${DateTime.now().millisecondsSinceEpoch}.png',
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
    String? newcollectorPictureRemotePath;
    final supabase = Supabase.instance.client;
    /*
    // substract the remote path of the last picture
    final lastcollectorPictureRemotePath =
        collectorPictureLink.split('${CollectorTable.tableName}/')[1];
*/
    try {
      /*
      // delete last object
      await supabase.storage
          .from(CollectorTable.tableName)
          .remove([lastcollectorPictureRemotePath]);
*/
      // delete the previous picture of the collector and get the remote path
      String? lastcollectorPictureRemotePath = await deleteUploadedPicture(
          collectorPictureLink: collectorPictureLink);

      // return the remote path of the new picture after uploading it if the last picture remote path getted is not null, else  null is returned
      if (lastcollectorPictureRemotePath != null) {
        newcollectorPictureRemotePath =
            await supabase.storage.from(CollectorTable.tableName).upload(
                  '$lastcollectorPictureRemotePath-${DateTime.now().millisecondsSinceEpoch}.png',
                  File(newCollectorPicturePath),
                  fileOptions: const FileOptions(
                    cacheControl: '3600',
                    upsert: false,
                  ),
                );

        return newcollectorPictureRemotePath;
      } else {
        return null;
      }
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Future<String?> deleteUploadedPicture({
    required String collectorPictureLink,
  }) async {
    String? lastcollectorPictureRemotePath;
    final supabase = Supabase.instance.client;

    try {
      // substract the remote path of the last picture
      lastcollectorPictureRemotePath =
          collectorPictureLink.split('${CollectorTable.tableName}/')[1];

      // delete the object
      await supabase.storage
          .from(CollectorTable.tableName)
          .remove([lastcollectorPictureRemotePath]);

      return lastcollectorPictureRemotePath.split('-')[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }
}
