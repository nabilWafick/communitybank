// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/agents/agents.controller.dart';
import 'package:communitybank/controllers/forms/validators/agent/agent.validator.dart';
import 'package:communitybank/controllers/settlements/settlements.controller.dart';
import 'package:communitybank/controllers/transfers/transfers.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/agent/agent.model.dart';
import 'package:communitybank/models/data/settlement/settlement.model.dart';
import 'package:communitybank/models/data/transfer/transfer.model.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/utils/constants/constants.util.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/transferts/between_customers_accounts/between_customer_cards_data/between_customer_cards_data.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransferCRUDFunctions {
  static Future<void> create({
    required BuildContext context,
    required WidgetRef ref,
    required ValueNotifier<bool> enableTransferButton,
  }) async {
    final transfersBetweenCustomerCardSelectedIssuingCustomerCard = ref
        .watch(transfersBetweenCustomerCardSelectedIssuingCustomerCardProvider);

    final transfersBetweenCustomerCardSelectedIssuingCustomerCardType =
        ref.watch(
            transfersBetweenCustomerCardSelectedIssuingCustomerCardTypeProvider);
    final transfersBetweenCustomerCardsSelectedCustomerAccount =
        ref.watch(transfersBetweenCustomerCardsSelectedCustomerAccountProvider);

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
        final issuingCustomerCardTransferedAmount = 2 *
            ((transfersBetweenCustomerCardSelectedIssuingCustomerCard
                            .typeNumber *
                        transfersBetweenCustomerCardSelectedIssuingCustomerCardType!
                            .stake *
                        settlementsNumbersTotal) /
                    3 -
                300.round());

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
            customerAccountId:
                transfersBetweenCustomerCardsSelectedCustomerAccount!.id!,
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

  static Future<void> update({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required Agent agent,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    final agentPicture = ref.watch(agentPictureProvider);
    formKey.currentState!.save();
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      final agentName = ref.watch(agentNameProvider);
      final agentFirstnames = ref.watch(agentFirstnamesProvider);
      final agentPhoneNumber = ref.watch(agentPhoneNumberProvider);
      final agentEmail = ref.watch(agentEmailProvider);
      final agentAddress = ref.watch(agentAddressProvider);
      final agentRole =
          ref.watch(formStringDropdownProvider('agent-update-role'));

      ServiceResponse lastAgentStatus;

      if (agentPicture == null) {
        final newAgent = Agent(
          name: agentName,
          firstnames: agentFirstnames,
          phoneNumber: agentPhoneNumber,
          email: agentEmail,
          address: agentAddress,
          role: agentRole,
          profile: agent.profile,
          createdAt: agent.createdAt,
          updatedAt: DateTime.now(),
        );

        lastAgentStatus = await AgentsController.update(
          id: agent.id!,
          agent: newAgent,
        );

        // debugPrint('new agent: $agentStatus');
      } else {
        String? agentRemotePath;
        // if the Agent haven't a picture before
        if (agent.profile == null) {
          agentRemotePath = await AgentsController.uploadPicture(
            agentPicturePath: agentPicture,
          );
        } else {
          agentRemotePath = await AgentsController.updateUploadedPicture(
            agentPictureLink: agent.profile!,
            newAgentPicturePath: agentPicture,
          );
        }

        final newAgent = Agent(
          name: agentName,
          firstnames: agentFirstnames,
          phoneNumber: agentPhoneNumber,
          email: agentEmail,
          address: agentAddress,
          role: agentRole,
          profile: '${CBConstants.supabaseStorageLink}/$agentRemotePath',
          createdAt: agent.createdAt,
          updatedAt: DateTime.now(),
        );

        lastAgentStatus = await AgentsController.update(
          id: agent.id!,
          agent: newAgent,
        );

        //  debugPrint('new agent: $agentStatus');
      }
      if (lastAgentStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastAgentStatus,
          response: 'Opération réussie',
        );
        showValidatedButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastAgentStatus,
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
    required Agent agent,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    showConfirmationButton.value = false;

    ServiceResponse agentStatus;

    agentStatus = await AgentsController.delete(agent: agent);

    if (agentStatus == ServiceResponse.success) {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: agentStatus,
        response: 'Opération réussie',
      );
      Navigator.of(context).pop();
    } else {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: agentStatus,
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
