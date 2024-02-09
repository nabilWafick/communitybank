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
    // save the the genereted card label
    formKey.currentState!.save();
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      final customerAccountOwnerSelectedCardsTypes =
          ref.watch(customerAccountOwnerSelectedCardsTypesProvider);

      //  if  any  customer card have not  been  added
      if (customerAccountOwnerSelectedCardsTypes.isEmpty) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: ServiceResponse.failed,
          response:
              'Opération annulée \n Le compte client doit avoir au moins une carte',
        );

        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const ResponseDialog(),
        );
      } else {
        // cards are not repeated
        showValidatedButton.value = false;
        final customerAccountOwner = ref.watch(
            formCustomerDropdownProvider('customer-account-adding-customer'));
        final customerAccountCollector = ref.watch(
            formCollectorDropdownProvider('customer-account-adding-collector'));

        final customersAccounts =
            await CustomersAccountsController.getAll().first;

        final existedCustomerAccount = customersAccounts.firstWhere(
          (customerAccount) =>
              customerAccount.customerId == customerAccountOwner.id,
          orElse: () => CustomerAccount(
            customerId: 0,
            collectorId: 0,
            customerCardsIds: [],
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );

        if (existedCustomerAccount.id != null) {
          ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
            serviceResponse: ServiceResponse.failed,
            response: 'Opération annulée \n Le client possède déjà un compte',
          );
          showValidatedButton.value = true;
          FunctionsController.showAlertDialog(
            context: context,
            alertDialog: const ResponseDialog(),
          );
        } else {
          List<Type> customerAccountOwnerCardsTypes = [];

          // store selected customerCards type
          customerAccountOwnerSelectedCardsTypes.forEach(
            (key, customerCardType) {
              customerAccountOwnerCardsTypes.add(customerCardType);
            },
          );

          // verify if a  customer card type is not repeated
          bool isCustomerCardTypesRepeated = false;
          int customerCardTypesNumber = 0;

          // verify a type is repeated (if two customer cards have the same type)
          for (Type customerCardTypeF in customerAccountOwnerCardsTypes) {
            isCustomerCardTypesRepeated = false;
            customerCardTypesNumber = 0;
            for (Type customerCardTypeL in customerAccountOwnerCardsTypes) {
              if (customerCardTypeF.id == customerCardTypeL.id) {
                ++customerCardTypesNumber;
              }
            }

            if (customerCardTypesNumber > 1) {
              isCustomerCardTypesRepeated = true;
              break;
            }
          }

          if (isCustomerCardTypesRepeated) {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: ServiceResponse.failed,
              response:
                  'Opération annulée \n Répétition de types dans le compte',
            );
            showValidatedButton.value = true;
            FunctionsController.showAlertDialog(
              context: context,
              alertDialog: const ResponseDialog(),
            );
          } else {
            // get all input added (customer card input)
            final customerAccountAddedInputs =
                ref.watch(customerAccountAddedInputsProvider);

            // store  all customer account owner cards labels
            List<String> customerAccountOwnerCardsLabels = [];

            // store all customer account owner cards type number
            List<int> customerAccountOwnerCardsTypesNumbers = [];

            for (MapEntry customerAccountAddedInputsEntry
                in customerAccountAddedInputs.entries) {
              // verify if the input is visible
              // values are bool and keys are int, id or datetime now
              if (customerAccountAddedInputsEntry.value) {
                customerAccountOwnerCardsLabels.add(
                  ref.watch(
                    customerAccountOwnerCardLabelProvider(
                      customerAccountAddedInputsEntry.key,
                    ),
                  ),
                );
                customerAccountOwnerCardsTypesNumbers.add(
                  ref.watch(
                    customerAccountOwnerCardTypeNumberProvider(
                      customerAccountAddedInputsEntry.key,
                    ),
                  ),
                );
              }
            }

            // verify if a  customer card(label) is not repeated

            bool isCustomerCardRepeated = false;
            int customerCardNumber = 0;

            for (String customerCardF in customerAccountOwnerCardsLabels) {
              isCustomerCardRepeated = false;
              customerCardNumber = 0;
              for (String customerCardL in customerAccountOwnerCardsLabels) {
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
              ref.read(responseDialogProvider.notifier).state =
                  ResponseDialogModel(
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
              for (int i = 0; i < customerAccountOwnerCardsLabels.length; ++i) {
                customerAccountOwnerCards.add(
                  CustomerCard(
                    label: customerAccountOwnerCardsLabels[i],
                    typeId: customerAccountOwnerCardsTypes[i].id!,
                    typeNumber: customerAccountOwnerCardsTypesNumbers[i],
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
              final newCustomerAccountMap =
                  await CustomersAccountsService.create(
                customerAccount: customerAccount,
              );

              // will store every customer card adding status;
              List<ServiceResponse> customerCardsAddingStatus = [];
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
                  // set the customer account for all customer cards
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

                  customerCardsAddingStatus.add(newCustomerCardAddingStatus);

                  // set the customer creation status
                  //  isAllCustomerCardsAddedSuccessfully =
                  //      newCustomerCardAddingStatus == ServiceResponse.success;
                }

                // check if all adding is finished with success
                for (ServiceResponse customerAddingStatus
                    in customerCardsAddingStatus) {
                  if (customerAddingStatus == ServiceResponse.success) {
                    isAllCustomerCardsAddedSuccessfully = true;
                  } else {
                    isAllCustomerCardsAddedSuccessfully = false;
                  }
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
    }
  }

  static Future<void> update({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required CustomerAccount customerAccountLast,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
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
        final customerAccountCollector = ref.watch(
            formCollectorDropdownProvider('customer-account-update-collector'));

        List<Type> customerAccountOwnerCardsTypes = [];

        // store selected customerCards type
        customerAccountOwnerSelectedCardsTypes.forEach((key, customerCardType) {
          customerAccountOwnerCardsTypes.add(customerCardType);
        });

        //  debugPrint('selected types');
        //  debugPrint(customerAccountOwnerCardsTypes.toString());

        // verify if a customer card type is not repeated
        bool isCustomerCardTypesRepeated = false;
        int customerCardTypesNumber = 0;

        // verify a type is repeated (if two customer cards have the same type)
        for (Type customerCardTypeF in customerAccountOwnerCardsTypes) {
          isCustomerCardTypesRepeated = false;
          customerCardTypesNumber = 0;
          for (Type customerCardTypeL in customerAccountOwnerCardsTypes) {
            if (customerCardTypeF.id == customerCardTypeL.id) {
              ++customerCardTypesNumber;
            }
          }

          if (customerCardTypesNumber > 1) {
            isCustomerCardTypesRepeated = true;
            break;
          }
        }

        if (isCustomerCardTypesRepeated) {
          ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
            serviceResponse: ServiceResponse.failed,
            response: 'Opération annulée \n Répétition de types dans le compte',
          );
          showValidatedButton.value = true;
          FunctionsController.showAlertDialog(
            context: context,
            alertDialog: const ResponseDialog(),
          );
        } else {
          // get all input added (customer card input)
          final customerAccountAddedInputs =
              ref.watch(customerAccountAddedInputsProvider);

          // store  all customer account owner cards labels
          List<String> customerAccountOwnerCardsLabels = [];

          // store all customer account owner cards type number
          List<int> customerAccountOwnerCardsTypesNumbers = [];

          // customerAccountCards ids are used as customerAccountAddedInputs keys
          // while creating customerCard inputs widgets in customerAccount update
          // form, if in update a new customerCard is created,
          // we use DateTime.now().fromMicrosecondsSinceEpoch as key
          // In update crud function, customerAccountAddedInputs keys will
          // help to detect and know the customerCards which existed in database
          // and update them. If a new customerCard is added it will have
          // DateTime.now().fromMicrosecondsSinceEpoch as id which will possible
          // not be in the database. In that case, the new product will be added
          // in database
          // store all customerCard ids (if it existed)
          List<dynamic> customerAccountOwnerCardsIds = [];

          for (MapEntry customerAccountAddedInputsEntry
              in customerAccountAddedInputs.entries) {
            // verify if the input is visible
            if (customerAccountAddedInputsEntry.value) {
              // store the customerCards labels
              customerAccountOwnerCardsLabels.add(
                ref.watch(
                  customerAccountOwnerCardLabelProvider(
                    customerAccountAddedInputsEntry.key,
                  ),
                ),
              );
              customerAccountOwnerCardsTypesNumbers.add(
                ref.watch(
                  customerAccountOwnerCardTypeNumberProvider(
                    customerAccountAddedInputsEntry.key,
                  ),
                ),
              );

              // store the customerCard ids that will be added to customerCard
              // model in instanciation
              customerAccountOwnerCardsIds.add(
                customerAccountAddedInputsEntry.key,
              );
            }
          }

          // verify if a  customer card(label) is not repeated

          bool isCustomerCardRepeated = false;
          int customerCardNumber = 0;

          for (String customerCardF in customerAccountOwnerCardsLabels) {
            isCustomerCardRepeated = false;
            customerCardNumber = 0;
            for (String customerCardL in customerAccountOwnerCardsLabels) {
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
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: ServiceResponse.failed,
              response: 'Répétition de carte (libellé) dans le compte',
            );
            FunctionsController.showAlertDialog(
              context: context,
              alertDialog: const ResponseDialog(),
            );
            isCustomerCardRepeated = false;
            customerCardNumber = 0;
          } else {
            ServiceResponse customerAccountFirstUpdateStatus;

            List<CustomerCard> customerAccountOwnerCards = [];

            // added the customer card
            for (int i = 0; i < customerAccountOwnerCardsLabels.length; ++i) {
              customerAccountOwnerCards.add(
                CustomerCard(
                  id: customerAccountOwnerCardsIds[i],
                  label: customerAccountOwnerCardsLabels[i],
                  typeId: customerAccountOwnerCardsTypes[i].id!,
                  typeNumber: customerAccountOwnerCardsTypesNumbers[i],
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ),
              );
            }

            // create the customer account model
            CustomerAccount lastCustomerAccount = CustomerAccount(
              customerId: customerAccountLast.customerId,
              collectorId: customerAccountCollector.id!,
              customerCardsIds: customerAccountLast.customerCardsIds,
              createdAt: customerAccountLast.createdAt,
              updatedAt: DateTime.now(),
            );

            // update the customer account in the database (may be the
            // account collector have been replaced )
            final lastCustomerAccountMap =
                await CustomersAccountsService.update(
              id: customerAccountLast.id!,
              customerAccount: lastCustomerAccount,
            );

            // will store every customer card update or adding status;
            List<ServiceResponse> customerCardsOperationStatus = [];

            // will be used to check if all customer card have been
            // updated or created successfully
            bool isAllCustomerCardsOperationDoneSuccessfully = false;

            // if the customer account have been updated
            // for the first time successfully
            if (lastCustomerAccountMap != null &&
                lastCustomerAccountMap[CustomerAccountTable.id] != null) {
              customerAccountFirstUpdateStatus = ServiceResponse.success;

              // fetch all customerCards for detecting new customerCards
              // get all customerCards
              final allCustomerCards =
                  await CustomersCardsController.getAll().first;
              // store customer cards ids ( ids are used instead of customer
              // card because customer cards labels  may be changed )
              final allCustomerCardsIds = allCustomerCards
                  .map(
                    (customerCard) => customerCard.id!,
                  )
                  .toList();

              // update or create every customer card after setting
              // customer account id
              for (int i = 0; i < customerAccountOwnerCards.length; ++i) {
                // set the customer account for all customer cards
                customerAccountOwnerCards[i] =
                    customerAccountOwnerCards[i].copyWith(
                  customerAccountId:
                      lastCustomerAccountMap[CustomerAccountTable.id],
                );

                // ************

                // if the customer card have been stored in database
                if (allCustomerCardsIds
                    .contains(customerAccountOwnerCards[i].id!)) {
                  // try to update the customer card
                  // update the customerCard created date
                  // since it have been with DateTime.now
                  customerAccountOwnerCards[i] =
                      customerAccountOwnerCards[i].copyWith(
                    createdAt: allCustomerCards
                        .firstWhere((customerCard) =>
                            customerCard.id! ==
                            customerAccountOwnerCards[i].id!)
                        .createdAt,
                  );
                  // update the customer card in the database
                  final lastCustomerCardMap = await CustomerCardsService.update(
                    id: customerAccountOwnerCards[i].id!,
                    customerCard: customerAccountOwnerCards[i],
                  );

                  ServiceResponse lastCustomerCardUpdateStatus =
                      ServiceResponse.failed;

                  // if the customer card have been updated succesfully
                  if (lastCustomerCardMap != null &&
                      lastCustomerCardMap[CustomerCardTable.id] != null) {
                    // set the id of the customer card,
                    // that is necessary for updating customer account
                    // not necessary here copy - paste code
                    customerAccountOwnerCards[i] =
                        customerAccountOwnerCards[i].copyWith(
                      id: lastCustomerCardMap[CustomerCardTable.id],
                    );
                    lastCustomerCardUpdateStatus = ServiceResponse.success;
                  }

                  customerCardsOperationStatus
                      .add(lastCustomerCardUpdateStatus);

                  // set the customer creation status
                  //  isAllCustomerCardsUpdatedSuccessfully =
                  //      lastCustomerCardUpdateStatus == ServiceResponse.success;
                }
                // else, it's a new customer card
                else {
                  // try to create the customer card and update his id since
                  // his current id is DateTime.now().fromMillisecondsSinceEpoch
                  ServiceResponse newCustomerCardAddingStatus =
                      ServiceResponse.failed;

                  // add the customer card to the database
                  final newCustomerCardMap = await CustomerCardsService.create(
                    customerCard: customerAccountOwnerCards[i],
                  );

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

                  customerCardsOperationStatus.add(newCustomerCardAddingStatus);

                  // set the customer creation status
                  //  isAllCustomerCardsUpdatedSuccessfully =
                  //      newCustomerCardAddingStatus == ServiceResponse.success;
                }

                // ************
              }

              // check if all adding is finished with success
              for (ServiceResponse customerAddingStatus
                  in customerCardsOperationStatus) {
                if (customerAddingStatus == ServiceResponse.success) {
                  isAllCustomerCardsOperationDoneSuccessfully = true;
                } else {
                  isAllCustomerCardsOperationDoneSuccessfully = false;
                }
              }

              // check if the account have been successfully updated
              // and every customer cards have been sucessfuly updated or created
              if (customerAccountFirstUpdateStatus == ServiceResponse.success &&
                  isAllCustomerCardsOperationDoneSuccessfully == true) {
                // update customer account by setting its customers card ids
                lastCustomerAccount = lastCustomerAccount.copyWith(
                  customerCardsIds: customerAccountOwnerCards
                      .map(
                        (customerCard) => customerCard.id!,
                      )
                      .toList(),
                );

                final customerAccountUpdateStatus =
                    await CustomersAccountsController.update(
                  id: lastCustomerAccountMap[CustomerAccountTable.id],
                  customerAccount: lastCustomerAccount,
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
              debugPrint('the account haven\'t been updated');
              // the account haven't been updated
              customerAccountFirstUpdateStatus = ServiceResponse.failed;

              ref.read(responseDialogProvider.notifier).state =
                  ResponseDialogModel(
                serviceResponse: customerAccountFirstUpdateStatus,
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
