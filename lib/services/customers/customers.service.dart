import 'dart:io';

import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/models/tables/customer/customer_table.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomersService {
  static Future<Map<String, dynamic>?> create(
      {required Customer customer}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // insert data in database
      response = await supabase
          .from(CustomerTable.tableName)
          .insert(
            customer.toMap(),
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
          .from(CustomerTable.tableName)
          .select<List<Map<String, dynamic>>>()
          .eq(CustomerTable.id, id);
      // return the result data
      return response.isEmpty ? null : response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Stream<List<Map<String, dynamic>>> getAll({
    required int? selectedCustomerCategoryId,
    required int? selectedCustomerEconomicalActivityId,
    required int? selectedCustomerLocalityId,
    required int? selectedCustomerPersonalStatusId,
  }) async* {
    final supabase = Supabase.instance.client;

    try {
      // listen to Customers table change and return a stream of all Customers data

      var query = supabase
          .from(CustomerTable.tableName)
          .stream(primaryKey: [CustomerTable.id]).order(
        CustomerTable.id,
        ascending: true,
      );

      // filter le list and return only Customers which purchase prices are equal to selectedCustomerCategoryId
      if (selectedCustomerCategoryId != 0) {
        query.eq(CustomerTable.category, selectedCustomerCategoryId);
      }

      if (selectedCustomerEconomicalActivityId != 0) {
        query.eq(CustomerTable.economicalActivity,
            selectedCustomerEconomicalActivityId);
      }

      if (selectedCustomerPersonalStatusId != 0) {
        query.eq(
            CustomerTable.personalStatus, selectedCustomerPersonalStatusId);
      }

      if (selectedCustomerLocalityId != 0) {
        query.eq(CustomerTable.locality, selectedCustomerLocalityId);
      }

      // return the result as stream
      yield* query.asBroadcastStream();
    } catch (error) {
      debugPrint(error.toString());
      yield [];
    }
  }

  static Future<List<Map<String, dynamic>>> searchCustomer(
      {required String name}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // get all Customers which name contain "name"
      response = await supabase
          .from(CustomerTable.tableName)
          .select<List<Map<String, dynamic>>>()
          .ilike(CustomerTable.name, '%$name%');

      // return the result data
      return response;
    } catch (error) {
      debugPrint(error.toString());
    }

    return [];
  }

  /* static Stream<List<Map<String, dynamic>>>
      getAllCustomersPurchasePrices() async* {
    final supabase = Supabase.instance.client;

    try {
      // listen to Customers table change and return a stream of all Customers data
      yield* supabase
          .from(CustomerTable.tableName)
          .stream(primaryKey: [CustomerTable.id])
          .order(
            CustomerTable.purchasePrice,
            ascending: true,
          )
          .asBroadcastStream();
    } catch (error) {
      debugPrint(error.toString());
      yield [];
    }
  }
*/
  static Future<Map<String, dynamic>?> update(
      {required int id, required Customer customer}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // update a specific line
      response = await supabase.from(CustomerTable.tableName).update(
        {
          ...customer.toMap(),
          CustomerTable.updatedAt: DateTime.now().toIso8601String(),
        },
      ).match(
        {
          CustomerTable.id: id,
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
      {required Customer customer}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // delete a specific line
      response = await supabase.from(CustomerTable.tableName).delete().match({
        CustomerTable.id: customer.id!
      }).select<List<Map<String, dynamic>>>();

      // delete the customer's picture if it had before a picture
      if (customer.profile != null) {
        deleteUploadedProfilePicture(
            customerProfilePictureLink: customer.profile!);
      }

      // return the delete line
      return response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Future<String?> uploadProfilePicture(
      {required String customerProfilePicturePath}) async {
    String? customerProfilePictureRemotePath;
    final supabase = Supabase.instance.client;

    try {
      customerProfilePictureRemotePath =
          await supabase.storage.from(CustomerTable.tableName).upload(
                'profils/client-${DateTime.now().millisecondsSinceEpoch}.png',
                File(customerProfilePicturePath),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );

      return customerProfilePictureRemotePath;
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Future<String?> updateUploadedProfilePicture({
    required String customerProfilePictureLink,
    required String newCustomerProfilePicturePath,
  }) async {
    // will contain the remote path of the customer picture
    String? newCustomerProfilePictureRemotePath;
    final supabase = Supabase.instance.client;
    /*
    // substract the remote path of the last picture
    final lastCustomerProfilePictureRemotePath =
        customerProfilePictureLink.split('${CustomerTable.tableName}/')[1];
*/
    try {
      /*
      // delete last object
      await supabase.storage
          .from(CustomerTable.tableName)
          .remove([lastCustomerProfilePictureRemotePath]);
*/
      // delete the previous picture of the customer and get the remote path
      String? lastCustomerProfilePictureRemotePath =
          await deleteUploadedProfilePicture(
              customerProfilePictureLink: customerProfilePictureLink);

      // return the remote path of the new picture after uploading it if the last picture remote path getted is not null, else  null is returned
      if (lastCustomerProfilePictureRemotePath != null) {
        newCustomerProfilePictureRemotePath =
            await supabase.storage.from(CustomerTable.tableName).upload(
                  '$lastCustomerProfilePictureRemotePath-${DateTime.now().millisecondsSinceEpoch}.png',
                  File(newCustomerProfilePicturePath),
                  fileOptions: const FileOptions(
                    cacheControl: '3600',
                    upsert: false,
                  ),
                );

        return newCustomerProfilePictureRemotePath;
      } else {
        return null;
      }
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Future<String?> deleteUploadedProfilePicture({
    required String customerProfilePictureLink,
  }) async {
    String? lastCustomerProfilePictureRemotePath;
    final supabase = Supabase.instance.client;

    try {
      // substract the remote path of the last picture
      lastCustomerProfilePictureRemotePath =
          customerProfilePictureLink.split('${CustomerTable.tableName}/')[1];

      // delete the object
      await supabase.storage
          .from(CustomerTable.tableName)
          .remove([lastCustomerProfilePictureRemotePath]);

      return lastCustomerProfilePictureRemotePath.split('-')[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Future<String?> uploadSignaturePicture(
      {required String customerSignaturePicturePath}) async {
    String? customerPictureRemotePath;
    final supabase = Supabase.instance.client;

    try {
      customerPictureRemotePath =
          await supabase.storage.from(CustomerTable.tableName).upload(
                'signatures/client-${DateTime.now().millisecondsSinceEpoch}.png',
                File(customerSignaturePicturePath),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );

      return customerPictureRemotePath;
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Future<String?> updateUploadedSignatureProfilePicture({
    required String customerSignaturePictureLink,
    required String newCustomerSignaturePicturePath,
  }) async {
    // will contain the remote path of the customer picture
    String? newCustomerSignaturePictureRemotePath;
    final supabase = Supabase.instance.client;
    /*
    // substract the remote path of the last picture
    final lastCustomerProfilePictureRemotePath =
        customerProfilePictureLink.split('${CustomerTable.tableName}/')[1];
*/
    try {
      /*
      // delete last object
      await supabase.storage
          .from(CustomerTable.tableName)
          .remove([lastCustomerProfilePictureRemotePath]);
*/
      // delete the previous picture of the customer and get the remote path
      String? lastCustomerProfilePictureRemotePath =
          await deleteUploadedProfilePicture(
              customerProfilePictureLink: customerSignaturePictureLink);

      // return the remote path of the new picture after uploading it if the last picture remote path getted is not null, else  null is returned
      if (lastCustomerProfilePictureRemotePath != null) {
        newCustomerSignaturePictureRemotePath =
            await supabase.storage.from(CustomerTable.tableName).upload(
                  '$lastCustomerProfilePictureRemotePath-${DateTime.now().millisecondsSinceEpoch}.png',
                  File(newCustomerSignaturePicturePath),
                  fileOptions: const FileOptions(
                    cacheControl: '3600',
                    upsert: false,
                  ),
                );

        return newCustomerSignaturePictureRemotePath;
      } else {
        return null;
      }
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Future<String?> deleteUploadedSignaturePicture({
    required String customerSignaturePictureLink,
  }) async {
    String? lastCustomerSignaturePictureRemotePath;
    final supabase = Supabase.instance.client;

    try {
      // substract the remote path of the last picture
      lastCustomerSignaturePictureRemotePath =
          customerSignaturePictureLink.split('${CustomerTable.tableName}/')[1];

      // delete the object
      await supabase.storage
          .from(CustomerTable.tableName)
          .remove([lastCustomerSignaturePictureRemotePath]);

      return lastCustomerSignaturePictureRemotePath.split('-')[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }
}
