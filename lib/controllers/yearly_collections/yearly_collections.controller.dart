import 'package:communitybank/models/data/yearly_collections/yearly_collections.model.dart';
import 'package:communitybank/services/yearly_collections/yearly_collections.service.dart';

class YearlyCollectionsController {
  static Future<List<YearlyCollections>> getYearlyCollections() async {
    final yearlyCollections =
        await YearlyCollectionsService.getYearlyCollections();

    return yearlyCollections.map(
      (yearlyCollection) {
        return YearlyCollections.fromMap(
          yearlyCollection,
        );
      },
    ).toList();
  }
}
