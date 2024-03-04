// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/collection/collection.controller.dart';
import 'package:communitybank/controllers/forms/validators/multiple_settlements/multiple_settlements.validator.dart';
import 'package:communitybank/controllers/forms/validators/settlement/settlement.validator.dart';
import 'package:communitybank/controllers/settlement/settlement.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/models/data/settlement/settlement.model.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/utils/constants/constants.util.dart';
import 'package:communitybank/views/widgets/cash/cash_operations/search_options/search_options.widget.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettlementCRUDFunctions {
  static Future<void> create({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      final settlementNumber = ref.watch(settlementNumberProvider);
      final settlementType = ref.watch(
          cashOperationsSelectedCustomerAccountOwnerSelectedCardTypeProvider);
      final settlementCustomerCard = ref.watch(
          cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider);
      final settlementCollector =
          ref.watch(cashOperationsSelectedCustomerAccountCollectorProvider);
      final settlementCollectionDate =
          ref.watch(settlementCollectionDateProvider);

      // if collection date have not been selected
      if (settlementCollectionDate == null) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: ServiceResponse.failed,
          response: 'La date de collecte n\'a  pas été selectionnée',
        );
        showValidatedButton.value = true;
        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const ResponseDialog(),
        );
      } else {
        final customerCardSettlements = await SettlementsController.getAll(
          customerCardId: settlementCustomerCard!.id,
        ).first;

        int customerCardSettlementsNumbersTotal = 0;

        for (Settlement settlement in customerCardSettlements) {
          customerCardSettlementsNumbersTotal += settlement.number;
        }

        // if the number of settlement done before plus the number of settlement to add is greater than 372 (the total number of settelements of a customer card)

        if (customerCardSettlementsNumbersTotal + settlementNumber > 372) {
          ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
            serviceResponse: ServiceResponse.failed,
            response:
                'Le nombre de règlement à ajouter est supérieur au restant',
          );
          showValidatedButton.value = true;
          FunctionsController.showAlertDialog(
            context: context,
            alertDialog: const ResponseDialog(),
          );
        } else {
          // check if the collector have made a collection that day
          final collectorsCollections = await CollectionsController.getAll(
            collectorId: settlementCollector!.id!,
            collectedAt: settlementCollectionDate,
            agentId: 0,
          ).first;

          if (collectorsCollections.isEmpty) {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: ServiceResponse.failed,
              response:
                  'Opération échouée \n Le collecteur n\'a pas effectué  de collecte ce jour',
            );
            showValidatedButton.value = true;
            FunctionsController.showAlertDialog(
              context: context,
              alertDialog: const ResponseDialog(),
            );
          } else {
            final collectorCollection = collectorsCollections.first;

            // check if the rest of amount of that collection is enough for
            // doing the settlement
            if (collectorCollection.rest -
                    settlementNumber *
                        settlementCustomerCard.typeNumber *
                        settlementType!.stake <
                0) {
              ref.read(responseDialogProvider.notifier).state =
                  ResponseDialogModel(
                serviceResponse: ServiceResponse.failed,
                response:
                    'Opération échouée \n Le montant restant de la collecte du collecteur est insuffisant',
              );
              showValidatedButton.value = true;
              FunctionsController.showAlertDialog(
                context: context,
                alertDialog: const ResponseDialog(),
              );
            } else {
              // ready for doing the settlement
              // update collection rest amount
              ServiceResponse collectionUpdateStatus;

              // substract settlement amount from collectorCollection rest
              final newCollectorCollection = collectorCollection.copyWith(
                rest: collectorCollection.rest -
                    settlementNumber *
                        settlementCustomerCard.typeNumber *
                        settlementType.stake,
                updatedAt: DateTime.now(),
              );

              collectionUpdateStatus = await CollectionsController.update(
                id: collectorCollection.id!,
                collection: newCollectorCollection,
              );

              if (collectionUpdateStatus == ServiceResponse.failed) {
                ref.read(responseDialogProvider.notifier).state =
                    ResponseDialogModel(
                  serviceResponse: ServiceResponse.failed,
                  response:
                      'Opération échouée \n Le montant restant de la collecte du collecteur n\'a pas pu été mis à jour',
                );
                showValidatedButton.value = true;
                FunctionsController.showAlertDialog(
                  context: context,
                  alertDialog: const ResponseDialog(),
                );
              } else {
                ServiceResponse settlementStatus;

                final prefs = await SharedPreferences.getInstance();
                final agentId = prefs.getInt(CBConstants.agentIdPrefKey);

                final settlement = Settlement(
                  number: settlementNumber,
                  cardId: settlementCustomerCard.id!,
                  agentId: agentId ?? 0,
                  collectionId: collectorCollection.id!,
                  collectedAt: settlementCollectionDate,
                  isValiated: true,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                );

                settlementStatus =
                    await SettlementsController.create(settlement: settlement);

                if (settlementStatus == ServiceResponse.success) {
                  ref.read(responseDialogProvider.notifier).state =
                      ResponseDialogModel(
                    serviceResponse: settlementStatus,
                    response: 'Opération réussie',
                  );
                  showValidatedButton.value = true;
                  Navigator.of(context).pop();
                } else {
                  ref.read(responseDialogProvider.notifier).state =
                      ResponseDialogModel(
                    serviceResponse: settlementStatus,
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
  }

  static Future<void> createMultipleSettlements({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      final multipleSettlementsSelectedTypes =
          ref.watch(multipleSettlementsSelectedTypesProvider);

      if (multipleSettlementsSelectedTypes.isEmpty) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: ServiceResponse.failed,
          response: 'Un type doit être ajouté',
        );
        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const ResponseDialog(),
        );
      } else {
        // store customer types
        List<Type> selectedTypes = [];
        // check if a type repeated
        for (MapEntry multipleSettlementsSelectedTypesEntry
            in multipleSettlementsSelectedTypes.entries) {
          selectedTypes.add(
            multipleSettlementsSelectedTypesEntry.value,
          );
        }

        // verify if a Type is repeated or is selected more than one time
        // in typeSelectedTypes
        bool isTypeRepeated = false; // used to detect repetion
        // used to count the Type occurrences number
        int typeNumber = 0;

        for (Type typeF in selectedTypes) {
          isTypeRepeated = false;
          typeNumber = 0;
          for (Type typeL in selectedTypes) {
            if (typeF == typeL) {
              ++typeNumber;
            }
          }
          // debugPrint('repeated Type: ${TypeF.toString()}');
          // debugPrint('TypeNumber: $TypeNumber');
          if (typeNumber > 1) {
            isTypeRepeated = true;
            break;
          }
        }

        if (isTypeRepeated == true) {
          // show validated button to permit a correction from the user
          showValidatedButton.value = true;
          ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
            serviceResponse: ServiceResponse.failed,
            response: 'Répétition de produit dans le type',
          );
          FunctionsController.showAlertDialog(
            context: context,
            alertDialog: const ResponseDialog(),
          );
          isTypeRepeated = false;
          typeNumber = 0;
        }

        final settlementCollectionDate =
            ref.watch(settlementCollectionDateProvider);

        // if collection date have not been selected
        if (settlementCollectionDate == null) {
          ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
            serviceResponse: ServiceResponse.failed,
            response: 'La date de collecte n\'a  pas été selectionnée',
          );
          showValidatedButton.value = true;
          FunctionsController.showAlertDialog(
            context: context,
            alertDialog: const ResponseDialog(),
          );
        } else {
          showValidatedButton.value = false;
          final multipleSettlementsSelectedCustomerCards =
              ref.watch(multipleSettlementsSelectedCustomerCardsProvider);
          final multipleSettlementsAddedInputs =
              ref.watch(multipleSettlementsAddedInputsProvider);
          final settlementCollector =
              ref.watch(cashOperationsSelectedCustomerAccountCollectorProvider);
          // store customer cards
          List<CustomerCard> selectedCustomerCards = [];

          // store the number of settlements
          List<int> settlementsNumbers = [];

          for (MapEntry multipleSettlementsSelectedCustomerCardsEntry
              in multipleSettlementsSelectedCustomerCards.entries) {
            selectedCustomerCards.add(
              multipleSettlementsSelectedCustomerCardsEntry.value,
            );
          }

          for (MapEntry multipleSettlementsAddedInputsEntry
              in multipleSettlementsAddedInputs.entries) {
            // verify if the input is visible
            if (multipleSettlementsAddedInputsEntry.value) {
              settlementsNumbers.add(
                ref.watch(
                  multipleSettlementsSettlementNumberProvider(
                    multipleSettlementsAddedInputsEntry.key,
                  ),
                ),
              );
            }
          }

          List<ServiceResponse> settlementCreationResponses = [];
          for (int i = 0; i > selectedTypes.length; ++i) {
            final response = await singleSettlementCreation(
              customerCard: selectedCustomerCards[i],
              type: selectedTypes[i],
              settlementNumber: settlementsNumbers[i],
            );
            settlementCreationResponses.add(response);
          }

          final isAllCreationSucceed = settlementCreationResponses.every(
            (response) => response == ServiceResponse.success,
          );

          if (isAllCreationSucceed) {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: ServiceResponse.failed,
              response: 'Opération Terminée \n Totalement réussie',
            );
            showValidatedButton.value = true;
            Navigator.of(context).pop();
          } else {
            ResponseDialogModel(
              serviceResponse: ServiceResponse.failed,
              response: 'Opération Terminée \n Non Totalement réussie',
            );
          }
          FunctionsController.showAlertDialog(
            context: context,
            alertDialog: const ResponseDialog(),
          );
        }
      }
    }
  }

  static Future<ServiceResponse> singleSettlementCreation({
    required CustomerCard customerCard,
    required Type type,
    required int settlementNumber,
  }) async {
    return ServiceResponse.waiting;
  }

  static Future<void> update({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required Settlement settlement,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    if (settlement.isValiated) {
      formKey.currentState!.save();
      final isFormValid = formKey.currentState!.validate();
      if (isFormValid) {
        showValidatedButton.value = false;
        final settlementNumber = ref.watch(settlementNumberProvider);
        final settlementType = ref.watch(
            cashOperationsSelectedCustomerAccountOwnerSelectedCardTypeProvider);
        final settlementCustomerCard = ref.watch(
            cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider);
        final settlementCollector =
            ref.watch(cashOperationsSelectedCustomerAccountCollectorProvider);
        final settlementCollectionDate =
            ref.watch(settlementCollectionDateProvider);

        // if collection date have not been selected
        if (settlementCollectionDate == null) {
          ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
            serviceResponse: ServiceResponse.failed,
            response: 'La date de collecte n\'a  pas été selectionnée',
          );
          showValidatedButton.value = true;
          FunctionsController.showAlertDialog(
            context: context,
            alertDialog: const ResponseDialog(),
          );
        } else {
          final customerCardSettlements = await SettlementsController.getAll(
                  customerCardId: settlementCustomerCard!.id)
              .first;

          int customerCardSettlementsNumbersTotal = 0;

          for (Settlement settlement in customerCardSettlements) {
            customerCardSettlementsNumbersTotal += settlement.number;
          }

          // if the number of settlement added (in which we substract the
          // previous settlement) plus the number of settlement to add is
          // greater than 372 (the total number of settelements
          // of a customer card)

          if ((customerCardSettlementsNumbersTotal - settlement.number) +
                  settlementNumber >
              372) {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: ServiceResponse.failed,
              response:
                  'Le nombre de règlement à ajouter est supérieur au restant',
            );
            showValidatedButton.value = true;
            FunctionsController.showAlertDialog(
              context: context,
              alertDialog: const ResponseDialog(),
            );
          } else {
            // check if the collector have made a collection that day
            final collectorsCollections = await CollectionsController.getAll(
              collectorId: settlementCollector!.id!,
              collectedAt: settlementCollectionDate,
              agentId: 0,
            ).first;

            if (collectorsCollections.isEmpty) {
              ref.read(responseDialogProvider.notifier).state =
                  ResponseDialogModel(
                serviceResponse: ServiceResponse.failed,
                response:
                    'Opération échouée \n Le collecteur n\'a pas effectué  de collecte ce jour',
              );
              showValidatedButton.value = true;
              FunctionsController.showAlertDialog(
                context: context,
                alertDialog: const ResponseDialog(),
              );
            } else {
              final collectorCollection = collectorsCollections.first;

              // check if settlement update date is the same as the previous date
              // (the collection date of the settlement before update)

              if (settlement.collectedAt.year ==
                      settlementCollectionDate.year &&
                  settlement.collectedAt.month ==
                      settlementCollectionDate.month &&
                  settlement.collectedAt.day == settlementCollectionDate.day) {
                // check if the rest of amount of that collection  (on which we  add  the previous settlement amount ) is enough for
                // updating the settlement
                if ((collectorCollection.rest +
                            settlement.number *
                                settlementCustomerCard.typeNumber *
                                settlementType!.stake) -
                        settlementNumber *
                            settlementCustomerCard.typeNumber *
                            settlementType.stake <
                    0) {
                  ref.read(responseDialogProvider.notifier).state =
                      ResponseDialogModel(
                    serviceResponse: ServiceResponse.failed,
                    response:
                        'Opération échouée \n Le montant restant de la collecte du collecteur est insuffisant',
                  );
                  showValidatedButton.value = true;
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const ResponseDialog(),
                  );
                } else {
                  // ready for updating the settlement
                  // update collection rest amount
                  ServiceResponse collectionUpdateStatus;

                  // add the previous settlement amount and substract the new settlement amount from collectorCollection rest
                  final newCollectorCollection = collectorCollection.copyWith(
                    rest: (collectorCollection.rest +
                            settlement.number *
                                settlementCustomerCard.typeNumber *
                                settlementType.stake) -
                        settlementNumber *
                            settlementCustomerCard.typeNumber *
                            settlementType.stake,
                    updatedAt: DateTime.now(),
                  );

                  collectionUpdateStatus = await CollectionsController.update(
                    id: collectorCollection.id!,
                    collection: newCollectorCollection,
                  );

                  if (collectionUpdateStatus == ServiceResponse.failed) {
                    ref.read(responseDialogProvider.notifier).state =
                        ResponseDialogModel(
                      serviceResponse: ServiceResponse.failed,
                      response:
                          'Opération échouée \n Le montant restant de la collecte du collecteur n\'a pas pu été mis à jour',
                    );
                    showValidatedButton.value = true;
                    FunctionsController.showAlertDialog(
                      context: context,
                      alertDialog: const ResponseDialog(),
                    );
                  } else {
                    ServiceResponse lastSettlementStatus;

                    final newSettlement = Settlement(
                      number: settlementNumber,
                      cardId: settlement.cardId,
                      agentId: settlement.agentId,
                      collectionId: collectorCollection.id!,
                      collectedAt: settlementCollectionDate,
                      isValiated: settlement.isValiated,
                      createdAt: settlement.createdAt,
                      updatedAt: DateTime.now(),
                    );

                    lastSettlementStatus = await SettlementsController.update(
                      id: settlement.id!,
                      settlement: newSettlement,
                    );

                    if (lastSettlementStatus == ServiceResponse.success) {
                      ref.read(responseDialogProvider.notifier).state =
                          ResponseDialogModel(
                        serviceResponse: lastSettlementStatus,
                        response: 'Opération réussie',
                      );
                      showValidatedButton.value = true;
                      Navigator.of(context).pop();
                    } else {
                      ref.read(responseDialogProvider.notifier).state =
                          ResponseDialogModel(
                        serviceResponse: lastSettlementStatus,
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
              } else {
                // it is not  the same collection date
                {
                  // get the collections at the previous settlementDate
                  final previousCollections =
                      await CollectionsController.getAll(
                    collectorId: settlementCollector.id,
                    collectedAt: settlement.collectedAt,
                    agentId: 0,
                  ).first;

                  final previousCollection = previousCollections.first;
                  // check if the rest of amount of the new collection  is enough for adding the settlement
                  // collectorCollection is the the collection at the new date
                  if (collectorCollection.rest -
                          settlementNumber *
                              settlementCustomerCard.typeNumber *
                              settlementType!.stake <
                      0) {
                    ref.read(responseDialogProvider.notifier).state =
                        ResponseDialogModel(
                      serviceResponse: ServiceResponse.failed,
                      response:
                          'Opération échouée \n Le montant restant de la collecte du collecteur à la nouvelle date est insuffisant',
                    );
                    showValidatedButton.value = true;
                    FunctionsController.showAlertDialog(
                      context: context,
                      alertDialog: const ResponseDialog(),
                    );
                  } else {
                    // update the previous collection

                    ServiceResponse previousCollectionUpdateStatus;
                    // add the previous settlement amount to the collection
                    // rest amount
                    final previousCollectorCollection =
                        previousCollection.copyWith(
                      rest: previousCollection.rest +
                          settlement.number *
                              settlementCustomerCard.typeNumber *
                              settlementType.stake,
                      updatedAt: DateTime.now(),
                    );

                    previousCollectionUpdateStatus =
                        await CollectionsController.update(
                      id: previousCollection.id!,
                      collection: previousCollectorCollection,
                    );

                    if (previousCollectionUpdateStatus !=
                        ServiceResponse.success) {
                      ref.read(responseDialogProvider.notifier).state =
                          ResponseDialogModel(
                        serviceResponse: ServiceResponse.failed,
                        response:
                            'Opération échouée \n Le montant restant de l\'ancienne collecte du collecteur n\'a pas pu été mis à jour',
                      );
                      showValidatedButton.value = true;
                      FunctionsController.showAlertDialog(
                        context: context,
                        alertDialog: const ResponseDialog(),
                      );
                    } else {
                      // ready for updation the new collection amount since the previous have been succesfully update

                      // ready for updating the settlement

                      // update the new collection rest amount
                      ServiceResponse newCollectionUpdateStatus;

                      // and substract the new settlement amount from newCollectorCollection rest
                      final newCollectorCollection =
                          collectorCollection.copyWith(
                        rest: collectorCollection.rest +
                            -settlementNumber *
                                settlementCustomerCard.typeNumber *
                                settlementType.stake,
                        updatedAt: DateTime.now(),
                      );

                      newCollectionUpdateStatus =
                          await CollectionsController.update(
                        id: collectorCollection.id!,
                        collection: newCollectorCollection,
                      );

                      if (newCollectionUpdateStatus == ServiceResponse.failed) {
                        ref.read(responseDialogProvider.notifier).state =
                            ResponseDialogModel(
                          serviceResponse: ServiceResponse.failed,
                          response:
                              'Opération échouée \n Le montant restant de la nouvelle collecte du collecteur n\'a pas pu été mis à jour',
                        );
                        showValidatedButton.value = true;
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const ResponseDialog(),
                        );
                      } else {
                        ServiceResponse lastSettlementStatus;

                        final newSettlement = Settlement(
                          number: settlementNumber,
                          cardId: settlement.cardId,
                          agentId: settlement.agentId,
                          collectionId: collectorCollection.id!,
                          collectedAt: settlementCollectionDate,
                          isValiated: settlement.isValiated,
                          createdAt: settlement.createdAt,
                          updatedAt: DateTime.now(),
                        );

                        lastSettlementStatus =
                            await SettlementsController.update(
                          id: settlement.id!,
                          settlement: newSettlement,
                        );

                        if (lastSettlementStatus == ServiceResponse.success) {
                          ref.read(responseDialogProvider.notifier).state =
                              ResponseDialogModel(
                            serviceResponse: lastSettlementStatus,
                            response: 'Opération réussie',
                          );
                          showValidatedButton.value = true;
                          Navigator.of(context).pop();
                        } else {
                          ref.read(responseDialogProvider.notifier).state =
                              ResponseDialogModel(
                            serviceResponse: lastSettlementStatus,
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
          }
        }
      }
    } else {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: ServiceResponse.failed,
        response: 'Opération échouée \n Le règlement n\'est pas validé',
      );
      showValidatedButton.value = true;
      FunctionsController.showAlertDialog(
        context: context,
        alertDialog: const ResponseDialog(),
      );
    }
  }

  static Future<void> updateValidationStatus({
    required BuildContext context,
    required WidgetRef ref,
    required Settlement settlement,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    showConfirmationButton.value = false;
    if (settlement.isValiated) {
      final settlementType = ref.watch(
          cashOperationsSelectedCustomerAccountOwnerSelectedCardTypeProvider);
      final settlementCollector =
          ref.watch(cashOperationsSelectedCustomerAccountCollectorProvider);
      final settlementCustomerCard = ref.watch(
          cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider);

      // update settlement by swith off the vaidation

      ServiceResponse settlementUpdateStatus;

      final newSettlement = Settlement(
        number: settlement.number,
        cardId: settlement.cardId,
        agentId: settlement.agentId,
        collectionId: settlement.collectionId,
        collectedAt: settlement.collectedAt,
        isValiated: !settlement.isValiated,
        createdAt: settlement.createdAt,
        updatedAt: DateTime.now(),
      );

      settlementUpdateStatus = await SettlementsController.update(
        id: settlement.id!,
        settlement: newSettlement,
      );

      if (settlementUpdateStatus != ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: settlementUpdateStatus,
          response: 'Opération échouée',
        );
        showConfirmationButton.value = true;
        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const ResponseDialog(),
        );
      } else {
        // update collector collection

        final collectorsCollections = await CollectionsController.getAll(
          collectorId: settlementCollector!.id!,
          collectedAt: settlement.collectedAt,
          agentId: 0,
        ).first;

        final collectorCollection = collectorsCollections.first;

        ServiceResponse collectorCollectionUpdateStatus;

        final newCollectorCollection = collectorCollection.copyWith(
          rest: collectorCollection.rest +
              settlement.number *
                  settlementCustomerCard!.typeNumber *
                  settlementType!.stake,
        );

        collectorCollectionUpdateStatus = await CollectionsController.update(
          id: collectorCollection.id!,
          collection: newCollectorCollection,
        );

        if (collectorCollectionUpdateStatus != ServiceResponse.success) {
          ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
            serviceResponse: collectorCollectionUpdateStatus,
            response:
                'Opération échouée \n La collecte du collector n\'a pas été mise à jour',
          );

          showConfirmationButton.value = true;
          Navigator.of(context).pop();
          FunctionsController.showAlertDialog(
            context: context,
            alertDialog: const ResponseDialog(),
          );
        } else {
          ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
            serviceResponse: collectorCollectionUpdateStatus,
            response: 'Opération réussie',
          );
          showConfirmationButton.value = true;
          Navigator.of(context).pop();
          FunctionsController.showAlertDialog(
            context: context,
            alertDialog: const ResponseDialog(),
          );
        }
      }
    } else {
      final settlementCustomerCard = ref.watch(
          cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider);
      // update the settlement by switch on the validation status

      // before update check if the total number of settlemet on the customer card  + the number of the settlement to validate is not greather thant 372

      final customerCardSettlements = await SettlementsController.getAll(
        customerCardId: settlementCustomerCard!.id,
      ).first;

      int customerCardSettlementsNumbersTotal = 0;

      for (Settlement settlement in customerCardSettlements) {
        customerCardSettlementsNumbersTotal += settlement.number;
      }

      // if the number of settlement added  plus the number of settlement to add is greater than 372 (the total number of settelements of a customer card)

      if (customerCardSettlementsNumbersTotal + settlement.number > 372) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: ServiceResponse.failed,
          response: 'Le nombre de règlement à ajouter est supérieur au restant',
        );
        showConfirmationButton.value = true;
        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const ResponseDialog(),
        );
      } else {
        final settlementType = ref.watch(
            cashOperationsSelectedCustomerAccountOwnerSelectedCardTypeProvider);
        final settlementCollector =
            ref.watch(cashOperationsSelectedCustomerAccountCollectorProvider);

        // update settlement by swith off the vaidation

        ServiceResponse settlementUpdateStatus;

        final newSettlement = Settlement(
          number: settlement.number,
          cardId: settlement.cardId,
          agentId: settlement.agentId,
          collectionId: settlement.collectionId,
          collectedAt: settlement.collectedAt,
          isValiated: !settlement.isValiated,
          createdAt: settlement.createdAt,
          updatedAt: DateTime.now(),
        );

        settlementUpdateStatus = await SettlementsController.update(
          id: settlement.id!,
          settlement: newSettlement,
        );

        if (settlementUpdateStatus != ServiceResponse.success) {
          ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
            serviceResponse: settlementUpdateStatus,
            response: 'Opération échouée',
          );
          showConfirmationButton.value = true;

          FunctionsController.showAlertDialog(
            context: context,
            alertDialog: const ResponseDialog(),
          );
        } else {
          // update collector collection

          final collectorsCollections = await CollectionsController.getAll(
            collectorId: settlementCollector!.id!,
            collectedAt: settlement.collectedAt,
            agentId: 0,
          ).first;

          final collectorCollection = collectorsCollections.first;

          ServiceResponse collectorCollectionUpdateStatus;

          final newCollectorCollection = collectorCollection.copyWith(
            rest: collectorCollection.rest -
                settlement.number *
                    settlementCustomerCard.typeNumber *
                    settlementType!.stake,
          );

          collectorCollectionUpdateStatus = await CollectionsController.update(
            id: collectorCollection.id!,
            collection: newCollectorCollection,
          );

          if (collectorCollectionUpdateStatus != ServiceResponse.success) {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: collectorCollectionUpdateStatus,
              response:
                  'Opération échouée \n La collecte du collector n\'a pas été mise à jour',
            );
            showConfirmationButton.value = true;
            FunctionsController.showAlertDialog(
              context: context,
              alertDialog: const ResponseDialog(),
            );
          } else {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: collectorCollectionUpdateStatus,
              response: 'Opération réussie',
            );
            showConfirmationButton.value = true;
            Navigator.of(context).pop();

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
    required Settlement settlement,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    final settlementType = ref.watch(
      cashOperationsSelectedCustomerAccountOwnerSelectedCardTypeProvider,
    );
    final settlementCollector =
        ref.watch(cashOperationsSelectedCustomerAccountCollectorProvider);
    showConfirmationButton.value = false;

    final settlementCustomerCard = ref
        .watch(cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider);

    ServiceResponse settlementStatus;

    settlementStatus =
        await SettlementsController.delete(settlement: settlement);

    if (settlementStatus != ServiceResponse.success) {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: settlementStatus,
        response: 'Opération échouée',
      );
      showConfirmationButton.value = true;
      FunctionsController.showAlertDialog(
        context: context,
        alertDialog: const ResponseDialog(),
      );
    } else {
      if (settlement.isValiated) {
        // should update collector collection

        final collectorsCollections = await CollectionsController.getAll(
          collectorId: settlementCollector!.id!,
          collectedAt: settlement.collectedAt,
          agentId: 0,
        ).first;

        // store collector collection
        final collectorCollection = collectorsCollections.first;

        ServiceResponse collectorCollectionUpdateStatus;

        final newCollectorCollection = collectorCollection.copyWith(
          rest: collectorCollection.rest +
              settlement.number *
                  settlementCustomerCard!.typeNumber *
                  settlementType!.stake,
        );

        collectorCollectionUpdateStatus = await CollectionsController.update(
          id: collectorCollection.id!,
          collection: newCollectorCollection,
        );

        if (collectorCollectionUpdateStatus != ServiceResponse.success) {
          ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
            serviceResponse: collectorCollectionUpdateStatus,
            response:
                'Opération échouée \n La collecte du collecteur  n\'a pas pu  être mise à jour',
          );
          showConfirmationButton.value = true;
          FunctionsController.showAlertDialog(
            context: context,
            alertDialog: const ResponseDialog(),
          );
        } else {
          ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
            serviceResponse: collectorCollectionUpdateStatus,
            response: 'Opération réussie',
          );
          showConfirmationButton.value = true;
          Navigator.of(context).pop();
          FunctionsController.showAlertDialog(
            context: context,
            alertDialog: const ResponseDialog(),
          );
        }
      }
    }
  }
}
