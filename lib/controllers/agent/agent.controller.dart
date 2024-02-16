import 'package:communitybank/models/data/agent/agent.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/services/agent/agent.service.dart';

class AgentsController {
  static Future<ServiceResponse> create({required Agent agent}) async {
    final response = await AgentsService.create(agent: agent);
    // return response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<Agent?> getOne({required int id}) async {
    final response = await AgentsService.getOne(id: id);
    // return the specific Agent data or null
    return response == null ? null : Agent.fromMap(response);
  }

  static Future<Agent?> getOneByEmail({required String email}) async {
    final response = await AgentsService.getOneByEmail(email: email);
    // return the specific Agent data or null
    return response == null ? null : Agent.fromMap(response);
  }

  static Stream<List<Agent>> getAll() async* {
    final agentsMapListStream = AgentsService.getAll();

    // yield all Agents data or an empty list
    yield* agentsMapListStream.map(
      (agentsMapList) => agentsMapList
          .map(
            (agentMap) => Agent.fromMap(agentMap),
          )
          .toList(),
    );
    //.asBroadcastStream();
  }

  static Future<List<Agent>> searchAgent({
    required String searchedAgentName,
    required String searchedAgentFirstnames,
    required String searchedAgentEmail,
    required String searchedAgentPhoneNumber,
    required String searchedAgentAddress,
    required String searchedAgentRole,
  }) async {
    final searchedAgents = await AgentsService.searchAgent(
      searchedAgentName: searchedAgentName,
      searchedAgentFirstnames: searchedAgentFirstnames,
      searchedAgentEmail: searchedAgentEmail,
      searchedAgentPhoneNumber: searchedAgentPhoneNumber,
      searchedAgentAddress: searchedAgentAddress,
      searchedAgentRole: searchedAgentRole,
    );

    return searchedAgents
        .map(
          (agentMap) => Agent.fromMap(agentMap),
        )
        .toList();
  }

  static Future<ServiceResponse> update(
      {required int id, required Agent agent}) async {
    final response = await AgentsService.update(
      id: id,
      agent: agent,
    );
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<ServiceResponse> delete({required Agent agent}) async {
    final response = await AgentsService.delete(agent: agent);
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<String?> uploadPicture(
      {required String agentPicturePath}) async {
    final response =
        await AgentsService.uploadPicture(agentPicturePath: agentPicturePath);
    // return the remote path or null
    return response;
  }

  static Future<String?> updateUploadedPicture({
    required String agentPictureLink,
    required String newAgentPicturePath,
  }) async {
    final response = await AgentsService.updateUploadedPicture(
      agentPictureLink: agentPictureLink,
      newAgentPicturePath: newAgentPicturePath,
    );
    // return the remote path or null
    return response;
  }
}
