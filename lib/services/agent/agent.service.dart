import 'dart:io';

import 'package:communitybank/models/data/agent/agent.model.dart';
import 'package:communitybank/models/tables/agent/agent_table.model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AgentsService {
  static Future<Map<String, dynamic>?> create({required Agent agent}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // insert data in database
      response = await supabase
          .from(AgentTable.tableName)
          .insert(
            agent.toMap(),
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
          .from(AgentTable.tableName)
          .select<List<Map<String, dynamic>>>()
          .eq(AgentTable.id, id);
      // return the result data
      return response.isEmpty ? null : response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Future<Map<String, dynamic>?> getOneByEmail(
      {required String email}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // get a specific line
      response = await supabase
          .from(AgentTable.tableName)
          .select<List<Map<String, dynamic>>>()
          .eq(AgentTable.email, email);
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
      // listen to Agents table change and return a stream of all Agents data

      var query = supabase
          .from(AgentTable.tableName)
          .stream(primaryKey: [AgentTable.id]).order(
        AgentTable.id,
        ascending: true,
      );

      // return the result as stream
      yield* query.asBroadcastStream();
    } catch (error) {
      debugPrint(error.toString());
      yield [];
    }
  }

  static Future<List<Map<String, dynamic>>> searchAgent(
      {required String name}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // get all Agents which name contain "name"
      response = await supabase
              .from(AgentTable.tableName)
              .select<List<Map<String, dynamic>>>()
              .ilike(AgentTable.name, '%$name%')

          //.or(filters)
          // .ilike(AgentTable.firstnames, '%$name%');
          ;

      // return the result data
      return response;
    } catch (error) {
      debugPrint(error.toString());
    }

    return [];
  }

  static Future<Map<String, dynamic>?> update(
      {required int id, required Agent agent}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // update a specific line
      response = await supabase.from(AgentTable.tableName).update(
        {
          ...agent.toMap(),
          AgentTable.updatedAt: DateTime.now().toIso8601String(),
        },
      ).match(
        {
          AgentTable.id: id,
        },
      ).select<List<Map<String, dynamic>>>();
      // return the result data
      return response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Future<Map<String, dynamic>?> delete({required Agent agent}) async {
    List<Map<String, dynamic>>? response;
    final supabase = Supabase.instance.client;

    try {
      // delete a specific line
      response = await supabase.from(AgentTable.tableName).delete().match(
          {AgentTable.id: agent.id!}).select<List<Map<String, dynamic>>>();

      // delete the Agent's picture if it had before a picture
      if (agent.profile != null) {
        deleteUploadedPicture(agentPictureLink: agent.profile!);
      }

      // return the delete line
      return response[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Future<String?> uploadPicture(
      {required String agentPicturePath}) async {
    String? agentPictureRemotePath;
    final supabase = Supabase.instance.client;

    try {
      agentPictureRemotePath =
          await supabase.storage.from(AgentTable.tableName).upload(
                'profils/agent-${DateTime.now().millisecondsSinceEpoch}.png',
                File(agentPicturePath),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );

      return agentPictureRemotePath;
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Future<String?> updateUploadedPicture({
    required String agentPictureLink,
    required String newAgentPicturePath,
  }) async {
    // will contain the remote path of the Agent picture
    String? newAgentPictureRemotePath;
    final supabase = Supabase.instance.client;
    /*
    // substract the remote path of the last picture
    final lastAgentPictureRemotePath =
        AgentPictureLink.split('${AgentTable.tableName}/')[1];
*/
    try {
      /*
      // delete last object
      await supabase.storage
          .from(AgentTable.tableName)
          .remove([lastAgentPictureRemotePath]);
*/
      // delete the previous picture of the Agent and get the remote path
      String? lastAgentPictureRemotePath =
          await deleteUploadedPicture(agentPictureLink: agentPictureLink);

      // return the remote path of the new picture after uploading it if the last picture remote path getted is not null, else  null is returned
      if (lastAgentPictureRemotePath != null) {
        newAgentPictureRemotePath =
            await supabase.storage.from(AgentTable.tableName).upload(
                  '$lastAgentPictureRemotePath-${DateTime.now().millisecondsSinceEpoch}.png',
                  File(newAgentPicturePath),
                  fileOptions: const FileOptions(
                    cacheControl: '3600',
                    upsert: false,
                  ),
                );

        return newAgentPictureRemotePath;
      } else {
        return null;
      }
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  static Future<String?> deleteUploadedPicture({
    required String agentPictureLink,
  }) async {
    String? lastAgentPictureRemotePath;
    final supabase = Supabase.instance.client;

    try {
      // substract the remote path of the last picture
      lastAgentPictureRemotePath =
          agentPictureLink.split('${AgentTable.tableName}/')[1];

      // delete the object
      await supabase.storage
          .from(AgentTable.tableName)
          .remove([lastAgentPictureRemotePath]);

      return lastAgentPictureRemotePath.split('-')[0];
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }
}
