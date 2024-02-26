import 'package:communitybank/models/data/customers_types/customers_types.model.dart';
import 'package:communitybank/services/customers_types/customers_types.service.dart';

class CustomersTypesController {
  static Future<List<CustomersTypes>> getCustomersTypes({
    required int? customerAccountId,
    required int? typeId,
  }) async {
    final customersTypes = await CustomersTypesService.getCustomersTypes(
      customerAccountId: customerAccountId,
      typeId: typeId,
    );

    return customersTypes
        .map(
          (customerTypes) => CustomersTypes.fromMap(
            customerTypes,
          ),
        )
        .toList();
  }
}
