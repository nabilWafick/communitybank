// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/customer_account/customer_account.controller.dart';
import 'package:communitybank/controllers/customer_card/customer_card.controller.dart';
import 'package:communitybank/controllers/forms/validators/customer_account/customer_account.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/models/data/type/type.model.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/models/tables/customer_account/customer_account_table.model.dart';
import 'package:communitybank/models/tables/customer_card/customer_card_table.model.dart';
import 'package:communitybank/services/customer_account/customer_account.service.dart';
import 'package:communitybank/services/customer_card/customer_card.service.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/collector/collector_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/customer/customer_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerAccountCRUDFunctions {
  static Future<void> create({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    // save the the generwted card label
    formKey.currentState!.save();
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      final customerAccountOwnerSelectedCardsTypes =
          ref.watch(customerAccountOwnerSelectedCardsTypesProvider);

      //  if  any  customer card have not  been  added
      if (customerAccountOwnerSelectedCardsTypes.isEmpty) {
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

        List<Type> customerAccountOwnerCardsTypes = [];

        // store selected customerCards type
        customerAccountOwnerSelectedCardsTypes.forEach((key, customerCardType) {
          customerAccountOwnerCardsTypes.add(customerCardType);
        });

        // get all input added (customer card input)
        final customerAccountAddedInputs =
            ref.watch(customerAccountAddedInputsProvider);

        // store  all customer account ownder cards labels
        List<String> customerAccounOwnerCardsLabels = [];

        for (MapEntry customerAccountAddedInputsEntry
            in customerAccountAddedInputs.entries) {
          // verify if the input is visible
          if (customerAccountAddedInputsEntry.value) {
            customerAccounOwnerCardsLabels.add(
              ref.watch(
                customerAccountOwnerCardLabelProvider(
                  customerAccountAddedInputsEntry.key,
                ),
              ),
            );
          }
        }

        // verify if a  customer card(label) is not repeated

        bool isCustomerCardRepeated = false;
        int customerCardNumber = 0;

        for (String customerCardF in customerAccounOwnerCardsLabels) {
          isCustomerCardRepeated = false;
          customerCardNumber = 0;
          for (String customerCardL in customerAccounOwnerCardsLabels) {
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
          ServiceResponse customerAccountAddingStatus;

          List<CustomerCard> customerAccountOwnerCards = [];

          // added the customer card
          for (int i = 0; i < customerAccounOwnerCardsLabels.length; ++i) {
            customerAccountOwnerCards.add(
              CustomerCard(
                label: customerAccounOwnerCardsLabels[i],
                typeId: customerAccountOwnerCardsTypes[i].id!,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
            );
          }

          // create the customer account
          CustomerAccount customerAccount = CustomerAccount(
            customerId: customerAccountOwner.id!,
            collectorId: customerAccountCollector.id!,
            customerCardsIds: [],
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          // add the customer account to the database
          final newCustomerAccountMap = await CustomersAccountsService.create(
            customerAccount: customerAccount,
          );

          // will be used to check if all customer card have been created successfully
          bool isAllCustomerCardsAddedSuccessfully = false;

          // if the customer account is created successfully
          if (newCustomerAccountMap != null &&
              newCustomerAccountMap[CustomerAccountTable.id] != null) {
            customerAccountAddingStatus = ServiceResponse.success;

            // create every customer card with the  customer account id
            for (int i = 0; i < customerAccountOwnerCards.length; ++i) {
              /* customerAccountOwnerCards[i].customerAccountId =
                  newCustomerAccountMap[CustomerAccountTable.id];
               */
              // set the customer account
              customerAccountOwnerCards[i] =
                  customerAccountOwnerCards[i].copyWith(
                customerAccountId:
                    newCustomerAccountMap[CustomerAccountTable.id],
              );

              // add the customer card to the database
              final newCustomerCardMap = await CustomerCardsService.create(
                customerCard: customerAccountOwnerCards[i],
              );

              ServiceResponse newCustomerCardAddingStatus =
                  ServiceResponse.failed;

              // if the customer card is added succesfully
              if (newCustomerCardMap != null &&
                  newCustomerCardMap[CustomerCardTable.id] != null) {
                // set the id of the customer card,
                // that is necessary for updating customer account
                customerAccountOwnerCards[i] =
                    customerAccountOwnerCards[i].copyWith(
                  id: newCustomerCardMap[CustomerCardTable.id],
                );
                newCustomerCardAddingStatus = ServiceResponse.success;
              }

              // set the customer creation status
              isAllCustomerCardsAddedSuccessfully =
                  newCustomerCardAddingStatus == ServiceResponse.success;
            }

            // check if the account have been successfully created
            // and the customer cards are sucessfuly added
            if (customerAccountAddingStatus == ServiceResponse.success &&
                isAllCustomerCardsAddedSuccessfully == true) {
              // update customer account by setting its customers card ids
              customerAccount = customerAccount.copyWith(
                customerCardsIds: customerAccountOwnerCards
                    .map(
                      (customerCard) => customerCard.id!,
                    )
                    .toList(),
              );

              final customerAccountUpdateStatus =
                  await CustomersAccountsController.update(
                id: newCustomerAccountMap[CustomerAccountTable.id],
                customerAccount: customerAccount,
              );

              // if the customer account is updated successfully
              if (customerAccountUpdateStatus == ServiceResponse.success) {
                ref.read(responseDialogProvider.notifier).state =
                    ResponseDialogModel(
                  serviceResponse: customerAccountUpdateStatus,
                  response: 'Opération réussie',
                );
                showValidatedButton.value = true;
                Navigator.of(context).pop();
              } else {
                ref.read(responseDialogProvider.notifier).state =
                    ResponseDialogModel(
                  serviceResponse: customerAccountUpdateStatus,
                  response: 'Opération échouée',
                );
                showValidatedButton.value = true;
              }
            } else {
              // if account is created successfully but the customer cards
              // are not created succesfully
              ref.read(responseDialogProvider.notifier).state =
                  ResponseDialogModel(
                serviceResponse: ServiceResponse.failed,
                response: 'Opération échouée',
              );
              showValidatedButton.value = true;
            }
          } else {
            // the account haven't been created
            customerAccountAddingStatus = ServiceResponse.failed;

            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: customerAccountAddingStatus,
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
      /*    final customerAccountOwnerSelectedCardsTypes =
          ref.watch(customerAccountOwnerSelectedCardsTypesProvider);
//  if  any  customer card have  been  selected
      if (customerAccountOwnerSelectedCardsTypes.isEmpty) {
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

        customerAccountOwnerSelectedCardsTypes.forEach((key, customerCard) {
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
            customerCardsIds: customerAccountOwnerCards
                .map(
                  (customerAccountOwnerCard) => customerAccountOwnerCard.id,
                )
                .toList(),
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
   */
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
