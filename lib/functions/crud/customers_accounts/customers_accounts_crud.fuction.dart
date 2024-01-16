// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/customer_account/customer_account.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/collector/collector_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/customer_dropdown/customer_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerAccountCRUDFunctions {
  static Future<void> create({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      final customerAccountOwner = ref.watch(
          formCustomerDropdownProvider('customer-account-adding-customer'));
      final customerAccountCollector = ref.watch(
          formCollectorDropdownProvider('customer-account-adding-collector'));

      ServiceResponse customerAccountStatus;

      final customerAccount = CustomerAccount(
        customerId: customerAccountOwner.id!,
        collectorId: customerAccountCollector.id!,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      customerAccountStatus = await CustomerAccountsController.create(
          customerAccount: customerAccount);

      // debugPrint('new CustomerAccount: $customerAccountStatus');

      if (customerAccountStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: customerAccountStatus,
          response: 'Opération réussie',
        );
        showValidatedButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: customerAccountStatus,
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
    required CustomerAccount customerAccount,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    formKey.currentState!.save();
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      final customerAccountOwner = ref.watch(
          formCustomerDropdownProvider('customer-account-update-customer'));
      final customerAccountCollector = ref.watch(
          formCollectorDropdownProvider('customer-account-update-collector'));

      ServiceResponse lastCustomerAccountStatus;

      final newCustomerAccount = CustomerAccount(
        customerId: customerAccountOwner.id!,
        collectorId: customerAccountCollector.id!,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      lastCustomerAccountStatus = await CustomerAccountsController.update(
        id: customerAccount.id!,
        customerAccount: newCustomerAccount,
      );

      // debugPrint('new CustomerAccount: $customerAccountStatus');

      if (lastCustomerAccountStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastCustomerAccountStatus,
          response: 'Opération réussie',
        );
        showValidatedButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
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

  static Future<void> delete({
    required BuildContext context,
    required WidgetRef ref,
    required CustomerAccount customerAccount,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    showConfirmationButton.value = false;

    ServiceResponse customerAccountStatus;

    customerAccountStatus = await CustomerAccountsController.delete(
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
