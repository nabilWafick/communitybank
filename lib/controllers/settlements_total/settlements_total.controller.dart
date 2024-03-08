import 'package:communitybank/models/data/settlements_total/settlements_total.model.dart';
import 'package:communitybank/services/settlements_total/settlements_total.service.dart';
import 'package:flutter/material.dart';

class SettlementsTotalController {
  static Future<List<SettlementsTotal>> getTotalNumber() async {
    final totalNumbers = await SettlementsTotalService.getTotalNumber();

    return totalNumbers.map(
      (totalNumber) {
        debugPrint('settlements controller data: $totalNumber');
        return SettlementsTotal.fromMap(
          totalNumber,
        );
      },
    ).toList();
  }
}
