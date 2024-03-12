import 'package:communitybank/models/data/settlements_total/settlements_total.model.dart';
import 'package:communitybank/services/settlements_total/settlements_total.service.dart';

class SettlementsTotalController {
  static Future<List<SettlementsTotal>> getTotalNumber() async {
    final totalNumbers = await SettlementsTotalService.getTotalNumber();

    return totalNumbers.map(
      (totalNumber) {
        return SettlementsTotal.fromMap(
          totalNumber,
        );
      },
    ).toList();
  }
}
