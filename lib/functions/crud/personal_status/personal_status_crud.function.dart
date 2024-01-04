// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/forms/validators/personal_status/personal_status.validator.dart';
import 'package:communitybank/controllers/personal_status/personal_status.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/personal_status/personal_status.model.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonalStatusCRUDFunctions {
  static Future<void> create({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      final personalStatusName = ref.watch(personalStatusNameProvider);

      ServiceResponse personalStatusStatus;

      final personalStatus = PersonalStatus(
        name: personalStatusName,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      personalStatusStatus =
          await PersonalStatusController.create(personalStatus: personalStatus);

      // debugPrint('new PersonalStatus: $personalStatusStatus');

      if (personalStatusStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: personalStatusStatus,
          response: 'Opération réussie',
        );
        showValidatedButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: personalStatusStatus,
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
    required PersonalStatus personalStatus,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    formKey.currentState!.save();
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      final personalStatusName = ref.watch(personalStatusNameProvider);
      ServiceResponse lastPersonalStatusStatus;

      final newPersonalStatus = PersonalStatus(
        name: personalStatusName,
        createdAt: personalStatus.createdAt,
        updatedAt: DateTime.now(),
      );

      lastPersonalStatusStatus = await PersonalStatusController.update(
        id: personalStatus.id!,
        personalStatus: newPersonalStatus,
      );

      // debugPrint('new PersonalStatus: $personalStatusStatus');

      if (lastPersonalStatusStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastPersonalStatusStatus,
          response: 'Opération réussie',
        );
        showValidatedButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastPersonalStatusStatus,
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
    required PersonalStatus personalStatus,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    showConfirmationButton.value = false;

    ServiceResponse personalStatusStatus;

    personalStatusStatus =
        await PersonalStatusController.delete(personalStatus: personalStatus);

    if (personalStatusStatus == ServiceResponse.success) {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: personalStatusStatus,
        response: 'Opération réussie',
      );
      Navigator.of(context).pop();
    } else {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: personalStatusStatus,
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
