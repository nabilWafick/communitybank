// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/customers_categories/customers_categories.controller.dart';
import 'package:communitybank/controllers/forms/validators/customer_category/customer_category.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/customers_category/customers_category.model.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerCategoryCRUDFunctions {
  static Future<void> create({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      final customerCategoryName = ref.watch(customerCategoryNameProvider);

      ServiceResponse customerCategoryStatus;

      final customerCategory = CustomerCategory(
        name: customerCategoryName,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      customerCategoryStatus = await CustomersCategoriesController.create(
          customerCategory: customerCategory);

      // debugPrint('new customerCategory: $customerCategoryStatus');

      if (customerCategoryStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: customerCategoryStatus,
          response: 'Opération réussie',
        );
        showValidatedButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: customerCategoryStatus,
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
    required CustomerCategory customerCategory,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    formKey.currentState!.save();
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      final customerCategoryName = ref.watch(customerCategoryNameProvider);
      ServiceResponse lastCustomerCategoryStatus;

      final newCustomerCategory = CustomerCategory(
        name: customerCategoryName,
        createdAt: customerCategory.createdAt,
        updatedAt: DateTime.now(),
      );

      lastCustomerCategoryStatus = await CustomersCategoriesController.update(
        id: customerCategory.id!,
        customerCategory: newCustomerCategory,
      );

      // debugPrint('new customerCategory: $customerCategoryStatus');

      if (lastCustomerCategoryStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastCustomerCategoryStatus,
          response: 'Opération réussie',
        );
        showValidatedButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastCustomerCategoryStatus,
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
    required CustomerCategory customerCategory,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    showConfirmationButton.value = false;

    ServiceResponse customerCategoryStatus;

    customerCategoryStatus = await CustomersCategoriesController.delete(
        customerCategory: customerCategory);

    if (customerCategoryStatus == ServiceResponse.success) {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: customerCategoryStatus,
        response: 'Opération réussie',
      );
      Navigator.of(context).pop();
    } else {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: customerCategoryStatus,
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
