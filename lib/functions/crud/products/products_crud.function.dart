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

class ProductCRUDFunction {
  static Future<void> create({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    final productPicture = ref.watch(productPictureProvider);
    showValidatedButton.value = false;
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      final productName = ref.watch(productNameProvider);
      final productPrice = ref.watch(productPurchasePriceProvider);

      ServiceResponse newProductStatus;

      if (productPicture == null) {
        final product = Product(
          name: productName,
          purchasePrice: productPrice,
          picture: productPicture,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        newProductStatus = await ProductsController.create(product: product);

        // debugPrint('new product: $newProductStatus');
      } else {
        final productRemotePath = await ProductsController.uploadPicture(
            productPicturePath: productPicture);

        if (productRemotePath != null) {
          final product = Product(
            name: productName,
            purchasePrice: productPrice,
            picture: '${CBConstants.supabaseStorageLink}/$productRemotePath',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          newProductStatus = await ProductsController.create(product: product);

          //  debugPrint('new product: $newProductStatus');
        } else {
          newProductStatus = ServiceResponse.failed;
        }
      }
      if (newProductStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: newProductStatus,
          response: 'Opération réussie',
        );
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: newProductStatus,
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
