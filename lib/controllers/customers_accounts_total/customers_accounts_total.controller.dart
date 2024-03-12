import 'package:communitybank/models/data/customers_accounts_total/customers_accounts_total.model.dart';
import 'package:communitybank/services/customers_accounts_total/customers_accounts_total.service.dart';

class CustomersAccountsTotalController {
  static Future<List<CustomersAccountsTotal>> getTotalNumber() async {
    final totalNumbers = await CustomersAccountsTotalService.getTotalNumber();

    return totalNumbers.map(
      (totalNumber) {
        return CustomersAccountsTotal.fromMap(
          totalNumber,
        );
      },
    ).toList();
  }
}
