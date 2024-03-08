import 'package:communitybank/models/data/customers_cards_total/customers_cards_total.model.dart';
import 'package:communitybank/services/customers_cards_total/customers_cards_total.service.dart';
import 'package:flutter/material.dart';

class CustomersCardsTotalController {
  static Future<List<CustomersCardsTotal>> getTotalNumber() async {
    final totalNumbers = await CustomersCardsTotalService.getTotalNumber();

    return totalNumbers.map(
      (totalNumber) {
        debugPrint('customers cards controller data: $totalNumber');
        return CustomersCardsTotal.fromMap(
          totalNumber,
        );
      },
    ).toList();
  }
}
