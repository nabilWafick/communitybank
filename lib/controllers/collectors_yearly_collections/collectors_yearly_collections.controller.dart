import 'package:communitybank/models/data/collectors_yearly_collections/collectors_yearly_collections.model.dart';
import 'package:communitybank/services/collectors_yearly_collections/collectors_yearly_collections.service.dart';

class CollectorsYearlyCollectionsController {
  static Future<List<CollectorsYearlyCollections>>
      getCollectorsYearlyCollections() async {
    final collectorsYearlyCollections = await CollectorsYearlyCollectionsService
        .getCollectorsYearlyCollections();

    return collectorsYearlyCollections.map(
      (collectorsYearlyCollection) {
        return CollectorsYearlyCollections.fromMap(
          collectorsYearlyCollection,
        );
      },
    ).toList();
  }
}
