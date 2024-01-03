import 'package:communitybank/models/data/economical_activity/economical_activity.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/services/economical_activities/economical_activities.service.dart';

class EconomicalActivitiesController {
  static Future<ServiceResponse> create(
      {required EconomicalActivity economicalActivity}) async {
    final response = await EconomicalActivtiesService.create(
        economicalActivity: economicalActivity);
    // return response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<EconomicalActivity?> getOne({required int id}) async {
    final response = await EconomicalActivtiesService.getOne(id: id);
    // return the specific customer category data or null
    return response == null ? null : EconomicalActivity.fromMap(response);
  }

  static Stream<List<EconomicalActivity>> getAll() async* {
    final economicalActivitiesMapListStream =
        EconomicalActivtiesService.getAll();

    // yield all EconomicalActivitys data or an empty list
    yield* economicalActivitiesMapListStream.map(
      (economicalActivitiesMapList) => economicalActivitiesMapList
          .map(
            (economicalActivityMap) =>
                EconomicalActivity.fromMap(economicalActivityMap),
          )
          .toList(),
    );
    //.asBroadcastStream();
  }

  static Future<List<EconomicalActivity>> searchEconomicalActivity(
      {required String name}) async {
    final searchedEconomicalActivitys =
        await EconomicalActivtiesService.searchEconomicalActivity(name: name);

    return searchedEconomicalActivitys
        .map(
          (economicalActivityMap) =>
              EconomicalActivity.fromMap(economicalActivityMap),
        )
        .toList();
  }

  static Future<ServiceResponse> update(
      {required int id, required EconomicalActivity economicalActivity}) async {
    final response = await EconomicalActivtiesService.update(
      id: id,
      economicalActivity: economicalActivity,
    );
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<ServiceResponse> delete(
      {required EconomicalActivity economicalActivity}) async {
    final response = await EconomicalActivtiesService.delete(
        economicalActivity: economicalActivity);
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }
}
