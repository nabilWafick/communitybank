import 'package:communitybank/controllers/customers_categories/customers_categories.controller.dart';
import 'package:communitybank/controllers/economical_activities/economical_activities.controller.dart';
import 'package:communitybank/controllers/localities/localities.controller.dart';
import 'package:communitybank/controllers/personal_status/personal_status.controller.dart';
import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/models/data/customers_category/customers_category.model.dart';
import 'package:communitybank/models/data/economical_activity/economical_activity.model.dart';
import 'package:communitybank/models/data/locality/locality.model.dart';
import 'package:communitybank/models/data/personal_status/personal_status.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/models/tables/customer/customer_table.model.dart';
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

    List<CustomerCategory> customerCategoriesList =
        await CustomersCategoriesController.getAll().first;
    List<EconomicalActivity> economicalActivitiesList =
        await EconomicalActivitiesController.getAll().first;
    List<PersonalStatus> personalStatusList =
        await PersonalStatusController.getAll().first;
    List<Locality> localitiesList = await LocalitiesController.getAll().first;

    // yield all Customers data or an empty list
    yield* customersMapListStream.map(
      (customersMapList) => customersMapList.map(
        (customerMap) {
          CustomerCategory customerMapCategory = CustomerCategory(
            name: 'Non défini',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
          EconomicalActivity customerMapEconomicalActivity = EconomicalActivity(
            name: 'Non défini',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
          Locality customerMapLocality = Locality(
            name: 'Non défini',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
          PersonalStatus customerMapPersonalStatus = PersonalStatus(
            name: 'Non défini',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          for (CustomerCategory customerCategory in customerCategoriesList) {
            if (customerMap[CustomerTable.category] == customerCategory.id) {
              customerMapCategory = customerCategory;
            }
          }

          for (PersonalStatus personalStatus in personalStatusList) {
            if (customerMap[CustomerTable.personalStatus] ==
                personalStatus.id) {
              customerMapPersonalStatus = personalStatus;
            }
          }

          for (Locality locality in localitiesList) {
            if (customerMap[CustomerTable.locality] == locality.id) {
              customerMapLocality = locality;
            }
          }

          for (EconomicalActivity economicalActivity
              in economicalActivitiesList) {
            if (customerMap[CustomerTable.economicalActivity] ==
                economicalActivity.id) {
              customerMapEconomicalActivity = economicalActivity;
            }
          }

          return Customer(
            id: customerMap[CustomerTable.id]?.toInt(),
            name: customerMap[CustomerTable.name] ?? '',
            firstnames: customerMap[CustomerTable.firstnames] ?? '',
            phoneNumber: customerMap[CustomerTable.phoneNumber] ?? '',
            address: customerMap[CustomerTable.address] ?? '',
            profession: customerMap[CustomerTable.profession] ?? '',
            nicNumber: customerMap[CustomerTable.nciNumber]?.toInt() ?? 0,
            category: customerMapCategory,
            economicalActivity: customerMapEconomicalActivity,
            personalStatus: customerMapPersonalStatus,
            locality: customerMapLocality,
            profile: customerMap[CustomerTable.profile],
            signature: customerMap[CustomerTable.signature],
            createdAt: DateTime.parse(customerMap[CustomerTable.createdAt]),
            updatedAt: DateTime.parse(customerMap[CustomerTable.updatedAt]),
          );
        },
      ).toList(),
    );
    //.asBroadcastStream();
  }

  static Future<List<Customer>> searchCustomer({required String name}) async {
    final searchedCustomersMap =
        await CustomersService.searchCustomer(name: name);

    List<CustomerCategory> customerCategoriesList =
        await CustomersCategoriesController.getAll().first;
    List<EconomicalActivity> economicalActivitiesList =
        await EconomicalActivitiesController.getAll().first;
    List<PersonalStatus> personalStatusList =
        await PersonalStatusController.getAll().first;
    List<Locality> localitiesList = await LocalitiesController.getAll().first;

    final searchedCustomers = searchedCustomersMap.map(
      (customerMap) {
        CustomerCategory customerMapCategory = CustomerCategory(
          name: 'Non défini',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        EconomicalActivity customerMapEconomicalActivity = EconomicalActivity(
          name: 'Non défini',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        Locality customerMapLocality = Locality(
          name: 'Non défini',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        PersonalStatus customerMapPersonalStatus = PersonalStatus(
          name: 'Non défini',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        for (CustomerCategory customerCategory in customerCategoriesList) {
          if (customerMap[CustomerTable.category] == customerCategory.id) {
            customerMapCategory = customerCategory;
          }
        }

        for (PersonalStatus personalStatus in personalStatusList) {
          if (customerMap[CustomerTable.personalStatus] == personalStatus.id) {
            customerMapPersonalStatus = personalStatus;
          }
        }

        for (Locality locality in localitiesList) {
          if (customerMap[CustomerTable.locality] == locality.id) {
            customerMapLocality = locality;
          }
        }

        for (EconomicalActivity economicalActivity
            in economicalActivitiesList) {
          if (customerMap[CustomerTable.economicalActivity] ==
              economicalActivity.id) {
            customerMapEconomicalActivity = economicalActivity;
          }
        }

        return Customer(
          id: customerMap[CustomerTable.id]?.toInt(),
          name: customerMap[CustomerTable.name] ?? '',
          firstnames: customerMap[CustomerTable.firstnames] ?? '',
          phoneNumber: customerMap[CustomerTable.phoneNumber] ?? '',
          address: customerMap[CustomerTable.address] ?? '',
          profession: customerMap[CustomerTable.profession] ?? '',
          nicNumber: customerMap[CustomerTable.nciNumber]?.toInt() ?? 0,
          category: customerMapCategory,
          economicalActivity: customerMapEconomicalActivity,
          personalStatus: customerMapPersonalStatus,
          locality: customerMapLocality,
          profile: customerMap[CustomerTable.profile],
          signature: customerMap[CustomerTable.signature],
          createdAt: DateTime.parse(customerMap[CustomerTable.createdAt]),
          updatedAt: DateTime.parse(customerMap[CustomerTable.updatedAt]),
        );
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
