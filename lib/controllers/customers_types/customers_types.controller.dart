import 'package:communitybank/models/data/customers_types/customers_types.model.dart';
import 'package:communitybank/services/customers_types/customers_types.service.dart';

class CustomersTypesController {
  static Future<List<CustomersTypes>> getCustomersTypes({
    required int? customerAccountId,
    required int? collectorId,
    required int? typeId,
  }) async {
    final customersTypes = await CustomersTypesService.getCustomersTypes(
      customerAccountId: customerAccountId,
      collectorId: collectorId,
      typeId: typeId,
    );

    return customersTypes.map(
      (customerTypes) {
        return CustomersTypes.fromMap(
          customerTypes,
        );
      },
    ).toList();
  }
}
