import 'package:communitybank/models/data/collection/collection.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/services/collections/collections.service.dart';

class CollectionsController {
  static Future<ServiceResponse> create(
      {required Collection collection}) async {
    final response = await CollectionsService.create(
      collection: collection,
    );
    // return response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<Collection?> getOne({required int id}) async {
    final response = await CollectionsService.getOne(id: id);
    // return the specific Collection data or null
    return response == null ? null : Collection.fromMap(response);
  }

  static Stream<List<Collection>> getAll({
    required int? collectorId,
    required DateTime? collectedAt,
    required int? agentId,
  }) async* {
    final collectionsMapListStream = CollectionsService.getAll();

    Stream<List<Collection>> collectionsListStream =
        // yield all Collections data or an empty list
        collectionsMapListStream.map(
      (collectionsMapList) => collectionsMapList.map(
        (collectionMap) {
          return Collection.fromMap(collectionMap);
        },
      ).toList(),
    );

    if (agentId != 0) {
      collectionsListStream = collectionsListStream.map(
        (collectionList) => collectionList
            .where(
              (collection) => collection.agentId == agentId,
            )
            .toList(),
      );
    }

    if (collectorId != 0) {
      collectionsListStream = collectionsListStream.map(
        (collectionList) => collectionList
            .where(
              (collection) => collection.collectorId == collectorId,
            )
            .toList(),
      );
    }

    if (collectedAt != null) {
      collectionsListStream = collectionsListStream.map(
        (collectionList) => collectionList
            .where(
              (collection) =>
                  collection.collectedAt.year == collectedAt.year &&
                  collection.collectedAt.month == collectedAt.month &&
                  collection.collectedAt.day == collectedAt.day,
            )
            .toList(),
      );
    }

    //.asBroadcastStream();

    yield* collectionsListStream;
  }

/*
  static Future<List<Collection>> searchCollection({required String name}) async {
    final searchedCollections = await CollectionsService.searchCollection(name: name);

    return searchedCollections
        .map(
          (CollectionMap) => Collection.fromMap(CollectionMap),
        )
        .toList();
  }
  */

  static Future<ServiceResponse> update(
      {required int id, required Collection collection}) async {
    final response = await CollectionsService.update(
      id: id,
      collection: collection,
    );
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<ServiceResponse> delete(
      {required Collection collection}) async {
    final response = await CollectionsService.delete(
      collection: collection,
    );
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }
}
