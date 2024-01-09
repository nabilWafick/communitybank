// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/forms/validators/type/type.validator.dart';
import 'package:communitybank/controllers/types/types.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/models/data/type/type.model.dart';

import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TypeCRUDFunctions {
  static Future<void> create({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      // get the list of inputs created referenced by integers (DateTime.nom().millisecondsSinceEpoch)
      final typeAddedInputs = ref.watch(typeAddedInputsProvider);
      final typeName = ref.watch(typeNameProvider);
      final typeStack = ref.watch(typeStakeProvider);
      final typeSelectedProducts = ref.watch(typeSelectedProductsProvider);
      // store the selected products
      List<Product> typeProducts = [];
      typeSelectedProducts.forEach((key, product) {
        typeProducts.add(product);
      });
      // get the number of each selected product
      final typeProductsNumber = typeAddedInputs
          .map((input) => ref.watch(typeProductNumberProvider(input)))
          .toList();

      // debugPrint('typeName: $typeName');
      // debugPrint('typeStack: $typeStack');

      for (int i = 0; i < typeProductsNumber.length; ++i) {
        typeProducts[i].number = typeProductsNumber[i];

        // debugPrint(
        //     'typeProductNumber $i-${typeProducts[i].name}: ${typeProducts[i].number}');
      }

      final type = Type(
        name: typeName,
        stake: typeStack,
        products: typeProducts,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      ServiceResponse typeStatus;

      typeStatus = await TypesController.create(type: type);

      if (typeStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: typeStatus,
          response: 'Opération réussie',
        );
        showValidatedButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: typeStatus,
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
    required Type type,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    formKey.currentState!.save();
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;

      // get the list of inputs created referenced by integers (DateTime.nom().millisecondsSinceEpoch)
      final typeAddedInputs = ref.watch(typeAddedInputsProvider);
      final typeName = ref.watch(typeNameProvider);
      final typeStack = ref.watch(typeStakeProvider);
      final typeSelectedProducts = ref.watch(typeSelectedProductsProvider);
      // store the selected products
      List<Product> typeProducts = [];
      typeSelectedProducts.forEach((key, product) {
        typeProducts.add(product);
      });
      // get the number of each selected product
      final typeProductsNumber = typeAddedInputs
          .map((input) => ref.watch(typeProductNumberProvider(input)))
          .toList();

      //  debugPrint('typeName: $typeName');
      //  debugPrint('typeStack: $typeStack');

      for (int i = 0; i < typeProductsNumber.length; ++i) {
        typeProducts[i].number = typeProductsNumber[i];

        // debugPrint(
        //     'typeProductNumber $i-${typeProducts[i].name}: ${typeProducts[i].number}');
      }

      final type = Type(
        name: typeName,
        stake: typeStack,
        products: typeProducts,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      ServiceResponse lastTypeStatus;

      lastTypeStatus = await TypesController.create(type: type);

      // debugPrint('new Type: $typeStatus');

      if (lastTypeStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastTypeStatus,
          response: 'Opération réussie',
        );
        showValidatedButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastTypeStatus,
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
    required Type type,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    showConfirmationButton.value = false;

    ServiceResponse typeStatus;

    typeStatus = await TypesController.delete(type: type);

    if (typeStatus == ServiceResponse.success) {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: typeStatus,
        response: 'Opération réussie',
      );
      Navigator.of(context).pop();
    } else {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: typeStatus,
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
