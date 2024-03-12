import 'package:communitybank/models/data/collectors_weekly_collections/collectors_weekly_collections.model.dart';
import 'package:communitybank/services/collectors_weekly_collections/collectors_weekly_collections.service.dart';

class CollectorsWeeklyCollectionsController {
  static Future<List<CollectorsWeeklyCollections>>
      getCollectorsWeeklyCollections() async {
    final collectorsWeeklyCollections = await CollectorsWeeklyCollectionsService
        .getCollectorsWeeklyCollections();

    return collectorsWeeklyCollections.map(
      (collectorsWeeklyCollection) {
        return CollectorsWeeklyCollections.fromMap(
          collectorsWeeklyCollection,
        );
      },
    ).toList();
  }
}
