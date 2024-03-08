import 'package:communitybank/models/data/collectors_monthly_collections/collectors_monthly_collections.model.dart';
import 'package:communitybank/services/collectors_monthly_collections/collectors_monthly_collections.service.dart';

class CollectorsMonthlyCollectionsController {
  static Future<List<CollectorsMonthlyCollections>> getNumber() async {
    final collectorsMonthlyCollections =
        await CollectorsMonthlyCollectionsService
            .getCollectorsMonthlyCollections();

    return collectorsMonthlyCollections.map(
      (collectorsMonthlyCollection) {
        return CollectorsMonthlyCollections.fromMap(
          collectorsMonthlyCollection,
        );
      },
    ).toList();
  }
}
