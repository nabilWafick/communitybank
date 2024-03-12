import 'package:communitybank/models/data/customers_cards_total/customers_cards_total.model.dart';
import 'package:communitybank/services/customers_cards_total/customers_cards_total.service.dart';

class CustomersCardsTotalController {
  static Future<List<CustomersCardsTotal>> getTotalNumber() async {
    final totalNumbers = await CustomersCardsTotalService.getTotalNumber();

    return totalNumbers.map(
      (totalNumber) {
        return CustomersCardsTotal.fromMap(
          totalNumber,
        );
      },
    ).toList();
  }
}
