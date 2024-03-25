import 'package:communitybank/controllers/forms/validators/product/product.validator.dart';
import 'package:communitybank/controllers/products/products.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/views/widgets/definitions/products/products.widgets.dart';
import 'package:communitybank/views/widgets/forms/adding/products/products_adding_form.widget.dart';
import 'package:communitybank/views/widgets/forms/adding/stocks/stock_adding_input_form.widget.dart';
import 'package:communitybank/views/widgets/forms/adding/stocks/stock_adding_output_form.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/product/product_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/product/product_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/string_dropdown/string_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchProvider = StateProvider.family<String, String>((ref, name) {
  return '';
});

final isSearchingProvider = StateProvider.family<bool, String>((ref, name) {
  return false;
});

final productsPurchasePricesProvider =
    StreamProvider<List<double>>((ref) async* {
  yield* ProductsController.getAllProductsPurchasePrices();
});

class ProductsSortOptions extends ConsumerWidget {
  const ProductsSortOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productListStream = ref.watch(productsListStreamProvider);
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
      width: double.maxFinite,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CBIconButton(
                icon: Icons.refresh,
                text: 'Rafraichir',
                onTap: () {
                  ref.invalidate(productsListStreamProvider);
                },
              ),
              CBIconButton(
                icon: Icons.input,
                text: 'Entrée',
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const StockAddingInputForm(),
                  );
                },
              ),
              CBIconButton(
                icon: Icons.input,
                text: 'Sortie',
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const StockAddingOutputForm(),
                  );
                },
              ),
              CBAddButton(
                onTap: () {
                  ref.read(productPictureProvider.notifier).state = null;
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const ProductAddingForm(),
                  );
                },
              ),
            ],
          ),
          CBListProductDropdown(
            label: 'Produit',
            providerName: '',
            dropdownMenuEntriesLabels: productListStream.when(
              data: (data) => data,
              error: (error, stackTrace) => [],
              loading: () => [],
            ),
            dropdownMenuEntriesValues: productListStream.when(
              data: (data) => data,
              error: (error, stackTrace) => [],
              loading: () => [],
            ),
          )
        ],
      ),
    );
  }
}
