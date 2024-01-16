import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/services/customer_account/customer_account.service.dart';

class CustomerAccountsController {
  static Future<ServiceResponse> create(
      {required CustomerAccount customerAccount}) async {
    final response =
        await CustomerAccountsService.create(customerAccount: customerAccount);
    // return response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<CustomerAccount?> getOne({required int id}) async {
    final response = await CustomerAccountsService.getOne(id: id);
    // return the specific CustomerAccount data or null
    return response == null ? null : CustomerAccount.fromMap(response);
  }

  static Stream<List<CustomerAccount>> getAll() async* {
    final customerAccountsMapListStream = CustomerAccountsService.getAll();

    // yield all CustomerAccounts data or an empty list
    yield* customerAccountsMapListStream.map(
      (customerAccountsMapList) => customerAccountsMapList
          .map(
            (customerAccountMap) => CustomerAccount.fromMap(customerAccountMap),
          )
          .toList(),
    );
    //.asBroadcastStream();
  }

/*
  static Future<List<CustomerAccount>> searchCustomerAccount({required String name}) async {
    final searchedCustomerAccounts = await CustomerAccountsService.searchCustomerAccount(name: name);

    return searchedCustomerAccounts
        .map(
          (customerAccountMap) => CustomerAccount.fromMap(customerAccountMap),
        )
        .toList();
  }
  */

  static Future<ServiceResponse> update(
      {required int id, required CustomerAccount customerAccount}) async {
    final response = await CustomerAccountsService.update(
      id: id,
      customerAccount: customerAccount,
    );
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<ServiceResponse> delete(
      {required CustomerAccount customerAccount}) async {
    final response =
        await CustomerAccountsService.delete(customerAccount: customerAccount);
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }
}
