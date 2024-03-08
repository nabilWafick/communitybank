import 'package:communitybank/models/data/weekly_collections/weekly_collections.model.dart';
import 'package:communitybank/services/weekly_collections/weekly_collections.service.dart';

class WeeklyCollectionsController {
  static Future<List<WeeklyCollections>> getNumber() async {
    final weeklyCollections =
        await WeeklyCollectionsService.getWeeklyCollections();

    return weeklyCollections.map(
      (weeklyCollection) {
        return WeeklyCollections.fromMap(
          weeklyCollection,
        );
      },
    ).toList();
  }
}
