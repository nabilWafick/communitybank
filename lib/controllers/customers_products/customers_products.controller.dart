import 'package:communitybank/models/data/customers_products/customers_products.model.dart';
import 'package:communitybank/services/customers_products/customers_products.service.dart';

class CustomersProductsController {
  static Future<List<CustomersProducts>> getCustomersProducts({
    required int? customerAccountId,
    required int? productId,
  }) async {
    final customersProducts =
        await CustomersProductsService.getCustomersProducts(
      customerAccountId: customerAccountId,
      productId: productId,
    );

    return customersProducts
        .map(
          (customerProducts) => CustomersProducts.fromMap(
            customerProducts,
          ),
        )
        .toList();
  }
}
