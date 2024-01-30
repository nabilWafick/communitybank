// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/customers/customers.controller.dart';
import 'package:communitybank/controllers/forms/validators/customer/customer.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/utils/constants/constants.util.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/customer_category/customer_category_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/economical_activity/economical_activity_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/locality/locality_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/personal_status/personal_status_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerCRUDFunctions {
  static Future<void> create({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      final customerProfilePicture = ref.watch(customerProfilePictureProvider);
      final customerSignaturePicture =
          ref.watch(customerSignaturePictureProvider);
      showValidatedButton.value = false;
      final customerName = ref.watch(customerNameProvider);
      final customerFirstnames = ref.watch(customerFirstnamesProvider);
      final customerPhoneNumber = ref.watch(customerPhoneNumberProvider);
      final customerAddress = ref.watch(customerAddressProvider);
      final customerProfession = ref.watch(customerProfessionProvider);
      final customerNicNumber = ref.watch(customerNicNumberProvider);
      final customerCategory = ref.watch(formCustomerCategoryDropdownProvider(
          'customer-adding-form-category'));
      final customerPersonalStatus = ref.watch(
          formPersonalStatusDropdownProvider(
              'customer-adding-form-personal-status'));
      final customerEconomicalActivity = ref.watch(
          formEconomicalActivityDropdownProvider(
              'customer-adding-form-economical-activity'));
      final customerLocality = ref
          .watch(formLocalityDropdownProvider('customer-adding-form-locality'));

      ServiceResponse customerStatus = ServiceResponse.waiting;

      if (customerProfilePicture == null || customerSignaturePicture == null) {
        if (customerProfilePicture == null &&
            customerSignaturePicture == null) {
          final customer = Customer(
            name: customerName,
            firstnames: customerFirstnames,
            phoneNumber: customerPhoneNumber,
            address: customerAddress,
            profession: customerProfession,
            nicNumber: customerNicNumber,
            categoryId: customerCategory.id,
            economicalActivityId: customerEconomicalActivity.id,
            personalStatusId: customerPersonalStatus.id,
            localityId: customerLocality.id,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

// check if the customer isn't already in the database

          /*    final registeredCustomers = await CustomersController.getAll(
            selectedCustomerCategoryId: null,
            selectedCustomerEconomicalActivityId: null,
            selectedCustomerLocalityId: null,
            selectedCustomerPersonalStatusId: null,
          ).first; */

//String

          //      customerStatus = await CustomersController.create(customer: customer);
        } else if (customerProfilePicture == null) {
          final customerSignatureRemotePath =
              await CustomersController.uploadSignaturePicture(
                  customerSignaturePicturePath: customerSignaturePicture!);

          if (customerSignatureRemotePath != null) {
            final customer = Customer(
              name: customerName,
              firstnames: customerFirstnames,
              phoneNumber: customerPhoneNumber,
              address: customerAddress,
              profession: customerProfession,
              nicNumber: customerNicNumber,
              categoryId: customerCategory.id,
              economicalActivityId: customerEconomicalActivity.id,
              personalStatusId: customerPersonalStatus.id,
              localityId: customerLocality.id,
              signature:
                  '${CBConstants.supabaseStorageLink}/$customerSignatureRemotePath',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            );

            customerStatus =
                await CustomersController.create(customer: customer);

            //  debugPrint('new Customer: $CustomerStatus');
          } else {
            customerStatus = ServiceResponse.failed;
          }
        } else if (customerSignaturePicture == null) {
          final customerProfilePictureRemotePath =
              await CustomersController.uploadProfilePicture(
                  customerProfilePicturePath: customerProfilePicture);

          if (customerProfilePictureRemotePath != null) {
            final customer = Customer(
              name: customerName,
              firstnames: customerFirstnames,
              phoneNumber: customerPhoneNumber,
              address: customerAddress,
              profession: customerProfession,
              nicNumber: customerNicNumber,
              categoryId: customerCategory.id,
              economicalActivityId: customerEconomicalActivity.id,
              personalStatusId: customerPersonalStatus.id,
              localityId: customerLocality.id,
              profile:
                  '${CBConstants.supabaseStorageLink}/$customerProfilePictureRemotePath',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            );

            customerStatus =
                await CustomersController.create(customer: customer);

            //  debugPrint('new Customer: $CustomerStatus');
          } else {
            customerStatus = ServiceResponse.failed;
          }
        }
      } else {
        final customerProfilePictureRemotePath =
            await CustomersController.uploadProfilePicture(
                customerProfilePicturePath: customerProfilePicture);
        final customerSignatureRemotePath =
            await CustomersController.uploadSignaturePicture(
                customerSignaturePicturePath: customerSignaturePicture);

        if (customerProfilePictureRemotePath != null &&
            customerSignatureRemotePath != null) {
          final customer = Customer(
            name: customerName,
            firstnames: customerFirstnames,
            phoneNumber: customerPhoneNumber,
            address: customerAddress,
            profession: customerProfession,
            nicNumber: customerNicNumber,
            categoryId: customerCategory.id,
            economicalActivityId: customerEconomicalActivity.id,
            personalStatusId: customerPersonalStatus.id,
            localityId: customerLocality.id,
            profile:
                '${CBConstants.supabaseStorageLink}/$customerProfilePictureRemotePath',
            signature:
                '${CBConstants.supabaseStorageLink}/$customerSignatureRemotePath',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          customerStatus = await CustomersController.create(customer: customer);

          //  debugPrint('new Customer: $CustomerStatus');
        } else {
          customerStatus = ServiceResponse.failed;
        }
      }
      if (customerStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: customerStatus,
          response: 'Opération réussie',
        );
        showValidatedButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: customerStatus,
          response: 'Opération échouée',
        );
        showValidatedButton.value = true;
      }

      FunctionsController.showAlertDialog(
        context: context,
        alertDialog: const ResponseDialog(),
      );
    }
  }

  static Future<void> update({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required Customer customer,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    formKey.currentState!.save();
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      final customerProfilePicture = ref.watch(customerProfilePictureProvider);
      final customerSignaturePicture =
          ref.watch(customerSignaturePictureProvider);
      showValidatedButton.value = false;
      final customerName = ref.watch(customerNameProvider);
      final customerFirstnames = ref.watch(customerFirstnamesProvider);
      final customerPhoneNumber = ref.watch(customerPhoneNumberProvider);
      final customerAddress = ref.watch(customerAddressProvider);
      final customerProfession = ref.watch(customerProfessionProvider);
      final customerNicNumber = ref.watch(customerNicNumberProvider);
      final customerCategory = ref.watch(formCustomerCategoryDropdownProvider(
          'customer-update-form-category'));
      final customerPersonalStatus = ref.watch(
          formPersonalStatusDropdownProvider(
              'customer-update-form-personal-status'));
      final customerEconomicalActivity = ref.watch(
          formEconomicalActivityDropdownProvider(
              'customer-update-form-economical-activity'));
      final customerLocality = ref
          .watch(formLocalityDropdownProvider('customer-update-form-locality'));

      ServiceResponse lastCustomerStatus = ServiceResponse.waiting;

      if (customerProfilePicture == null || customerSignaturePicture == null) {
        if (customerProfilePicture == null &&
            customerSignaturePicture == null) {
          final newCustomer = Customer(
            name: customerName,
            firstnames: customerFirstnames,
            phoneNumber: customerPhoneNumber,
            address: customerAddress,
            profession: customerProfession,
            nicNumber: customerNicNumber,
            categoryId: customerCategory.id,
            economicalActivityId: customerEconomicalActivity.id,
            personalStatusId: customerPersonalStatus.id,
            localityId: customerLocality.id,
            profile: customer.profile,
            signature: customer.signature,
            createdAt: customer.createdAt,
            updatedAt: DateTime.now(),
          );

          lastCustomerStatus = await CustomersController.update(
            id: customer.id!,
            customer: newCustomer,
          );
        }
        // if only signature picture is updated
        else if (customerProfilePicture == null) {
          String? customerSignaturePictureRemotePath;

          // if the customer haven't a signature picture before
          if (customer.signature == null) {
            customerSignaturePictureRemotePath =
                await CustomersController.uploadSignaturePicture(
              customerSignaturePicturePath: customerSignaturePicture!,
            );
          } else {
            customerSignaturePictureRemotePath =
                await CustomersController.updateUploadedSignaturePicture(
              customerSignaturePictureLink: customer.signature!,
              newCustomerSignaturePicturePath: customerSignaturePicture!,
            );
          }

          if (customerSignaturePictureRemotePath != null) {
            final newCustomer = Customer(
              name: customerName,
              firstnames: customerFirstnames,
              phoneNumber: customerPhoneNumber,
              address: customerAddress,
              profession: customerProfession,
              nicNumber: customerNicNumber,
              categoryId: customerCategory.id,
              economicalActivityId: customerEconomicalActivity.id,
              personalStatusId: customerPersonalStatus.id,
              localityId: customerLocality.id,
              profile: customer.profile,
              signature:
                  '${CBConstants.supabaseStorageLink}/$customerSignaturePictureRemotePath',
              createdAt: customer.createdAt,
              updatedAt: DateTime.now(),
            );

            lastCustomerStatus = await CustomersController.update(
              id: customer.id!,
              customer: newCustomer,
            );

            //  debugPrint('new Customer: $CustomerStatus');
          } else {
            lastCustomerStatus = ServiceResponse.failed;
          }
        } else if (customerSignaturePicture == null) {
          String? customerProfilePictureRemotePath;

          // if the customer haven't a profile picture before
          if (customer.profile == null) {
            customerProfilePictureRemotePath =
                await CustomersController.uploadProfilePicture(
              customerProfilePicturePath: customerProfilePicture,
            );
          } else {
            customerProfilePictureRemotePath =
                await CustomersController.updateUploadedProfilePicture(
              customerProfilePictureLink: customer.profile!,
              newCustomerProfilePicturePath: customerProfilePicture,
            );
          }

          if (customerProfilePictureRemotePath != null) {
            final newCustomer = Customer(
              name: customerName,
              firstnames: customerFirstnames,
              phoneNumber: customerPhoneNumber,
              address: customerAddress,
              profession: customerProfession,
              nicNumber: customerNicNumber,
              categoryId: customerCategory.id,
              economicalActivityId: customerEconomicalActivity.id,
              personalStatusId: customerPersonalStatus.id,
              localityId: customerLocality.id,
              profile:
                  '${CBConstants.supabaseStorageLink}/$customerProfilePictureRemotePath',
              signature: customer.signature,
              createdAt: customer.createdAt,
              updatedAt: DateTime.now(),
            );

            lastCustomerStatus = await CustomersController.update(
              id: customer.id!,
              customer: newCustomer,
            );

            //  debugPrint('new Customer: $CustomerStatus');
          } else {
            lastCustomerStatus = ServiceResponse.failed;
          }
        }

        // debugPrint('new Customer: $CustomerStatus');
      } else {
        String? customerProfilePictureRemotePath;
        String? customerSignaturePictureRemotePath;

        // if the customer haven't a profile picture before
        if (customer.profile == null) {
          customerProfilePictureRemotePath =
              await CustomersController.uploadProfilePicture(
            customerProfilePicturePath: customerProfilePicture,
          );
        } else {
          customerProfilePictureRemotePath =
              await CustomersController.updateUploadedProfilePicture(
            customerProfilePictureLink: customer.profile!,
            newCustomerProfilePicturePath: customerProfilePicture,
          );
        }

        // if the customer haven't a signature picture before
        if (customer.signature == null) {
          customerSignaturePictureRemotePath =
              await CustomersController.uploadSignaturePicture(
            customerSignaturePicturePath: customerSignaturePicture,
          );
        } else {
          customerSignaturePictureRemotePath =
              await CustomersController.updateUploadedSignaturePicture(
            customerSignaturePictureLink: customer.signature!,
            newCustomerSignaturePicturePath: customerSignaturePicture,
          );
        }

        if (customerProfilePictureRemotePath != null &&
            customerSignaturePictureRemotePath != null) {
          final newCustomer = Customer(
            name: customerName,
            firstnames: customerFirstnames,
            phoneNumber: customerPhoneNumber,
            address: customerAddress,
            profession: customerProfession,
            nicNumber: customerNicNumber,
            categoryId: customerCategory.id,
            economicalActivityId: customerEconomicalActivity.id,
            personalStatusId: customerPersonalStatus.id,
            localityId: customerLocality.id,
            profile:
                '${CBConstants.supabaseStorageLink}/$customerProfilePictureRemotePath',
            signature:
                '${CBConstants.supabaseStorageLink}/$customerSignaturePictureRemotePath',
            createdAt: customer.createdAt,
            updatedAt: DateTime.now(),
          );

          lastCustomerStatus = await CustomersController.update(
            id: customer.id!,
            customer: newCustomer,
          );

          //  debugPrint('new Customer: $CustomerStatus');
        } else {
          lastCustomerStatus = ServiceResponse.failed;
        }
      }

      if (lastCustomerStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastCustomerStatus,
          response: 'Opération réussie',
        );
        showValidatedButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastCustomerStatus,
          response: 'Opération échouée',
        );
        showValidatedButton.value = true;
      }
      FunctionsController.showAlertDialog(
        context: context,
        alertDialog: const ResponseDialog(),
      );
    }
  }

  static Future<void> delete({
    required BuildContext context,
    required WidgetRef ref,
    required Customer customer,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    showConfirmationButton.value = false;

    ServiceResponse customerStatus;

    customerStatus = await CustomersController.delete(customer: customer);

    if (customerStatus == ServiceResponse.success) {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: customerStatus,
        response: 'Opération réussie',
      );
      Navigator.of(context).pop();
    } else {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: customerStatus,
        response: 'Opération échouée',
      );
      showConfirmationButton.value = true;
    }
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const ResponseDialog(),
    );
    return;
  }
}
