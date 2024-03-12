import 'package:communitybank/models/data/collectors_total/collectors_total.model.dart';
import 'package:communitybank/services/collectors_total/collectors_total.model.dart';

class CollectorsTotalController {
  static Future<List<CollectorsTotal>> getTotalNumber() async {
    final totalNumbers = await CollectorsTotalService.getTotalNumber();

    return totalNumbers.map(
      (totalNumber) {
        return CollectorsTotal.fromMap(
          totalNumber,
        );
      },
    ).toList();
  }
}
