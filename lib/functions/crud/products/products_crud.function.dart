// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/forms/validators/product/product.validator.dart';
import 'package:communitybank/controllers/products/products.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/utils/constants/constants.util.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCRUDFunctions {
  static Future<void> create({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    final productPicture = ref.watch(productPictureProvider);
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      final productName = ref.watch(productNameProvider);
      final productPrice = ref.watch(productPurchasePriceProvider);

      ServiceResponse productStatus;

      if (productPicture == null) {
        final product = Product(
          name: productName,
          purchasePrice: productPrice,
          picture: productPicture,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        productStatus = await ProductsController.create(product: product);

        // debugPrint('new product: $productStatus');
      } else {
        final productRemotePath = await ProductsController.uploadPicture(
          productPicturePath: productPicture,
        );

        if (productRemotePath != null) {
          final product = Product(
            name: productName,
            purchasePrice: productPrice,
            picture: '${CBConstants.supabaseStorageLink}/$productRemotePath',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          productStatus = await ProductsController.create(product: product);

          //  debugPrint('new product: $productStatus');
        } else {
          productStatus = ServiceResponse.failed;
        }
      }
      if (productStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: productStatus,
          response: 'Opération réussie',
        );
        showValidatedButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: productStatus,
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
    required Product product,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    final productPicture = ref.watch(productPictureProvider);
    formKey.currentState!.save();
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      final productName = ref.watch(productNameProvider);
      final productPrice = ref.watch(productPurchasePriceProvider);

      ServiceResponse lastProductStatus;

      if (productPicture == null) {
        final newProduct = Product(
          name: productName,
          purchasePrice: productPrice,
          picture: product.picture,
          createdAt: product.createdAt,
          updatedAt: DateTime.now(),
        );

        lastProductStatus = await ProductsController.update(
          id: product.id!,
          product: newProduct,
        );

        // debugPrint('new product: $productStatus');
      } else {
        String? productRemotePath;
        // if the product haven't a picture before
        if (product.picture == null) {
          productRemotePath = await ProductsController.uploadPicture(
              productPicturePath: productPicture);
        } else {
          productRemotePath = await ProductsController.updateUploadedPicture(
            productPictureLink: product.picture!,
            newProductPicturePath: productPicture,
          );
        }

        if (productRemotePath != null) {
          final newProduct = Product(
            name: productName,
            purchasePrice: productPrice,
            picture: '${CBConstants.supabaseStorageLink}/$productRemotePath',
            createdAt: product.createdAt,
            updatedAt: DateTime.now(),
          );

          lastProductStatus = await ProductsController.update(
            id: product.id!,
            product: newProduct,
          );

          //  debugPrint('new product: $productStatus');
        } else {
          lastProductStatus = ServiceResponse.failed;
        }
      }
      if (lastProductStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastProductStatus,
          response: 'Opération réussie',
        );
        showValidatedButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: lastProductStatus,
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
    required int productId,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    showConfirmationButton.value = false;

    ServiceResponse productStatus;

    productStatus = await ProductsController.delete(id: productId);

    if (productStatus == ServiceResponse.success) {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: productStatus,
        response: 'Opération réussie',
      );
      Navigator.of(context).pop();
    } else {
      ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
        serviceResponse: productStatus,
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
