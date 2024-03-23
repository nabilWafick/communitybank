// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/customer_card/customer_card.controller.dart';
import 'package:communitybank/controllers/settlements/settlements.controller.dart';
import 'package:communitybank/controllers/transfers/transfers.controller.dart';
import 'package:communitybank/controllers/types/types.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/settlement/settlement.model.dart';
import 'package:communitybank/models/data/transfer/transfer.model.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/utils/constants/constants.util.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:communitybank/views/widgets/transferts/between_customers_accounts/between_customers_accounts_data/between_customers_accounts_data.widget.dart';
import 'package:communitybank/views/widgets/transferts/between_customers_cards/between_customer_cards_data/between_customer_cards_data.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransferCRUDFunctions {
  static Future<void> createBetweenCustomerCards({
    required BuildContext context,
    required WidgetRef ref,
    required ValueNotifier<bool> enableTransferButton,
  }) async {
    final transfersBetweenCustomerCardSelectedIssuingCustomerCard = ref
        .watch(transfersBetweenCustomerCardSelectedIssuingCustomerCardProvider);

    final transfersBetweenCustomerCardSelectedIssuingCustomerCardType =
        ref.watch(
            transfersBetweenCustomerCardSelectedIssuingCustomerCardTypeProvider);

    final transfersBetweenCustomerCardSelectedReceivingCustomerCard = ref.watch(
        transfersBetweenCustomerCardSelectedReceivingCustomerCardProvider);

    final transfersBetweenCustomerCardSelectedReceivingCustomerCardType =
        ref.watch(
            transfersBetweenCustomerCardSelectedReceivingCustomerCardTypeProvider);

    // checkif issuing and receiving customer cards have been selected
    if (transfersBetweenCustomerCardSelectedIssuingCustomerCard != null &&
        transfersBetweenCustomerCardSelectedIssuingCustomerCard.id != null &&
        transfersBetweenCustomerCardSelectedReceivingCustomerCard != null &&
        transfersBetweenCustomerCardSelectedReceivingCustomerCard.id != null) {
      enableTransferButton.value = false;
      // check if issuing and receiving customers cards are differents
      if (transfersBetweenCustomerCardSelectedReceivingCustomerCard !=
          transfersBetweenCustomerCardSelectedIssuingCustomerCard) {
        // get current issuing settlements totals
        final issuingCustomerCardSettlements =
            await SettlementsController.getAll(
          customerCardId:
              transfersBetweenCustomerCardSelectedIssuingCustomerCard.id,
        ).first;

        int settlementsNumbersTotal = 0;
        for (Settlement settlement in issuingCustomerCardSettlements) {
          settlementsNumbersTotal += settlement.number;
        }

        // calculate the amount to transefered
        final issuingCustomerCardTransferedAmount = ((2 *
                    (transfersBetweenCustomerCardSelectedIssuingCustomerCard
                            .typeNumber *
                        transfersBetweenCustomerCardSelectedIssuingCustomerCardType!
                            .stake *
                        settlementsNumbersTotal) /
                    3) -
                300)
            .round();

        // calculate the number of settlements to receive
        final settlementsNumberReceived = (issuingCustomerCardTransferedAmount /
                transfersBetweenCustomerCardSelectedReceivingCustomerCardType!
                    .stake)
            .round();
        if (issuingCustomerCardTransferedAmount <= 0 ||
            settlementsNumberReceived <= 0) {
          ref
              .read(
                responseDialogProvider.notifier,
              )
              .state = ResponseDialogModel(
            serviceResponse: ServiceResponse.failed,
            response: 'Opération échouée \n Solde insuffisant',
          );
          FunctionsController.showAlertDialog(
            context: context,
            alertDialog: const ResponseDialog(),
          );
        } else {
          // launch transfer

          ServiceResponse transferStatus;

          final prefs = await SharedPreferences.getInstance();
          final agentId = prefs.getInt(CBConstants.agentIdPrefKey);

          final transfer = Transfer(
            issuingCustomerCardId:
                transfersBetweenCustomerCardSelectedIssuingCustomerCard.id,
            receivingCustomerCardId:
                transfersBetweenCustomerCardSelectedReceivingCustomerCard.id,
            agentId: agentId ?? 0,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          transferStatus = await TransfersController.create(
            transfer: transfer,
          );

          if (transferStatus == ServiceResponse.success) {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: transferStatus,
              response: 'Opération réussie \n En attente de validation',
            );
          } else {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: transferStatus,
              response: 'Opération échouée',
            );
          }
          FunctionsController.showAlertDialog(
            context: context,
            alertDialog: const ResponseDialog(),
          );
        }
      } else {
        ref
            .read(
              responseDialogProvider.notifier,
            )
            .state = ResponseDialogModel(
          serviceResponse: ServiceResponse.failed,
          response:
              'Opération échouée \n Veuillez sélectionner deux cartes différentes',
        );
        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const ResponseDialog(),
        );
      }

      enableTransferButton.value = true;
    }
  }

  static Future<void> createBetweenCustomersAccounts({
    required BuildContext context,
    required WidgetRef ref,
    required ValueNotifier<bool> enableTransferButton,
  }) async {
    final transfersBetweenCustomersAccountsSelectedIssuingCustomerCard =
        ref.watch(
            transfersBetweenCustomersAccountsSelectedIssuingCustomerCardProvider);

    final transfersBetweenCustomersAccountsSelectedIssuingCustomerCardType =
        ref.watch(
      transfersBetweenCustomersAccountsSelectedIssuingCustomerCardTypeProvider,
    );

    final transfersBetweenCustomersAccountsSelectedReceivingCustomerCard =
        ref.watch(
            transfersBetweenCustomersAccountsSelectedReceivingCustomerCardProvider);

    final transfersBetweenCustomersAccountsSelectedReceivingCustomerCardType =
        ref.watch(
            transfersBetweenCustomersAccountsSelectedReceivingCustomerCardTypeProvider);

    // checkif issuing and receiving customer cards have been selected
    if (transfersBetweenCustomersAccountsSelectedIssuingCustomerCard != null &&
        transfersBetweenCustomersAccountsSelectedIssuingCustomerCard.id !=
            null &&
        transfersBetweenCustomersAccountsSelectedReceivingCustomerCard !=
            null &&
        transfersBetweenCustomersAccountsSelectedReceivingCustomerCard.id !=
            null) {
      enableTransferButton.value = false;
      // check if issuing and receiving customers cards are differents
      if (transfersBetweenCustomersAccountsSelectedReceivingCustomerCard !=
          transfersBetweenCustomersAccountsSelectedIssuingCustomerCard) {
        // get current issuing settlements totals
        final issuingCustomerCardSettlements =
            await SettlementsController.getAll(
          customerCardId:
              transfersBetweenCustomersAccountsSelectedIssuingCustomerCard.id,
        ).first;

        int settlementsNumbersTotal = 0;
        for (Settlement settlement in issuingCustomerCardSettlements) {
          settlementsNumbersTotal += settlement.number;
        }

        // calculate the amount to transefered
        final issuingCustomerCardTransferedAmount = ((2 *
                    (transfersBetweenCustomersAccountsSelectedIssuingCustomerCard
                            .typeNumber *
                        transfersBetweenCustomersAccountsSelectedIssuingCustomerCardType!
                            .stake *
                        settlementsNumbersTotal) /
                    3) -
                300)
            .round();

        // calculate the number of settlements to receive
        final settlementsNumberReceived = (issuingCustomerCardTransferedAmount /
                transfersBetweenCustomersAccountsSelectedReceivingCustomerCardType!
                    .stake)
            .round();
        if (issuingCustomerCardTransferedAmount <= 0 ||
            settlementsNumberReceived <= 0) {
          ref
              .read(
                responseDialogProvider.notifier,
              )
              .state = ResponseDialogModel(
            serviceResponse: ServiceResponse.failed,
            response: 'Opération échouée \n Solde insuffisant',
          );
          FunctionsController.showAlertDialog(
            context: context,
            alertDialog: const ResponseDialog(),
          );
        } else {
          // launch transfer

          ServiceResponse transferStatus;

          final prefs = await SharedPreferences.getInstance();
          final agentId = prefs.getInt(CBConstants.agentIdPrefKey);

          final transfer = Transfer(
            issuingCustomerCardId:
                transfersBetweenCustomersAccountsSelectedIssuingCustomerCard.id,
            receivingCustomerCardId:
                transfersBetweenCustomersAccountsSelectedReceivingCustomerCard
                    .id,
            agentId: agentId ?? 0,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          transferStatus = await TransfersController.create(
            transfer: transfer,
          );

          if (transferStatus == ServiceResponse.success) {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: transferStatus,
              response: 'Opération réussie \n En attente de validation',
            );
          } else {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: transferStatus,
              response: 'Opération échouée',
            );
          }
          FunctionsController.showAlertDialog(
            context: context,
            alertDialog: const ResponseDialog(),
          );
        }
      } else {
        ref
            .read(
              responseDialogProvider.notifier,
            )
            .state = ResponseDialogModel(
          serviceResponse: ServiceResponse.failed,
          response:
              'Opération échouée \n Veuillez sélectionner deux cartes différentes',
        );
        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const ResponseDialog(),
        );
      }

      enableTransferButton.value = true;
    }
  }

  static Future<void> validate({
    required BuildContext context,
    required WidgetRef ref,
    required Transfer transfer,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    showConfirmationButton.value = false;
    // get issuing card data (card, type, settlements)
    final issuingCustomerCard = await CustomersCardsController.getOne(
      id: transfer.issuingCustomerCardId,
    );

    if (issuingCustomerCard != null) {
      // get issuingCustomerCard type

      final issuingCustomerCardType = await TypesController.getOne(
        id: issuingCustomerCard.typeId,
      );

      if (issuingCustomerCardType != null) {
        // get issuingCustomerCard settlements

        final issuingCustomerCardSettlements =
            await SettlementsController.getAll(
          customerCardId: issuingCustomerCard.id!,
        ).first;

        // calculate issuing customer card settlements number total
        int issuingCustomerCardSettlementsNumbersTotal = 0;

        for (int i = 0; i < issuingCustomerCardSettlements.length; ++i) {
          issuingCustomerCardSettlementsNumbersTotal +=
              issuingCustomerCardSettlements[i].number;
        }

        if (issuingCustomerCardSettlementsNumbersTotal != 0) {
          // get receiving card data (card, type, settlements)

          final receivingCustomerCard = await CustomersCardsController.getOne(
            id: transfer.receivingCustomerCardId,
          );

          if (receivingCustomerCard != null) {
            // get receivingCustomerCard type

            final receivingCustomerCardType = await TypesController.getOne(
              id: receivingCustomerCard.typeId,
            );

            if (receivingCustomerCardType != null) {
              // check if the available amount is sufficient for making a transfer
              final issuingCustomerCardTranferAmount = ((2 *
                          (issuingCustomerCard.typeNumber *
                              issuingCustomerCardType.stake *
                              issuingCustomerCardSettlementsNumbersTotal) /
                          3) -
                      300)
                  .round();

              int settlementsToTranfer = (issuingCustomerCardTranferAmount /
                      receivingCustomerCardType.stake)
                  .round();

              if (settlementsToTranfer > 0) {
                // get receivingCustomerCard settlements
                // and check if the number of settlement to add plus the
                // existant settlement isn't greater than 372

                // get receivingCustomerCard settlements

                final receivingCustomerCardSettlements =
                    await SettlementsController.getAll(
                  customerCardId: receivingCustomerCard.id!,
                ).first;

                // calculate issuing customer card settlements number total
                int receivingCustomerCardSettlementsNumbersTotal = 0;

                for (int i = 0;
                    i < receivingCustomerCardSettlements.length;
                    ++i) {
                  receivingCustomerCardSettlementsNumbersTotal +=
                      receivingCustomerCardSettlements[i].number;
                }

                if (receivingCustomerCardSettlementsNumbersTotal +
                        settlementsToTranfer >
                    372) {
                  if (receivingCustomerCardSettlementsNumbersTotal == 372) {
                    ref.read(responseDialogProvider.notifier).state =
                        ResponseDialogModel(
                      serviceResponse: ServiceResponse.failed,
                      response:
                          'Opération échouée \n Les règlements ont été achevé sur la carte du compte récepteur',
                    );
                    showConfirmationButton.value = true;

                    FunctionsController.showAlertDialog(
                      context: context,
                      alertDialog: const ResponseDialog(),
                    );
                  } else {
                    // calculate the complement
                    final complementSettlements =
                        receivingCustomerCardSettlementsNumbersTotal +
                            settlementsToTranfer -
                            372;

                    // update the number of settlements to transfer

                    settlementsToTranfer =
                        settlementsToTranfer - complementSettlements;

                    // start transfer process

                    // update issuing card transfer date

                    final issuingCustomerCardUpdateStatus =
                        await CustomersCardsController.update(
                      id: issuingCustomerCard.id,
                      customerCard: issuingCustomerCard.copyWith(
                        transferredAt: DateTime.now(),
                      ),
                    );

                    if (issuingCustomerCardUpdateStatus ==
                        ServiceResponse.success) {
                      // add settelements to receiving customer card

                      final prefs = await SharedPreferences.getInstance();
                      final agentId = prefs.getInt(CBConstants.agentIdPrefKey);

                      final receivingCustomerCardSettlementsStatus =
                          await SettlementsController.create(
                        settlement: Settlement(
                          number: settlementsToTranfer,
                          cardId: receivingCustomerCard.id,
                          agentId: agentId ?? 0,
                          collectionId: null,
                          collectedAt: null,
                          createdAt: DateTime.now(),
                          isValiated: true,
                          updatedAt: DateTime.now(),
                        ),
                      );

                      if (receivingCustomerCardSettlementsStatus ==
                          ServiceResponse.success) {
                        // update transfer validation date

                        final transferUpdateStatus =
                            await TransfersController.update(
                          id: transfer.id!,
                          transfer: transfer.copyWith(
                            validatedAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                        );

                        if (transferUpdateStatus == ServiceResponse.success) {
                          ref.read(responseDialogProvider.notifier).state =
                              ResponseDialogModel(
                            serviceResponse: transferUpdateStatus,
                            response:
                                'Opération réussie \n Complément de règlements restants: $complementSettlements soit ${(issuingCustomerCard.typeNumber * issuingCustomerCardType.stake * complementSettlements).toInt()}f',
                          );

                          // this, for avoiding to automatically clause sucess dialog in order to show the complement settlements
                          ref
                              .read(
                                remarkSuccessResponseDialogProvider.notifier,
                              )
                              .state = false;
                          showConfirmationButton.value = true;
                          Navigator.of(context).pop();
                        } else {
                          ref.read(responseDialogProvider.notifier).state =
                              ResponseDialogModel(
                            serviceResponse: transferUpdateStatus,
                            response: 'Opération échouée',
                          );
                          showConfirmationButton.value = true;
                        }
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const ResponseDialog(),
                        );
                      } else {
                        // impossible to add receiving card
                        // transferred  settlements
                        ref.read(responseDialogProvider.notifier).state =
                            ResponseDialogModel(
                          serviceResponse: ServiceResponse.failed,
                          response:
                              'Opération échouée \n Impossible d\'ajouter les règlements sur le compte récepteur',
                        );
                        showConfirmationButton.value = true;
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const ResponseDialog(),
                        );
                      }
                    } else {
                      // impossible to update issuingCustomerCard
                      ref.read(responseDialogProvider.notifier).state =
                          ResponseDialogModel(
                        serviceResponse: ServiceResponse.failed,
                        response:
                            'Opération échouée \n Impossible de griser la carte',
                      );
                      showConfirmationButton.value = true;
                      FunctionsController.showAlertDialog(
                        context: context,
                        alertDialog: const ResponseDialog(),
                      );
                    }
                  }
                } else {
                  // make simply the transfer

                  // update issuing card transfer date

                  final issuingCustomerCardUpdateStatus =
                      await CustomersCardsController.update(
                    id: issuingCustomerCard.id,
                    customerCard: issuingCustomerCard.copyWith(
                      transferredAt: DateTime.now(),
                    ),
                  );

                  if (issuingCustomerCardUpdateStatus ==
                      ServiceResponse.success) {
                    // add settelements to receiving customer card

                    final prefs = await SharedPreferences.getInstance();
                    final agentId = prefs.getInt(CBConstants.agentIdPrefKey);

                    final receivingCustomerCardSettlementsStatus =
                        await SettlementsController.create(
                      settlement: Settlement(
                        number: settlementsToTranfer,
                        cardId: receivingCustomerCard.id,
                        agentId: agentId ?? 0,
                        collectionId: null,
                        collectedAt: null,
                        createdAt: DateTime.now(),
                        isValiated: true,
                        updatedAt: DateTime.now(),
                      ),
                    );

                    if (receivingCustomerCardSettlementsStatus ==
                        ServiceResponse.success) {
                      // update transfer validation date

                      final transferUpdateStatus =
                          await TransfersController.update(
                        id: transfer.id!,
                        transfer: transfer.copyWith(
                          validatedAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        ),
                      );

                      if (transferUpdateStatus == ServiceResponse.success) {
                        ref.read(responseDialogProvider.notifier).state =
                            ResponseDialogModel(
                          serviceResponse: transferUpdateStatus,
                          response: 'Opération réussie',
                        );
                        showConfirmationButton.value = true;
                        Navigator.of(context).pop();
                      } else {
                        ref.read(responseDialogProvider.notifier).state =
                            ResponseDialogModel(
                          serviceResponse: transferUpdateStatus,
                          response: 'Opération échouée',
                        );
                        showConfirmationButton.value = true;
                      }
                      FunctionsController.showAlertDialog(
                        context: context,
                        alertDialog: const ResponseDialog(),
                      );
                    } else {
                      // impossible to add receiving card
                      // transferred  settlements
                      ref.read(responseDialogProvider.notifier).state =
                          ResponseDialogModel(
                        serviceResponse: ServiceResponse.failed,
                        response:
                            'Opération échouée \n Impossible d\'ajouter les règlements sur le compte récepteur',
                      );
                      showConfirmationButton.value = true;

                      FunctionsController.showAlertDialog(
                        context: context,
                        alertDialog: const ResponseDialog(),
                      );
                    }
                  } else {
                    // impossible to update issuingCustomerCard
                    ref.read(responseDialogProvider.notifier).state =
                        ResponseDialogModel(
                      serviceResponse: ServiceResponse.failed,
                      response:
                          'Opération échouée \n Impossible de griser la carte',
                    );
                    showConfirmationButton.value = true;

                    FunctionsController.showAlertDialog(
                      context: context,
                      alertDialog: const ResponseDialog(),
                    );
                  }
                }
              } else {
                //  insufficient amount
                ref.read(responseDialogProvider.notifier).state =
                    ResponseDialogModel(
                  serviceResponse: ServiceResponse.failed,
                  response:
                      'Opération échouée \n Le solde du compte émetteur est insuffisant',
                );
                showConfirmationButton.value = true;

                FunctionsController.showAlertDialog(
                  context: context,
                  alertDialog: const ResponseDialog(),
                );
              }
            } else {
              ref.read(responseDialogProvider.notifier).state =
                  ResponseDialogModel(
                serviceResponse: ServiceResponse.failed,
                response:
                    'Opération échouée \n Le type du compte récepteur n\'a pas été trouvé',
              );
              showConfirmationButton.value = true;

              FunctionsController.showAlertDialog(
                context: context,
                alertDialog: const ResponseDialog(),
              );
            }
          } else {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: ServiceResponse.failed,
              response:
                  'Opération échouée \n La carte du compte récepteur n\'a pas été trouvée',
            );
            showConfirmationButton.value = true;

            FunctionsController.showAlertDialog(
              context: context,
              alertDialog: const ResponseDialog(),
            );
          }
        } else {
          // impossible to make a transfer any settlement is done
          // on the issuing customer card
          ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
            serviceResponse: ServiceResponse.failed,
            response:
                'Opération échouée \n Aucun règlement n\'a été fait sur la carte du compte émetteur',
          );
          showConfirmationButton.value = true;
          FunctionsController.showAlertDialog(
            context: context,
            alertDialog: const ResponseDialog(),
          );
        }
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: ServiceResponse.failed,
          response:
              'Opération échouée \n Le type du compte émetteur n\'a pas été trouvé',
        );
        showConfirmationButton.value = true;
        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const ResponseDialog(),
        );
      }
    } else {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: ServiceResponse.failed,
        response:
            'Opération échouée \n La carte du compte émetteur n\'a pas été trouvée',
      );
      showConfirmationButton.value = true;

      FunctionsController.showAlertDialog(
        context: context,
        alertDialog: const ResponseDialog(),
      );
    }
  }

  static Future<void> discard({
    required BuildContext context,
    required WidgetRef ref,
    required Transfer transfer,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    showConfirmationButton.value = false;
    ServiceResponse lastTransferStatus;

    final newTransfer = transfer.copyWith(
      discardedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    lastTransferStatus = await TransfersController.update(
      id: transfer.id!,
      transfer: newTransfer,
    );

    if (lastTransferStatus == ServiceResponse.success) {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: lastTransferStatus,
        response: 'Opération réussie',
      );
      showConfirmationButton.value = true;
      Navigator.of(context).pop();
    } else {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: lastTransferStatus,
        response: 'Opération échouée',
      );
      showConfirmationButton.value = true;
    }
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const ResponseDialog(),
    );
  }

  static Future<void> delete({
    required BuildContext context,
    required WidgetRef ref,
    required Transfer transfer,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    showConfirmationButton.value = false;
    ServiceResponse transferStatus;

    transferStatus = await TransfersController.delete(transfer: transfer);

    if (transferStatus == ServiceResponse.success) {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: transferStatus,
        response: 'Opération réussie',
      );
      showConfirmationButton.value = true;
      Navigator.of(context).pop();
    } else {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: transferStatus,
        response: 'Opération échouée',
      );
      showConfirmationButton.value = true;
    }
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const ResponseDialog(),
    );
  }
}
