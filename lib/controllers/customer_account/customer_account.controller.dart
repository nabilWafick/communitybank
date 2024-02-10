import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/services/customer_account/customer_account.service.dart';

class CustomersAccountsController {
  static Future<ServiceResponse> create(
      {required CustomerAccount customerAccount}) async {
    final response =
        await CustomersAccountsService.create(customerAccount: customerAccount);
    // return response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<CustomerAccount?> getOne({required int id}) async {
    final response = await CustomersAccountsService.getOne(id: id);
    // return the specific CustomerAccount data or null
    return response == null ? null : CustomerAccount.fromMap(response);
  }

  static Stream<List<CustomerAccount>> getAll({
    required int selectedCustomerId,
    required int selectedCollectorId,
  }) async* {
    final customerAccountsMapListStream = CustomersAccountsService.getAll(
      selectedCustomerId: selectedCustomerId,
      selectedCollectorId: selectedCollectorId,
    );
    //   debugPrint('In Controller');
    // yield all CustomerAccounts data or an empty list
    yield* customerAccountsMapListStream.map(
      (customerAccountsMapList) => customerAccountsMapList.map(
        (customerAccountMap) {
          //   debugPrint(customerAccountMap.toString());
          return CustomerAccount.fromMap(customerAccountMap);
        },
      ).toList(),
    );
    //.asBroadcastStream();
  }

/*
  static Future<List<CustomerAccount>> searchCustomerAccount({required String name}) async {
    final searchedCustomerAccounts = await CustomersAccountsService.searchCustomerAccount(name: name);

    return searchedCustomerAccounts
        .map(
          (customerAccountMap) => CustomerAccount.fromMap(customerAccountMap),
        )
        .toList();
  }
  */

  static Future<ServiceResponse> update(
      {required int id, required CustomerAccount customerAccount}) async {
    final response = await CustomersAccountsService.update(
      id: id,
      customerAccount: customerAccount,
    );
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<ServiceResponse> delete(
      {required CustomerAccount customerAccount}) async {
    final response =
        await CustomersAccountsService.delete(customerAccount: customerAccount);
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }
}
