// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/forms/validators/stock/stock.validator.dart';
import 'package:communitybank/controllers/stocks/stocks.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/stock/stock.model.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/utils/constants/constants.util.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/product/product_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StockCRUDFunctions {
  static Future<void> createStockInput({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      final product = ref.watch(
        formProductDropdownProvider('stock-adding-input-product'),
      );
      final inputedQuantity = ref.watch(inputedQuantityProvider);

      ServiceResponse stockInputStatus;

      final productStocks = await StocksController.getAll(
        selectedProductId: product.id,
      ).first;

      final prefs = await SharedPreferences.getInstance();
      final agentId = prefs.getInt(CBConstants.agentIdPrefKey);

      Stock stock;
      if (productStocks.isNotEmpty) {
        stock = Stock(
          productId: product.id!,
          initialQuantity: productStocks.last.stockQuantity,
          inputedQuantity: inputedQuantity,
          stockQuantity: productStocks.last.stockQuantity + inputedQuantity,
          agentId: agentId ?? 0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
      } else {
        stock = Stock(
          productId: product.id!,
          initialQuantity: 0,
          inputedQuantity: inputedQuantity,
          stockQuantity: inputedQuantity,
          agentId: agentId ?? 0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
      }

      stockInputStatus = await StocksController.create(
        stock: stock,
      );

      if (stockInputStatus == ServiceResponse.success) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: stockInputStatus,
          response: 'Opération réussie',
        );
        showValidatedButton.value = true;
        Navigator.of(context).pop();
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: stockInputStatus,
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

  static Future<void> createStockOutput({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      showValidatedButton.value = false;
      final product = ref.watch(
        formProductDropdownProvider('stock-adding-output-product'),
      );
      final outputedQuantity = ref.watch(inputedQuantityProvider);

      final productStocks = await StocksController.getAll(
        selectedProductId: product.id,
      ).first;

      final prefs = await SharedPreferences.getInstance();
      final agentId = prefs.getInt(CBConstants.agentIdPrefKey);

      if (productStocks.isNotEmpty) {
        if (productStocks.last.stockQuantity - outputedQuantity >= 0) {
          final stock = Stock(
            productId: product.id!,
            initialQuantity: productStocks.last.stockQuantity,
            outputedQuantity: outputedQuantity,
            stockQuantity: productStocks.last.stockQuantity - outputedQuantity,
            agentId: agentId ?? 0,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          final stockOutputStatus = await StocksController.create(
            stock: stock,
          );

          if (stockOutputStatus == ServiceResponse.success) {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: stockOutputStatus,
              response: 'Opération réussie',
            );
            showValidatedButton.value = true;
            Navigator.of(context).pop();
          } else {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: stockOutputStatus,
              response: 'Opération échouée',
            );
            showValidatedButton.value = true;
          }
        } else {
          ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
            serviceResponse: ServiceResponse.failed,
            response:
                'Opération échouée \n Le stock de ce produit est insuffisant',
          );
          showValidatedButton.value = true;
        }
      } else {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: ServiceResponse.failed,
          response:
              'Opération échouée \n Le produit n\'est pas disponible en stock',
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
