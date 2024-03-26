// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:communitybank/controllers/customer_card/customer_card.controller.dart';
import 'package:communitybank/controllers/forms/validators/customer_card/customer_card.validator.dart';
import 'package:communitybank/controllers/stocks/stocks.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/models/data/stock/stock.model.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/utils/constants/constants.util.dart';
import 'package:communitybank/views/widgets/cash/cash_operations/search_options/search_options.widget.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/type/type_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      //  final customerCardLabel = ref.watch(customerCardLabelProvider);
      final customerCardTypeNumber = ref.watch(customerCardTypeNumberProvider);
      final customerCardLabel = generateRandomStringFromDateTimeNowMillis();
      final customerCardType =
          ref.watch(formTypeDropdownProvider('customer-card-adding-type'));

      ServiceResponse customerCardStatus;

      final customerCard = CustomerCard(
        label: customerCardLabel,
        typeId: customerCardType.id!,
        typeNumber: customerCardTypeNumber,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      customerCardStatus =
          await CustomersCardsController.create(customerCard: customerCard);

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
      final customerCardTypeNumber = ref.watch(customerCardTypeNumberProvider);
      final customerCardLabel = ref.watch(customerCardLabelProvider);
      final customerCardType =
          ref.watch(formTypeDropdownProvider('customer-card-update-type'));

      ServiceResponse lastCustomerCardStatus;

      final newCustomerCard = CustomerCard(
        label: customerCardLabel,
        typeId: customerCardType.id!,
        typeNumber: customerCardTypeNumber,
        createdAt: customerCard.createdAt,
        updatedAt: DateTime.now(),
      );

      lastCustomerCardStatus = await CustomersCardsController.update(
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

  static Future<void> updateRepaymentDate({
    required BuildContext context,
    required WidgetRef ref,
    required CustomerCard customerCard,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    showConfirmationButton.value = false;
    //  final customerCardSatisfactionDate =
    //      ref.watch(customerCardSatisfactionDateProvider);
    final cashOperationsSelectedCustomerAccount =
        ref.watch(cashOperationsSelectedCustomerAccountProvider);

    final customerCardRepaymentDate =
        ref.watch(customerCardRepaymentDateProvider);

    ServiceResponse lastCustomerCardStatus;

    final newCustomerCard = CustomerCard(
      label: customerCard.label,
      typeId: customerCard.typeId,
      typeNumber: customerCard.typeNumber,
      repaidAt: customerCardRepaymentDate!,
      customerAccountId: cashOperationsSelectedCustomerAccount!.id!,
      createdAt: customerCard.createdAt,
      updatedAt: DateTime.now(),
    );

    lastCustomerCardStatus = await CustomersCardsController.update(
      id: customerCard.id!,
      customerCard: newCustomerCard,
    );

    if (lastCustomerCardStatus == ServiceResponse.success) {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: lastCustomerCardStatus,
        response: 'Opération réussie',
      );
      showConfirmationButton.value = true;
      Navigator.of(context).pop();
    } else {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: lastCustomerCardStatus,
        response: 'Opération échouée',
      );
      showConfirmationButton.value = true;
    }
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const ResponseDialog(),
    );
  }

  static Future<void> updateSatisfactionDate({
    required BuildContext context,
    required WidgetRef ref,
    required CustomerCard customerCard,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    showConfirmationButton.value = false;
    final cashOperationsSelectedCustomerAccount =
        ref.watch(cashOperationsSelectedCustomerAccountProvider);
    final accountOwnerSelectedCard = ref
        .watch(cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider);
    final customerCardType = ref.watch(
        cashOperationsSelectedCustomerAccountOwnerSelectedCardTypeProvider);
    final customerCardSatisfactionDate =
        ref.watch(customerCardSatisfactionDateProvider);

    // foreach product of the type, get his last stock and substract
    // the number of the product in the type from the last stock

    List<ServiceResponse> allSubtractionsDoneSuccessfully = [];

    for (int i = 0; i < customerCardType!.productsIds.length; i++) {
      // get the product stock
      final stocks = await StocksController.getAll(
        selectedProductId: customerCard.id!,
      ).first;

      // get the last product stock (Mouvement)
      final lastStock = stocks.last;
      // make the substraction

      final prefs = await SharedPreferences.getInstance();
      final agentId = prefs.getInt(CBConstants.agentIdPrefKey);

      final newStock = Stock(
        productId: customerCardType.productsIds[i],
        initialQuantity: lastStock.stockQuantity,
        outputedQuantity: (accountOwnerSelectedCard!.typeNumber *
            customerCardType.productsNumber[i] as int),
        stockQuantity: lastStock.stockQuantity -
            (accountOwnerSelectedCard.typeNumber *
                customerCardType.productsNumber[i] as int),
        type: StockOutputType.normal,
        customerCardId: accountOwnerSelectedCard.id,
        agentId: agentId ?? 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      allSubtractionsDoneSuccessfully.add(
        await StocksController.create(
          stock: newStock,
        ),
      );
    }

    final successfullyDone = allSubtractionsDoneSuccessfully
        .every((response) => response == ServiceResponse.success);

    if (successfullyDone) {
      ServiceResponse lastCustomerCardStatus;

      final newCustomerCard = CustomerCard(
        label: accountOwnerSelectedCard!.label,
        typeId: accountOwnerSelectedCard.typeId,
        typeNumber: accountOwnerSelectedCard.typeNumber,
        customerAccountId: cashOperationsSelectedCustomerAccount!.id!,
        //  repaidAt: customerCardRepaymentDate!, // it's not defined
        satisfiedAt: customerCardSatisfactionDate!,
        createdAt: accountOwnerSelectedCard.createdAt,
        updatedAt: DateTime.now(),
      );

      lastCustomerCardStatus = await CustomersCardsController.update(
        id: customerCard.id!,
        customerCard: newCustomerCard,
      );

      // debugPrint('new CustomerCard: $customerCardStatus');

      if (lastCustomerCardStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastCustomerCardStatus,
          response: 'Opération réussie',
        );
        showConfirmationButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastCustomerCardStatus,
          response: 'Opération échouée \n La carte n\'a pas pu être grisée',
        );
        showConfirmationButton.value = true;
      }
    } else {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: ServiceResponse.failed,
        response: 'Opération échouée \n Les stocks n\'ont pu être mis à jour',
      );
      showConfirmationButton.value = true;
    }

    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const ResponseDialog(),
    );
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
        await CustomersCardsController.delete(customerCard: customerCard);

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

String generateRandomStringFromDateTimeNowMillis() {
  String millisecondsString = DateTime.now().millisecondsSinceEpoch.toString();
  String result = '';
  Random random = Random();

  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  for (int i = 0; i < millisecondsString.length; i++) {
    result += millisecondsString[i];
    if ((i + 1) % 3 == 0 && i != millisecondsString.length - 1) {
      // add a random letter  after each three letters
      result += characters[random.nextInt(characters.length)];
    }
  }

  return result;
}
