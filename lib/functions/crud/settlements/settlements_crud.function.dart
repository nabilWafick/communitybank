// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/forms/validators/settlement/settlement.validator.dart';
import 'package:communitybank/controllers/settlement/settlement.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/settlement/settlement.model.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/intenger_dropdown/intenger_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      final settlementNumber =
          ref.watch(formIntDropdownProvider('settlement-adding-number'));
      final settlementCustomerCard = ref.watch(settlementCustomerCardProvider);
      final settlementCollectionDate =
          ref.watch(settlementCollectionDateProvider);
      //  final settlementAgent = ref.watch(settlementAgentProvider);

      ServiceResponse settlementStatus;

      final settlement = Settlement(
        number: settlementNumber,
        cardId: settlementCustomerCard.id!,
        agentId: 1,
        collectAt: settlementCollectionDate!,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      settlementStatus =
          await SettlementsController.create(settlement: settlement);

      // debugPrint('new Settlement: $settlementStatus');

      if (settlementStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: settlementStatus,
          response: 'Opération réussie',
        );
        showValidatedButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
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
        collectAt: settlementCollectionDate!,
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
