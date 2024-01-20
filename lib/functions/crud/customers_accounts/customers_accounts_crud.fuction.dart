// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/customer_account/customer_account.controller.dart';
import 'package:communitybank/controllers/customer_card/customer_card.controller.dart';
import 'package:communitybank/controllers/forms/validators/customer_account/customer_account.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/models/tables/customer_account/customer_account_table.model.dart';
import 'package:communitybank/services/customer_account/customer_account.service.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/collector/collector_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/customer_dropdown/customer_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerAccountCRUDFunctions {
  static Future<void> create({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      final customerAccountSelectedOwnerCards =
          ref.watch(customerAccountSelectedOwnerCardsProvider);
//  if  any  customer card have  been  selected
      if (customerAccountSelectedOwnerCards.isEmpty) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: ServiceResponse.failed,
          response: 'Le compte client doit avoir au moins une carte',
        );
        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const ResponseDialog(),
        );
      } else {
        showValidatedButton.value = false;
        final customerAccountOwner = ref.watch(
            formCustomerDropdownProvider('customer-account-adding-customer'));
        final customerAccountCollector = ref.watch(
            formCollectorDropdownProvider('customer-account-adding-collector'));

        List<CustomerCard> customerAccountOwnerCards = [];

        // store selected customerCards

        customerAccountSelectedOwnerCards.forEach((key, customerCard) {
          customerAccountOwnerCards.add(customerCard);
        });

        bool isCustomerCardRepeated = false;
        int customerCardNumber = 0;

        for (CustomerCard customerCardF in customerAccountOwnerCards) {
          isCustomerCardRepeated = false;
          customerCardNumber = 0;
          for (CustomerCard customerCardL in customerAccountOwnerCards) {
            if (customerCardF == customerCardL) {
              ++customerCardNumber;
            }
          }

          if (customerCardNumber > 1) {
            isCustomerCardRepeated = true;
            break;
          }
        }

        if (isCustomerCardRepeated == true) {
          // show validated button to permit a correction from the user
          showValidatedButton.value = true;
          ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
            serviceResponse: ServiceResponse.failed,
            response: 'Répétition de carte dans le compte',
          );
          FunctionsController.showAlertDialog(
            context: context,
            alertDialog: const ResponseDialog(),
          );
          isCustomerCardRepeated = false;
          customerCardNumber = 0;
        } else {
          ServiceResponse customerAccountStatus;

          final customerAccount = CustomerAccount(
            customerId: customerAccountOwner.id!,
            collectorId: customerAccountCollector.id!,
            customerCards: customerAccountOwnerCards,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          final newCustomerAccountMap = await CustomersAccountsService.create(
            customerAccount: customerAccount,
          );

          bool isAllCustomerCardsUpdatedSuccessfully = false;

          if (newCustomerAccountMap != null &&
              newCustomerAccountMap[CustomerAccountTable.id] != null) {
            customerAccountStatus = ServiceResponse.success;

            // update the owner account id of each customer card
            // will store all customerCard update status
            List<ServiceResponse> customerCardsUpdateStatus = [];
            for (CustomerCard customerCard in customerAccountOwnerCards) {
              // all selected customerCards will get the
              // new customer Account id
              customerCard.customerAccountId =
                  newCustomerAccountMap[CustomerAccountTable.id];
              final customerCardUpdateStatus =
                  await CustomersCardsController.update(
                id: customerCard.id!,
                customerCard: customerCard,
              );
              customerCardsUpdateStatus.add(customerCardUpdateStatus);
            }

            // debugPrint('new CustomerAccount: $customerAccountStatus');

            for (ServiceResponse customerCardStatus
                in customerCardsUpdateStatus) {
              if (customerCardStatus == ServiceResponse.success) {
                isAllCustomerCardsUpdatedSuccessfully = true;
              } else {
                isAllCustomerCardsUpdatedSuccessfully = false;
              }
            }
          } else {
            // the account haven't been created
            customerAccountStatus = ServiceResponse.failed;
          }

          // debugPrint('new CustomerAccount: $customerAccountStatus');

// check if the account have been successfully created and the customer cards sucessfuly updated
          if (customerAccountStatus == ServiceResponse.success &&
              isAllCustomerCardsUpdatedSuccessfully == true) {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: customerAccountStatus,
              response: 'Opération réussie',
            );
            showValidatedButton.value = true;
            Navigator.of(context).pop();
          } else {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: customerAccountStatus,
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
    }
  }

  static Future<void> update({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required CustomerAccount customerAccount,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    formKey.currentState!.save();
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      final customerAccountSelectedOwnerCards =
          ref.watch(customerAccountSelectedOwnerCardsProvider);
//  if  any  customer card have  been  selected
      if (customerAccountSelectedOwnerCards.isEmpty) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: ServiceResponse.failed,
          response: 'Le compte client doit avoir au moins une carte',
        );
        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const ResponseDialog(),
        );
      } else {
        showValidatedButton.value = false;
        final customerAccountOwner = ref.watch(
            formCustomerDropdownProvider('customer-account-update-customer'));
        final customerAccountCollector = ref.watch(
            formCollectorDropdownProvider('customer-account-update-collector'));

        List<CustomerCard> customerAccountOwnerCards = [];

        // store selected customerCards

        customerAccountSelectedOwnerCards.forEach((key, customerCard) {
          customerAccountOwnerCards.add(customerCard);
        });

        bool isCustomerCardRepeated = false;
        int customerCardNumber = 0;

        for (CustomerCard customerCardF in customerAccountOwnerCards) {
          isCustomerCardRepeated = false;
          customerCardNumber = 0;
          for (CustomerCard customerCardL in customerAccountOwnerCards) {
            if (customerCardF == customerCardL) {
              ++customerCardNumber;
            }
          }

          if (customerCardNumber > 1) {
            isCustomerCardRepeated = true;
            break;
          }
        }

        if (isCustomerCardRepeated == true) {
          // show validated button to permit a correction from the user
          showValidatedButton.value = true;
          ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
            serviceResponse: ServiceResponse.failed,
            response: 'Répétition de carte dans le compte',
          );
          FunctionsController.showAlertDialog(
            context: context,
            alertDialog: const ResponseDialog(),
          );
          isCustomerCardRepeated = false;
          customerCardNumber = 0;
        } else {
          ServiceResponse lastCustomerAccountStatus;

          final newCustomerAccount = CustomerAccount(
            customerId: customerAccountOwner.id!,
            collectorId: customerAccountCollector.id!,
            customerCards: customerAccountOwnerCards,
            createdAt: customerAccountCollector.createdAt,
            updatedAt: DateTime.now(),
          );

          lastCustomerAccountStatus = await CustomersAccountsController.update(
            id: customerAccount.id!,
            customerAccount: newCustomerAccount,
          );

          // update the owner account id of each customer card
          // will store all customerCard update status
          List<ServiceResponse> customerCardsUpdateStatus = [];
          for (CustomerCard customerCard in customerAccountOwnerCards) {
            customerCard.customerAccountId = customerAccount.id!;
            final customerCardUpdateStatus =
                await CustomersCardsController.update(
              id: customerCard.id!,
              customerCard: customerCard,
            );
            customerCardsUpdateStatus.add(customerCardUpdateStatus);
          }

          // debugPrint('new CustomerAccount: $customerAccountStatus');

          bool isAllCustomerCardsUpdatedSuccessfully = false;

          for (ServiceResponse customerCardStatus
              in customerCardsUpdateStatus) {
            if (customerCardStatus == ServiceResponse.success) {
              isAllCustomerCardsUpdatedSuccessfully = true;
            } else {
              isAllCustomerCardsUpdatedSuccessfully = false;
            }
          }

          // if the customer account and all customer cards have been updated successfully
          if (lastCustomerAccountStatus == ServiceResponse.success &&
              isAllCustomerCardsUpdatedSuccessfully == true) {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: lastCustomerAccountStatus,
              response: 'Opération réussie',
            );
            showValidatedButton.value = true;
            Navigator.of(context).pop();
          } else {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: lastCustomerAccountStatus,
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
    }
  }

  static Future<void> delete({
    required BuildContext context,
    required WidgetRef ref,
    required CustomerAccount customerAccount,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    showConfirmationButton.value = false;

    ServiceResponse customerAccountStatus;

    customerAccountStatus = await CustomersAccountsController.delete(
        customerAccount: customerAccount);

    if (customerAccountStatus == ServiceResponse.success) {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: customerAccountStatus,
        response: 'Opération réussie',
      );
      Navigator.of(context).pop();
    } else {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: customerAccountStatus,
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
