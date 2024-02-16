import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/services/customers/customers.service.dart';

class CustomersController {
  static Future<ServiceResponse> create({required Customer customer}) async {
    final response = await CustomersService.create(customer: customer);
    // return response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<Customer?> getOne({required int id}) async {
    final response = await CustomersService.getOne(id: id);
    // return the specific Customer data or null
    return response == null ? null : Customer.fromMap(response);
  }

  static Stream<List<Customer>> getAll({
    required int selectedCustomerCategoryId,
    required int selectedCustomerEconomicalActivityId,
    required int selectedCustomerLocalityId,
    required int selectedCustomerPersonalStatusId,
  }) async* {
    final customersMapListStream = CustomersService.getAll(
      selectedCustomerCategoryId: selectedCustomerCategoryId,
      selectedCustomerEconomicalActivityId:
          selectedCustomerEconomicalActivityId,
      selectedCustomerLocalityId: selectedCustomerLocalityId,
      selectedCustomerPersonalStatusId: selectedCustomerPersonalStatusId,
    );

    //  debugPrint(customersMapListStream.toString());

    Stream<List<Customer>> customersListStream = customersMapListStream.map(
      (customersMapList) => customersMapList.map(
        (customerMap) {
          return Customer.fromMap(customerMap);
        },
      ).toList(),
    );
    //.asBroadcastStream();

    // filter customers based on the selected locality, economical activity, personal status and category

    /* if (selectedCustomerCategoryId != 0) {
      customersListStream = customersListStream.map(
        (customersList) => customersList
            .where(
              (customer) => customer.categoryId == selectedCustomerCategoryId,
            )
            .toList(),
      );
    }

    if (selectedCustomerEconomicalActivityId != 0) {
      customersListStream = customersListStream.map(
        (customersList) => customersList
            .where(
              (customer) =>
                  customer.economicalActivityId ==
                  selectedCustomerEconomicalActivityId,
            )
            .toList(),
      );
    }

    if (selectedCustomerPersonalStatusId != 0) {
      customersListStream = customersListStream.map(
        (customersList) => customersList
            .where(
              (customer) =>
                  customer.personalStatusId == selectedCustomerPersonalStatusId,
            )
            .toList(),
      );
    }

    if (selectedCustomerLocalityId != 0) {
      customersListStream = customersListStream.map(
        (customersList) => customersList
            .where(
              (customer) => customer.localityId == selectedCustomerLocalityId,
            )
            .toList(),
      );
    }
    */

    // yield all Customers data or an empty list
    yield* customersListStream;
  }

  static Future<List<Customer>> searchCustomer({
    required String searchedCustomerName,
    required String searchedCustomerFirstnames,
    required String searchedCustomerPhoneNumber,
    required String searchedCustomerAddress,
    required String searchedCustomerProfession,
    required String searchedCustomerNicNumber,
  }) async {
    final searchedCustomersMap = await CustomersService.searchCustomer(
      searchedCustomerName: searchedCustomerName,
      searchedCustomerFirstnames: searchedCustomerFirstnames,
      searchedCustomerPhoneNumber: searchedCustomerPhoneNumber,
      searchedCustomerAddress: searchedCustomerAddress,
      searchedCustomerProfession: searchedCustomerProfession,
      searchedCustomerNicNumber: searchedCustomerNicNumber,
    );

    final searchedCustomers = searchedCustomersMap.map(
      (customerMap) {
        return Customer.fromMap(customerMap);
      },
    ).toList();

    return searchedCustomers;
  }

  static Future<ServiceResponse> update(
      {required int id, required Customer customer}) async {
    final response = await CustomersService.update(
      id: id,
      customer: customer,
    );
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<ServiceResponse> delete({required Customer customer}) async {
    final response = await CustomersService.delete(customer: customer);
    // return the response status
    return response != null ? ServiceResponse.success : ServiceResponse.failed;
  }

  static Future<String?> uploadProfilePicture(
      {required String customerProfilePicturePath}) async {
    final response = await CustomersService.uploadProfilePicture(
      customerProfilePicturePath: customerProfilePicturePath,
    );
    // return the remote path or null
    return response;
  }

  static Future<String?> updateUploadedProfilePicture({
    required String customerProfilePictureLink,
    required String newCustomerProfilePicturePath,
  }) async {
    final response = await CustomersService.updateUploadedProfilePicture(
      customerProfilePictureLink: customerProfilePictureLink,
      newCustomerProfilePicturePath: newCustomerProfilePicturePath,
    );
    // return the remote path or null
    return response;
  }

  static Future<String?> uploadSignaturePicture(
      {required String customerSignaturePicturePath}) async {
    final response = await CustomersService.uploadSignaturePicture(
      customerSignaturePicturePath: customerSignaturePicturePath,
    );
    // return the remote path or null
    return response;
  }

  static Future<String?> updateUploadedSignaturePicture({
    required String customerSignaturePictureLink,
    required String newCustomerSignaturePicturePath,
  }) async {
    final response = await CustomersService.updateUploadedSignaturePicture(
      customerSignaturePictureLink: customerSignaturePictureLink,
      newCustomerSignaturePicturePath: newCustomerSignaturePicturePath,
    );
    // return the remote path or null
    return response;
  }
}
