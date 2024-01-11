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
    required int? selectedCustomerCategoryId,
    required int? selectedCustomerEconomicalActivityId,
    required int? selectedCustomerLocalityId,
    required int? selectedCustomerPersonalStatusId,
  }) async* {
    final customersMapListStream = CustomersService.getAll(
      selectedCustomerCategoryId: selectedCustomerCategoryId,
      selectedCustomerEconomicalActivityId:
          selectedCustomerEconomicalActivityId,
      selectedCustomerLocalityId: selectedCustomerLocalityId,
      selectedCustomerPersonalStatusId: selectedCustomerPersonalStatusId,
    );

    // yield all Customers data or an empty list
    yield* customersMapListStream.map(
      (customersMapList) => customersMapList
          .map(
            (customerMap) => Customer.fromMap(customerMap),
          )
          .toList(),
    );
    //.asBroadcastStream();
  }

  static Future<List<Customer>> searchCustomer({required String name}) async {
    final searchedCustomers = await CustomersService.searchCustomer(name: name);

    return searchedCustomers
        .map(
          (customerMap) => Customer.fromMap(customerMap),
        )
        .toList();
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

  static Future<String?> updateUploadedSignatureProfilePicture({
    required String customerSignaturePictureLink,
    required String newCustomerSignaturePicturePath,
  }) async {
    final response =
        await CustomersService.updateUploadedSignatureProfilePicture(
      customerSignaturePictureLink: customerSignaturePictureLink,
      newCustomerSignaturePicturePath: newCustomerSignaturePicturePath,
    );
    // return the remote path or null
    return response;
  }
}
