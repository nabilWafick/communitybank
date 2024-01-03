import 'package:communitybank/models/data/customers_category/customers_category.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/services/customers_categories/customers_categories.service.dart';

class CustomersCategoriesController {
  static Future<ServiceResponse> create(
      {required CustomerCategory customerCategory}) async {
    final response = await CustomersCategoriesService.create(
        customerCategory: customerCategory);
    // return response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<CustomerCategory?> getOne({required int id}) async {
    final response = await CustomersCategoriesService.getOne(id: id);
    // return the specific customer category data or null
    return response == null ? null : CustomerCategory.fromMap(response);
  }

  static Stream<List<CustomerCategory>> getAll() async* {
    final customerCategorysMapListStream = CustomersCategoriesService.getAll();

    // yield all CustomerCategorys data or an empty list
    yield* customerCategorysMapListStream.map(
      (customerCategorysMapList) => customerCategorysMapList
          .map(
            (customerCategoryMap) =>
                CustomerCategory.fromMap(customerCategoryMap),
          )
          .toList(),
    );
    //.asBroadcastStream();
  }

  static Future<List<CustomerCategory>> searchCustomerCategory(
      {required String name}) async {
    final searchedCustomerCategorys =
        await CustomersCategoriesService.searchCustomerCategory(name: name);

    return searchedCustomerCategorys
        .map(
          (customerCategoryMap) =>
              CustomerCategory.fromMap(customerCategoryMap),
        )
        .toList();
  }

  static Future<ServiceResponse> update(
      {required int id, required CustomerCategory customerCategory}) async {
    final response = await CustomersCategoriesService.update(
      id: id,
      customerCategory: customerCategory,
    );
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<ServiceResponse> delete(
      {required CustomerCategory customerCategory}) async {
    final response = await CustomersCategoriesService.delete(
        customerCategory: customerCategory);
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }
}
