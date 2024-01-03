import 'package:communitybank/models/data/personal_status/personal_status.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/services/personal_status/personal_status.service.dart';

class PersonalStatusController {
  static Future<ServiceResponse> create(
      {required PersonalStatus personalStatus}) async {
    final response =
        await PersonalStatusService.create(personalStatus: personalStatus);
    // return response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<PersonalStatus?> getOne({required int id}) async {
    final response = await PersonalStatusService.getOne(id: id);
    // return the specific customer category data or null
    return response == null ? null : PersonalStatus.fromMap(response);
  }

  static Stream<List<PersonalStatus>> getAll() async* {
    final personalStatusMapListStream = PersonalStatusService.getAll();

    // yield all PersonalStatuss data or an empty list
    yield* personalStatusMapListStream.map(
      (personalStatusMapList) => personalStatusMapList
          .map(
            (personalStatusMap) => PersonalStatus.fromMap(personalStatusMap),
          )
          .toList(),
    );
    //.asBroadcastStream();
  }

  static Future<List<PersonalStatus>> searchPersonalStatus(
      {required String name}) async {
    final searchedPersonalStatuss =
        await PersonalStatusService.searchPersonalStatus(name: name);

    return searchedPersonalStatuss
        .map(
          (personalStatusMap) => PersonalStatus.fromMap(personalStatusMap),
        )
        .toList();
  }

  static Future<ServiceResponse> update(
      {required int id, required PersonalStatus personalStatus}) async {
    final response = await PersonalStatusService.update(
      id: id,
      personalStatus: personalStatus,
    );
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<ServiceResponse> delete(
      {required PersonalStatus personalStatus}) async {
    final response =
        await PersonalStatusService.delete(personalStatus: personalStatus);
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }
}
