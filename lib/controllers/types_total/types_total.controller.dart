import 'package:communitybank/models/data/types_total/types_total.model.dart';
import 'package:communitybank/services/types_total/types_total.service.dart';

class TypesTotalController {
  static Future<List<TypesTotal>> getTotalNumber() async {
    final totalNumbers = await TypesTotalService.getTotalNumber();

    return totalNumbers.map(
      (totalNumber) {
        return TypesTotal.fromMap(
          totalNumber,
        );
      },
    ).toList();
  }
}
