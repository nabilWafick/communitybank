// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/customer_card/customer_card.controller.dart';
import 'package:communitybank/controllers/forms/validators/customer_card/customer_card.validator.dart';
import 'package:communitybank/controllers/forms/validators/stock/stock.validator.dart';
import 'package:communitybank/controllers/stocks/stocks.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/models/data/stock/stock.model.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/utils/constants/constants.util.dart';
import 'package:communitybank/views/widgets/cash/cash_operations/search_options/search_options.widget.dart';
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
      final inputedQuantity = ref.watch(stockInputedQuantityProvider);

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
      final outputedQuantity = ref.watch(stockOutputedQuantityProvider);

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
            type: StockOutputType.manual,
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

  static Future<void> createStockConstrainedOutput({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    final isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      final accountOwnerSelectedCard = ref.watch(
        cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider,
      );

      final cashOperationsSelectedCustomerAccount =
          ref.watch(cashOperationsSelectedCustomerAccountProvider);

      final stockConstrainedOuputSelectedProducts =
          ref.watch(stockConstrainedOuputSelectedProductsProvider);

      final customerCardSatisfactionDate =
          ref.watch(customerCardSatisfactionDateProvider);

      if (stockConstrainedOuputSelectedProducts.isEmpty) {
        ref.read(responseDialogProvider.notifier).state = ResponseDialogModel(
          serviceResponse: ServiceResponse.failed,
          response: 'Veuillez sélectionner au moins un produit',
        );
        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const ResponseDialog(),
        );
      } else {
        showValidatedButton.value = false;
        // get the list of inputs created referenced by integers (DateTime.nom().millisecondsSinceEpoch)
        final stockConstrainedOuputAddedInputs =
            ref.watch(stockConstrainedOuputAddedInputsProvider);

        // store the selected products
        List<Product> stockConstrainedOutputProducts = [];

        stockConstrainedOuputSelectedProducts.forEach((key, product) {
          stockConstrainedOutputProducts.add(product);
        });
        // debugPrint(stockConstrainedOutputProducts.toString());
        // verify if a product is repeated or is selected more than one time
        // in typeSelectedProducts
        bool isProductRepeated = false; // used to detect repetion
        // used to count the product occurrences number
        int productNumber = 0;

        for (Product productF in stockConstrainedOutputProducts) {
          isProductRepeated = false;
          productNumber = 0;
          for (Product productL in stockConstrainedOutputProducts) {
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
          List<int> stockConstrainedOutputProductsNumber = [];

          for (MapEntry stockConstrainedOuputAddedInputsEntry
              in stockConstrainedOuputAddedInputs.entries) {
            // verify if the input is visible
            if (stockConstrainedOuputAddedInputsEntry.value) {
              stockConstrainedOutputProductsNumber.add(
                ref.watch(
                  stockConstrainedOuputProductNumberProvider(
                      stockConstrainedOuputAddedInputsEntry.key),
                ),
              );
            }
          }

          for (int i = 0;
              i < stockConstrainedOutputProductsNumber.length;
              ++i) {
            stockConstrainedOutputProducts[i].number =
                stockConstrainedOutputProductsNumber[i];
          }

          // check if the products are availables in stock

          final areAllProductsAvailable =
              await checkConstrainedOutputProductsStocks(
            ref: ref,
            products: stockConstrainedOutputProducts,
          );

          if (areAllProductsAvailable) {
            // make substraction

            // foreach product of the type, get his last stock and substract
            // the number of the product in the type from the last stock

            List<ServiceResponse> areAllSubtractionsDoneSuccessfully = [];

            for (int i = 0; i < stockConstrainedOutputProducts.length; i++) {
              // get the product stocks
              final stocks = await StocksController.getAll(
                selectedProductId: stockConstrainedOutputProducts[i].id,
              ).first;

              // get the last product stock (Mouvement)
              final lastStock = stocks.last;

              // make the substraction

              final prefs = await SharedPreferences.getInstance();
              final agentId = prefs.getInt(CBConstants.agentIdPrefKey);

              final newStock = Stock(
                productId: stockConstrainedOutputProducts[i].id!,
                initialQuantity: lastStock.stockQuantity,
                outputedQuantity: (accountOwnerSelectedCard!.typeNumber *
                    stockConstrainedOutputProducts[i].number!),
                stockQuantity: lastStock.stockQuantity -
                    (accountOwnerSelectedCard.typeNumber *
                        stockConstrainedOutputProducts[i].number!),
                type: StockOutputType.constraint,
                customerCardId: accountOwnerSelectedCard.id,
                agentId: agentId ?? 0,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              );

              areAllSubtractionsDoneSuccessfully.add(
                await StocksController.create(
                  stock: newStock,
                ),
              );
            }

            final successfullyDone = areAllSubtractionsDoneSuccessfully.every(
              (response) => response == ServiceResponse.success,
            );

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
                id: accountOwnerSelectedCard.id!,
                customerCard: newCustomerCard,
              );

              // debugPrint('new CustomerCard: $customerCardStatus');

              if (lastCustomerCardStatus == ServiceResponse.success) {
                ref.read(responseDialogProvider.notifier).state =
                    ResponseDialogModel(
                  serviceResponse: lastCustomerCardStatus,
                  response: 'Opération réussie',
                );
                showValidatedButton.value = true;
                Navigator.of(context).pop();
              } else {
                ref.read(responseDialogProvider.notifier).state =
                    ResponseDialogModel(
                  serviceResponse: lastCustomerCardStatus,
                  response:
                      'Opération échouée \n La carte n\'a pas pu être grisée',
                );
                showValidatedButton.value = true;
              }
            } else {
              ref.read(responseDialogProvider.notifier).state =
                  ResponseDialogModel(
                serviceResponse: ServiceResponse.failed,
                response:
                    'Opération échouée \n Les stocks n\'ont pas pu être tous mis à jour',
              );
              showValidatedButton.value = true;
            }

            FunctionsController.showAlertDialog(
              context: context,
              alertDialog: const ResponseDialog(),
            );
          } else {
            ref.read(responseDialogProvider.notifier).state =
                ResponseDialogModel(
              serviceResponse: ServiceResponse.failed,
              response:
                  'Tous les produits sélectionnés ne sont pas disponibles ou sont insuffisants en stock',
            );
            showValidatedButton.value = true;

            FunctionsController.showAlertDialog(
              context: context,
              alertDialog: const ResponseDialog(),
            );
          }
        }
      }
    }
  }

  static Future<bool> checkConstrainedOutputProductsStocks({
    required WidgetRef ref,
    required List<Product> products,
  }) async {
    final accountOwnerSelectedCard = ref.watch(
      cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider,
    );

    // foreach product of the type, check if the product stock exist
    // and is available (is sufficient for substraction)

    List<bool> areAllProductsStocksAvailable = [];

    for (int i = 0; i < products.length; i++) {
      // get the product stocks
      final stocks = await StocksController.getAll(
        selectedProductId: products[i].id,
      ).first;

      if (stocks.isNotEmpty) {
        // get the last product stock (Mouvement)
        final lastStock = stocks.last;

        if (lastStock.stockQuantity -
                (accountOwnerSelectedCard!.typeNumber * products[i].number!) >=
            0) {
          areAllProductsStocksAvailable.add(true);
        } else {
          areAllProductsStocksAvailable.add(false);
        }
      } else {
        areAllProductsStocksAvailable.add(false);
      }
    }

    final allAvailable = areAllProductsStocksAvailable.every(
      (response) => response == true,
    );

    return allAvailable;
  }
}
