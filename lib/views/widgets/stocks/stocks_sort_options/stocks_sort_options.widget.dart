import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/views/widgets/definitions/products/products.widgets.dart';
import 'package:communitybank/views/widgets/forms/adding/stocks/input/input_adding_form.widget.dart';
import 'package:communitybank/views/widgets/forms/adding/stocks/output/output_adding_form.widget.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/product/product_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StocksSortOptions extends ConsumerWidget {
  const StocksSortOptions({super.key});

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
              const SizedBox(
                width: 10.0,
              ),
              /* CBAddButton(
                onTap: () {
                  ref.read(productPictureProvider.notifier).state = null;
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const ProductAddingForm(),
                  );
                },
              ),*/
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 25.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CBListProductDropdown(
                  width: 400.0,
                  menuHeigth: 500.0,
                  label: 'Produit',
                  providerName: 'stocks-product',
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
                ),
                CBIconButton(
                  icon: Icons.transit_enterexit,
                  text: 'Entrée',
                  onTap: () {
                    FunctionsController.showAlertDialog(
                      context: context,
                      alertDialog: const StockInputAddingForm(),
                    );
                  },
                ),
                CBIconButton(
                  icon: Icons.arrow_outward,
                  text: 'Sortie',
                  onTap: () {
                    FunctionsController.showAlertDialog(
                      context: context,
                      alertDialog: const StockOutputAddingForm(),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
