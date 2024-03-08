import 'package:communitybank/models/data/products_total/products_total.model.dart';
import 'package:communitybank/services/products_total/products_total.service.dart';
import 'package:flutter/material.dart';

class ProductsTotalController {
  static Future<List<ProductsTotal>> getTotalNumber() async {
    final totalNumbers = await ProductsTotalService.getTotalNumber();

    return totalNumbers.map(
      (totalNumber) {
        debugPrint('products controller data: $totalNumber');
        return ProductsTotal.fromMap(
          totalNumber,
        );
      },
    ).toList();
  }
}
