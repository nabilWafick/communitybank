import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/services/collectors/collectors.service.dart';

class CollectorsController {
  static Future<ServiceResponse> create({required Collector collector}) async {
    final response = await CollectorsService.create(collector: collector);
    // return response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<Collector?> getOne({required int id}) async {
    final response = await CollectorsService.getOne(id: id);
    // return the specific collector data or null
    return response == null ? null : Collector.fromMap(response);
  }

  static Stream<List<Collector>> getAll() async* {
    final collectorsMapListStream = CollectorsService.getAll();

    // yield all collectors data or an empty list
    yield* collectorsMapListStream.map(
      (collectorsMapList) => collectorsMapList
          .map(
            (collectorMap) => Collector.fromMap(collectorMap),
          )
          .toList(),
    );
    //.asBroadcastStream();
  }

  static Future<List<Collector>> searchCollector({
    required String searchedCollectorName,
    required String searchedCollectorAddress,
    required String searchedCollectorFirstnames,
    required String searchedCollectorPhoneNumber,
  }) async {
    final searchedCollectors = await CollectorsService.searchCollector(
      searchedCollectorName: searchedCollectorName,
      searchedCollectorAddress: searchedCollectorAddress,
      searchedCollectorFirstnames: searchedCollectorFirstnames,
      searchedCollectorPhoneNumber: searchedCollectorPhoneNumber,
    );

    return searchedCollectors
        .map(
          (collectorMap) => Collector.fromMap(collectorMap),
        )
        .toList();
  }

  static Future<ServiceResponse> update(
      {required int id, required Collector collector}) async {
    final response = await CollectorsService.update(
      id: id,
      collector: collector,
    );
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<ServiceResponse> delete({required Collector collector}) async {
    final response = await CollectorsService.delete(collector: collector);
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<String?> uploadPicture(
      {required String collectorPicturePath}) async {
    final response = await CollectorsService.uploadPicture(
        collectorPicturePath: collectorPicturePath);
    // return the remote path or null
    return response;
  }

  static Future<String?> updateUploadedPicture({
    required String collectorPictureLink,
    required String newCollectorPicturePath,
  }) async {
    final response = await CollectorsService.updateUploadedPicture(
      collectorPictureLink: collectorPictureLink,
      newCollectorPicturePath: newCollectorPicturePath,
    );
    // return the remote path or null
    return response;
  }
}
