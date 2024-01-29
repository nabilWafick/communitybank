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
      final typeSelectedProducts = ref.watch(typeSelectedProductsProvider);
      if (typeSelectedProducts.isEmpty) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: ServiceResponse.failed,
          response: 'Le type doit contenir au moins un produit',
        );
        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const ResponseDialog(),
        );
      } else {
        showValidatedButton.value = false;
        // get the list of inputs created referenced by integers (DateTime.nom().millisecondsSinceEpoch)
        final typeAddedInputs = ref.watch(typeAddedInputsProvider);
        final typeName = ref.watch(typeNameProvider);
        final typeStack = ref.watch(typeStakeProvider);

        // store the selected products
        List<Product> typeProducts = [];

        typeSelectedProducts.forEach((key, product) {
          typeProducts.add(product);
        });
        // debugPrint(typeProducts.toString());
        // verify if a product is repeated or is selected more than one time
        // in typeSelectedProducts
        bool isProductRepeated = false; // used to detect repetion
        // used to count the product occurrences number
        int productNumber = 0;

        for (Product productF in typeProducts) {
          isProductRepeated = false;
          productNumber = 0;
          for (Product productL in typeProducts) {
            if (productF == productL) {
              ++productNumber;
            }
          }
          // debugPrint('repeated product: ${productF.toString()}');
          // debugPrint('productNumber: $productNumber');
          if (productNumber > 1) {
            isProductRepeated = true;
            break;
          }
        }

        if (isProductRepeated == true) {
          // show validated button to permit a correction from the user
          showValidatedButton.value = true;
          ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
            serviceResponse: ServiceResponse.failed,
            response: 'Répétition de produit dans le type',
          );
          FunctionsController.showAlertDialog(
            context: context,
            alertDialog: const ResponseDialog(),
          );
          isProductRepeated = false;
          productNumber = 0;
        } else {
          // store the number of each selected product
          List<int> typeProductsNumber = [];

          for (MapEntry typeAddedInputsEntry in typeAddedInputs.entries) {
            // verify if the input is visible
            if (typeAddedInputsEntry.value) {
              typeProductsNumber.add(
                ref.watch(
                  typeProductNumberProvider(typeAddedInputsEntry.key),
                ),
              );
            }
          }

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
            productsIds: typeProducts
                .map(
                  (product) => product.id,
                )
                .toList(),
            productsNumber: typeProducts
                .map(
                  (product) => product.number,
                )
                .toList(),
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          // debugPrint('type: ${type.toString()}');

          ServiceResponse typeStatus;

          typeStatus = await TypesController.create(type: type);

          if (typeStatus == ServiceResponse.success) {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: typeStatus,
              response: 'Opération réussie',
            );
            showValidatedButton.value = true;
            Navigator.of(context).pop();
          } else {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
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
      final typeSelectedProducts = ref.watch(typeSelectedProductsProvider);
      if (typeSelectedProducts.isEmpty) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: ServiceResponse.failed,
          response: 'Le type doit contenir au moins un produit',
        );
        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const ResponseDialog(),
        );
      } else {
        showValidatedButton.value = false;
        // get the list of inputs created referenced by integers (DateTime.nom().millisecondsSinceEpoch)
        final typeAddedInputs = ref.watch(typeAddedInputsProvider);
        final typeName = ref.watch(typeNameProvider);
        final typeStack = ref.watch(typeStakeProvider);

        // store the selected products
        List<Product> typeProducts = [];

        typeSelectedProducts.forEach((key, product) {
          typeProducts.add(product);
        });
        //   debugPrint(typeProducts.toString());
        // verify if a product is repeated or is selected more than one time
        // in typeSelectedProducts
        bool isProductRepeated = false; // used to detect repetion
        // used to count the product occurrences number
        int productNumber = 0;

        for (Product productF in typeProducts) {
          isProductRepeated = false;
          productNumber = 0;
          for (Product productL in typeProducts) {
            if (productF == productL) {
              ++productNumber;
            }
          }
          //  debugPrint('repeated product: ${productF.toString()}');
          //  debugPrint('productNumber: $productNumber');
          if (productNumber > 1) {
            isProductRepeated = true;
            break;
          }
        }

        if (isProductRepeated == true) {
          // show validated button to permit a correction from the user
          showValidatedButton.value = true;
          ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
            serviceResponse: ServiceResponse.failed,
            response: 'Répétition de produit dans le type',
          );
          FunctionsController.showAlertDialog(
            context: context,
            alertDialog: const ResponseDialog(),
          );
          isProductRepeated = false;
          productNumber = 0;
        } else {
          // store the number of each selected product
          List<int> typeProductsNumber = [];

          for (MapEntry typeAddedInputsEntry in typeAddedInputs.entries) {
            if (typeAddedInputsEntry.value) {
              typeProductsNumber.add(
                ref.watch(
                  typeProductNumberProvider(typeAddedInputsEntry.key),
                ),
              );
            }
          }

          // debugPrint('typeName: $typeName');
          // debugPrint('typeStack: $typeStack');

          for (int i = 0; i < typeProductsNumber.length; ++i) {
            typeProducts[i].number = typeProductsNumber[i];

            // debugPrint(
            //     'typeProductNumber $i-${typeProducts[i].name}: ${typeProducts[i].number}');
          }

          final newType = Type(
            name: typeName,
            stake: typeStack,
            productsIds: typeProducts
                .map(
                  (product) => product.id,
                )
                .toList(),
            productsNumber: typeProducts
                .map(
                  (product) => product.number,
                )
                .toList(),
            createdAt: type.createdAt,
            updatedAt: DateTime.now(),
          );

          // debugPrint('type: ${type.toString()}');

          ServiceResponse typeStatus;

          typeStatus =
              await TypesController.update(id: type.id!, type: newType);

          if (typeStatus == ServiceResponse.success) {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: typeStatus,
              response: 'Opération réussie',
            );
            showValidatedButton.value = true;
            Navigator.of(context).pop();
          } else {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
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
