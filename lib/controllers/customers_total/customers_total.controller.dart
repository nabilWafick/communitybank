import 'package:communitybank/models/data/customers_total/customers_total.model.dart';
import 'package:communitybank/services/customers_total/customers_total.service.dart';
import 'package:flutter/material.dart';

class CustomersTotalController {
  static Future<List<CustomersTotal>> getTotalNumber() async {
    final totalNumbers = await CustomersTotalService.getTotalNumber();

    return totalNumbers.map(
      (totalNumber) {
        debugPrint('customers controller data: $totalNumber');
        return CustomersTotal.fromMap(
          totalNumber,
        );
      },
    ).toList();
  }
}
