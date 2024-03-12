import 'package:communitybank/models/data/monthly_collections/monthly_collections.model.dart';
import 'package:communitybank/services/monthly_collections/monthly_collections.service.dart';

class MonthlyCollectionsController {
  static Future<List<MonthlyCollections>> getMonthlyCollections() async {
    final monthlyCollections =
        await MonthlyCollectionsService.getMonthlyCollections();

    return monthlyCollections.map(
      (monthlyCollection) {
        return MonthlyCollections.fromMap(
          monthlyCollection,
        );
      },
    ).toList();
  }
}
