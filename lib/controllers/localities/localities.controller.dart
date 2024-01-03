import 'package:communitybank/models/data/locality/locality.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/services/localities/localities.service.dart';

class LocalitiesController {
  static Future<ServiceResponse> create({required Locality locality}) async {
    final response = await LocalitiesService.create(locality: locality);
    // return response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<Locality?> getOne({required int id}) async {
    final response = await LocalitiesService.getOne(id: id);
    // return the specific customer category data or null
    return response == null ? null : Locality.fromMap(response);
  }

  static Stream<List<Locality>> getAll() async* {
    final localitiesMapListStream = LocalitiesService.getAll();

    // yield all Localitys data or an empty list
    yield* localitiesMapListStream.map(
      (localitiesMapList) => localitiesMapList
          .map(
            (localityMap) => Locality.fromMap(localityMap),
          )
          .toList(),
    );
    //.asBroadcastStream();
  }

  static Future<List<Locality>> searchLocality({required String name}) async {
    final searchedLocalitys =
        await LocalitiesService.searchLocality(name: name);

    return searchedLocalitys
        .map(
          (localityMap) => Locality.fromMap(localityMap),
        )
        .toList();
  }

  static Future<ServiceResponse> update(
      {required int id, required Locality locality}) async {
    final response = await LocalitiesService.update(
      id: id,
      locality: locality,
    );
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<ServiceResponse> delete({required Locality locality}) async {
    final response = await LocalitiesService.delete(locality: locality);
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }
}
