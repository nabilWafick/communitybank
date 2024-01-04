// ignore_for_file: use_build_context_synchronously
import 'package:communitybank/controllers/economical_activities/economical_activities.controller.dart';
import 'package:communitybank/controllers/forms/validators/economical_activity/economical_activity.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/economical_activity/economical_activity.model.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EconomicalActivityCRUDFunctions {
  static Future<void> create({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      final economicalActivityName = ref.watch(economicalActivityNameProvider);

      ServiceResponse economicalActivityStatus;

      final economicalActivity = EconomicalActivity(
        name: economicalActivityName,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      economicalActivityStatus = await EconomicalActivitiesController.create(
          economicalActivity: economicalActivity);

      // debugPrint('new EconomicalActivity: $economicalActivityStatus');

      if (economicalActivityStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: economicalActivityStatus,
          response: 'Opération réussie',
        );
        showValidatedButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: economicalActivityStatus,
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
    required EconomicalActivity economicalActivity,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    formKey.currentState!.save();
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      final economicalActivityName = ref.watch(economicalActivityNameProvider);
      ServiceResponse lastEconomicalActivityStatus;

      final newEconomicalActivity = EconomicalActivity(
        name: economicalActivityName,
        createdAt: economicalActivity.createdAt,
        updatedAt: DateTime.now(),
      );

      lastEconomicalActivityStatus =
          await EconomicalActivitiesController.update(
        id: economicalActivity.id!,
        economicalActivity: newEconomicalActivity,
      );

      // debugPrint('new EconomicalActivity: $economicalActivityStatus');

      if (lastEconomicalActivityStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastEconomicalActivityStatus,
          response: 'Opération réussie',
        );
        showValidatedButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastEconomicalActivityStatus,
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
    required EconomicalActivity economicalActivity,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    showConfirmationButton.value = false;

    ServiceResponse economicalActivityStatus;

    economicalActivityStatus = await EconomicalActivitiesController.delete(
        economicalActivity: economicalActivity);

    if (economicalActivityStatus == ServiceResponse.success) {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: economicalActivityStatus,
        response: 'Opération réussie',
      );
      Navigator.of(context).pop();
    } else {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: economicalActivityStatus,
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
