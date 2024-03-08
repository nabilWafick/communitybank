import 'package:communitybank/models/data/types_total/types_total.model.dart';
import 'package:communitybank/services/types_total/types_total.service.dart';
import 'package:flutter/material.dart';

class TypesTotalController {
  static Future<List<TypesTotal>> getTotalNumber() async {
    final totalNumbers = await TypesTotalService.getTotalNumber();

    return totalNumbers.map(
      (totalNumber) {
        debugPrint('types controller data: $totalNumber');
        return TypesTotal.fromMap(
          totalNumber,
        );
      },
    ).toList();
  }
}
