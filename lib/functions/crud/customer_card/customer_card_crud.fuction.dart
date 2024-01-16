// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/customer_card/customer_card.controller.dart';
import 'package:communitybank/controllers/forms/validators/customer_card/customer_card.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/customer_account/customer_account_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/type/type_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerCardCRUDFunctions {
  static Future<void> create({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      final customerCardLabel = ref.watch(customerCardLabelProvider);
      final customerCardType =
          ref.watch(formTypeDropdownProvider('customer-card-adding-type'));
      final customerCardOwnerAccount = ref.watch(
          formCustomerAccountDropdownProvider(
              'customer-card-adding-customer-account'));

      ServiceResponse customerCardStatus;

      final customerCard = CustomerCard(
        label: customerCardLabel,
        typeId: customerCardType.id!,
        customerAccountId: customerCardOwnerAccount.id,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      customerCardStatus =
          await CustomerCardsController.create(customerCard: customerCard);

      // debugPrint('new CustomerCard: $customerCardStatus');

      if (customerCardStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: customerCardStatus,
          response: 'Opération réussie',
        );
        showValidatedButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: customerCardStatus,
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
    required CustomerCard customerCard,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    formKey.currentState!.save();
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      final customerCardLabel = ref.watch(customerCardLabelProvider);
      final customerCardType =
          ref.watch(formTypeDropdownProvider('customer-card-adding-type'));
      final customerCardOwnerAccount = ref.watch(
          formCustomerAccountDropdownProvider(
              'customer-card-adding-customer-account'));

      ServiceResponse lastCustomerCardStatus;

      final newCustomerCard = CustomerCard(
        label: customerCardLabel,
        typeId: customerCardType.id!,
        customerAccountId: customerCardOwnerAccount.id,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      lastCustomerCardStatus = await CustomerCardsController.update(
        id: customerCard.id!,
        customerCard: newCustomerCard,
      );

      // debugPrint('new CustomerCard: $customerCardStatus');

      if (lastCustomerCardStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastCustomerCardStatus,
          response: 'Opération réussie',
        );
        showValidatedButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastCustomerCardStatus,
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
    required CustomerCard customerCard,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    showConfirmationButton.value = false;

    ServiceResponse customerCardStatus;

    customerCardStatus =
        await CustomerCardsController.delete(customerCard: customerCard);

    if (customerCardStatus == ServiceResponse.success) {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: customerCardStatus,
        response: 'Opération réussie',
      );
      Navigator.of(context).pop();
    } else {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: customerCardStatus,
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
