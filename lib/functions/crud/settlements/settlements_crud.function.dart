// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/forms/validators/settlement/settlement.validator.dart';
import 'package:communitybank/controllers/settlement/settlement.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/settlement/settlement.model.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/utils/constants/constants.util.dart';
import 'package:communitybank/views/widgets/definitions/cash_operations/cash_operations_search_options/cash_operations_search_options.widget.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/intenger_dropdown/intenger_dropdown.widget.dart';
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
      final settlementCustomerCard = ref.watch(
          cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider);
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

        int customerCardSettlementsNumberTotal = 0;

        for (Settlement settlement in customerCardSettlements) {
          customerCardSettlementsNumberTotal += settlement.number;
        }

        // if the number of settlement added plus the number of settlement to add is greater than 372 (the total number of settelements of a customer card)

        if (customerCardSettlementsNumberTotal + settlementNumber > 372) {
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
          ServiceResponse settlementStatus;

          final prefs = await SharedPreferences.getInstance();
          final agentId = prefs.getInt(CBConstants.agentIdPrefKey);

          final settlement = Settlement(
            number: settlementNumber,
            cardId: settlementCustomerCard.id!,
            agentId: agentId ?? 0,
            collectedAt: settlementCollectionDate,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          settlementStatus =
              await SettlementsController.create(settlement: settlement);

          // debugPrint('new Settlement: $settlementStatus');

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

  static Future<void> update({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required Settlement settlement,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    formKey.currentState!.save();
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      final settlementNumber =
          ref.watch(formIntDropdownProvider('settlement-adding-number'));
      // final settlementCustomerCard = ref.watch(settlementCustomerCardProvider);
      final settlementCollectionDate =
          ref.watch(settlementCollectionDateProvider);
      //  final settlementAgent = ref.watch(settlementAgentProvider);

      ServiceResponse lastSettlementStatus;

      final newSettlement = Settlement(
        number: settlementNumber,
        cardId: settlement.cardId,
        agentId: settlement.agentId,
        collectedAt: settlementCollectionDate!,
        createdAt: settlement.createdAt,
        updatedAt: DateTime.now(),
      );

      lastSettlementStatus = await SettlementsController.update(
        id: settlement.id!,
        settlement: newSettlement,
      );

      // debugPrint('new Settlement: $settlementStatus');

      if (lastSettlementStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastSettlementStatus,
          response: 'Opération réussie',
        );
        showValidatedButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
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

  static Future<void> delete({
    required BuildContext context,
    required WidgetRef ref,
    required Settlement settlement,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    showConfirmationButton.value = false;

    ServiceResponse settlementStatus;

    settlementStatus =
        await SettlementsController.delete(settlement: settlement);

    if (settlementStatus == ServiceResponse.success) {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: settlementStatus,
        response: 'Opération réussie',
      );
      Navigator.of(context).pop();
    } else {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: settlementStatus,
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
