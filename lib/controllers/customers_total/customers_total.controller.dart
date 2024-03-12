import 'package:communitybank/models/data/customers_total/customers_total.model.dart';
import 'package:communitybank/services/customers_total/customers_total.service.dart';

class CustomersTotalController {
  static Future<List<CustomersTotal>> getTotalNumber() async {
    final totalNumbers = await CustomersTotalService.getTotalNumber();

    return totalNumbers.map(
      (totalNumber) {
        return CustomersTotal.fromMap(
          totalNumber,
        );
      },
    ).toList();
  }
}
