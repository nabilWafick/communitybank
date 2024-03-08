import 'package:communitybank/models/data/collectors_total/collectors_total.model.dart';
import 'package:communitybank/services/collectors_total/collectors_total.model.dart';
import 'package:flutter/material.dart';

class CollectorsTotalController {
  static Future<List<CollectorsTotal>> getTotalNumber() async {
    final totalNumbers = await CollectorsTotalService.getTotalNumber();

    return totalNumbers.map(
      (totalNumber) {
        debugPrint('collectors controller data: $totalNumber');
        return CollectorsTotal.fromMap(
          totalNumber,
        );
      },
    ).toList();
  }
}
