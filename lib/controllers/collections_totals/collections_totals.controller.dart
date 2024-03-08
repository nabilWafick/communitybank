import 'package:communitybank/models/data/collections_totals/collections_totals.model.dart';
import 'package:communitybank/services/collections_totals/collections_totals.service.dart';

class CollectionsTotalsController {
  static Future<List<CollectionsTotals>> getTotals() async {
    final totalsNumbers = await CollectionsTotalsService.getTotals();

    return totalsNumbers.map(
      (totalNumbers) {
        return CollectionsTotals.fromMap(
          totalNumbers,
        );
      },
    ).toList();
  }
}
