// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/customers/customers.controller.dart';
import 'package:communitybank/controllers/forms/validators/customer/customer.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/utils/constants/constants.util.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:communitybank/views/widgets/globals/customer_category_dropdown/customer_category_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/economical_activity_dropdown/economical_activity_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/locality_dropdown/locality_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/personal_status_dropdown/personal_status_dropdown.widget.dart';
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
      final customerCategory = ref.watch(
          customerCategoryDropdownProvider('customer-adding-form-category'));
      final customerPersonalStatus = ref.watch(personalStatusDropdownProvider(
          'customer-adding-form-personal-status'));
      final customerEconomicalActivity = ref.watch(
          economicalActivityDropdownProvider(
              'customer-adding-form-economical-activity'));
      final customerLocality =
          ref.watch(localityDropdownProvider('customer-adding-form-locality'));

      debugPrint(customerName.toString());
      debugPrint(customerFirstnames.toString());
      debugPrint(customerPhoneNumber.toString());
      debugPrint(customerProfession.toString());
      debugPrint(customerAddress.toString());
      debugPrint(customerNicNumber.toString());
      debugPrint(customerPersonalStatus.toString());
      debugPrint(customerEconomicalActivity.toString());
      debugPrint(customerCategory.toString());
      debugPrint(customerLocality.toString());
      debugPrint(customerProfilePicture.toString());
      debugPrint(customerSignaturePicture.toString());

      ServiceResponse customerStatus;

      if (customerProfilePicture == null || customerSignaturePicture == null) {
        final customer = Customer(
          name: customerName,
          firstnames: customerFirstnames,
          phoneNumber: customerPhoneNumber,
          address: customerAddress,
          profession: customerProfession,
          nicNumber: customerNicNumber,
          category: customerCategory,
          economicalActivity: customerEconomicalActivity,
          personalStatus: customerPersonalStatus,
          locality: customerLocality,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        customerStatus = await CustomersController.create(customer: customer);

        // debugPrint('new Customer: $CustomerStatus');
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
            category: customerCategory,
            economicalActivity: customerEconomicalActivity,
            personalStatus: customerPersonalStatus,
            locality: customerLocality,
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

/*
  static Future<void> update({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required Customer Customer,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    final CustomerPicture = ref.watch(CustomerPictureProvider);
    formKey.currentState!.save();
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      final CustomerName = ref.watch(CustomerNameProvider);
      final CustomerPrice = ref.watch(CustomerPurchasePriceProvider);

      ServiceResponse lastCustomerStatus;

      if (CustomerPicture == null) {
        final newCustomer = Customer(
          name: CustomerName,
          purchasePrice: CustomerPrice,
          picture: Customer.picture,
          createdAt: Customer.createdAt,
          updatedAt: DateTime.now(),
        );

        lastCustomerStatus = await CustomersController.update(
          id: Customer.id!,
          Customer: newCustomer,
        );

        // debugPrint('new Customer: $CustomerStatus');
      } else {
        String? CustomerRemotePath;
        // if the Customer haven't a picture before
        if (Customer.picture == null) {
          CustomerRemotePath = await CustomersController.uploadPicture(
              CustomerPicturePath: CustomerPicture);
        } else {
          CustomerRemotePath = await CustomersController.updateUploadedPicture(
            CustomerPictureLink: Customer.picture!,
            newCustomerPicturePath: CustomerPicture,
          );
        }

        if (CustomerRemotePath != null) {
          final newCustomer = Customer(
            name: CustomerName,
            purchasePrice: CustomerPrice,
            picture: '${CBConstants.supabaseStorageLink}/$CustomerRemotePath',
            createdAt: Customer.createdAt,
            updatedAt: DateTime.now(),
          );

          lastCustomerStatus = await CustomersController.update(
            id: Customer.id!,
            Customer: newCustomer,
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
    required Customer Customer,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    showConfirmationButton.value = false;

    ServiceResponse CustomerStatus;

    CustomerStatus = await CustomersController.delete(Customer: Customer);

    if (CustomerStatus == ServiceResponse.success) {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: CustomerStatus,
        response: 'Opération réussie',
      );
      Navigator.of(context).pop();
    } else {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: CustomerStatus,
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
*/
}
