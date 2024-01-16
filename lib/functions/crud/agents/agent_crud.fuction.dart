// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/agent/agent.controller.dart';
import 'package:communitybank/controllers/forms/validators/agent/agent.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/agent/agent.model.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/utils/constants/constants.util.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AgentCRUDFunctions {
  static Future<void> create({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    final agentPicture = ref.watch(agentPictureProvider);
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      final agentName = ref.watch(agentNameProvider);
      final agentFirstnames = ref.watch(agentFirstnamesProvider);
      final agentPhoneNumber = ref.watch(agentPhoneNumberProvider);
      final agentAddress = ref.watch(agentAddressProvider);
      final agentRole = ref.watch(stringDropdownProvider('agent-adding-role'));

      ServiceResponse agentStatus;

      if (agentPicture == null) {
        final agent = Agent(
          name: agentName,
          firstnames: agentFirstnames,
          phoneNumber: agentPhoneNumber,
          address: agentAddress,
          role: agentRole,
          profile: agentPicture,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        agentStatus = await AgentsController.create(agent: agent);

        // debugPrint('new agent: $agentStatus');
      } else {
        final agentRemotePath = await AgentsController.uploadPicture(
          agentPicturePath: agentPicture,
        );

        if (agentRemotePath != null) {
          final agent = Agent(
            name: agentName,
            firstnames: agentFirstnames,
            phoneNumber: agentPhoneNumber,
            address: agentAddress,
            role: agentRole,
            profile: '${CBConstants.supabaseStorageLink}/$agentRemotePath',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          agentStatus = await AgentsController.create(agent: agent);

          //  debugPrint('new agent: $agentStatus');
        } else {
          agentStatus = ServiceResponse.failed;
        }
      }
      if (agentStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: agentStatus,
          response: 'Opération réussie',
        );
        showValidatedButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: agentStatus,
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
      final agentAddress = ref.watch(agentAddressProvider);
      final agentRole = ref.watch(stringDropdownProvider('agent-adding-role'));

      ServiceResponse lastagentStatus;

      if (agentPicture == null) {
        final newAgent = Agent(
          name: agentName,
          firstnames: agentFirstnames,
          phoneNumber: agentPhoneNumber,
          address: agentAddress,
          role: agentRole,
          profile: agent.profile,
          createdAt: agent.createdAt,
          updatedAt: DateTime.now(),
        );

        lastagentStatus = await AgentsController.update(
          id: agent.id!,
          agent: newAgent,
        );

        // debugPrint('new agent: $agentStatus');
      } else {
        String? agentRemotePath;
        // if the Agent haven't a picture before
        if (agent.profile == null) {
          agentRemotePath = await AgentsController.uploadPicture(
              agentPicturePath: agentPicture);
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
          address: agentAddress,
          role: agentRole,
          profile: '${CBConstants.supabaseStorageLink}/$agentRemotePath',
          createdAt: agent.createdAt,
          updatedAt: DateTime.now(),
        );

        lastagentStatus = await AgentsController.update(
          id: agent.id!,
          agent: newAgent,
        );

        //  debugPrint('new agent: $agentStatus');
      }
      if (lastagentStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastagentStatus,
          response: 'Opération réussie',
        );
        showValidatedButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastagentStatus,
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
