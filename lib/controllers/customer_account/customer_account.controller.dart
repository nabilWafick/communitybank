import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/models/data/customer_account_detail/customer_account_detail.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/services/customers_accounts/customer_account.service.dart';

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
    // filter is done in controller because supabase stream support only one
    // filter type
    // error throws when try it

    //  debugPrint('selectedCustomerId: $selectedCustomerId');
    //  debugPrint('selectedCollectorId: $selectedCollectorId');
    final customerAccountsMapListStream = CustomersAccountsService.getAll(
        // selectedCustomerId: selectedCustomerId,
        // selectedCollectorId: selectedCollectorId,
        );
    //   debugPrint('In Controller');
    // yield all CustomerAccounts data or an empty list
    Stream<List<CustomerAccount>> customerAccountsListStream =
        customerAccountsMapListStream.map(
      (customerAccountsMapList) => customerAccountsMapList.map(
        (customerAccountMap) {
          //   debugPrint(customerAccountMap.toString());
          return CustomerAccount.fromMap(customerAccountMap);
        },
      ).toList(),
    );

    if (selectedCustomerId != 0) {
      customerAccountsListStream = customerAccountsListStream.map(
        (customerAccountsList) => customerAccountsList
            .where(
              (customerAccount) =>
                  customerAccount.customerId == selectedCustomerId,
            )
            .toList(),
      );
    }

    if (selectedCollectorId != 0) {
      customerAccountsListStream = customerAccountsListStream.map(
        (customerAccountsList) => customerAccountsList
            .where(
              (customerAccount) =>
                  customerAccount.collectorId == selectedCollectorId,
            )
            .toList(),
      );
    }

    yield* customerAccountsListStream;
  }

  static Future<List<CustomerAccountDetail>> searchCustomerAccount({
    required String? name,
  }) async {
    final searchedCustomerAccounts =
        await CustomersAccountsService.searchCustomerAccount(
      name: name,
    );

    return searchedCustomerAccounts
        .map(
          (customerAccountMap) =>
              CustomerAccountDetail.fromMap(customerAccountMap),
        )
        .toList();
  }

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
