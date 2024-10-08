import 'package:communitybank/controllers/forms/validators/product/product.validator.dart';
import 'package:communitybank/controllers/products/products.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/views/widgets/definitions/products/products.widgets.dart';
import 'package:communitybank/views/widgets/forms/adding/products/products_adding_form.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
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
    final productsPurchasePrices = ref.watch(productsPurchasePricesProvider);
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
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Row(
                children: [
                  const CBText(
                    text: 'Trier par',
                    fontSize: 12.0,
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  CBListStringDropdown(
                      label: 'Prix',
                      menuHeigth: 500.0,
                      providerName: 'products-price',
                      dropdownMenuEntriesLabels: productsPurchasePrices.when(
                        data: (data) {
                          // parse data list to set for getting only unique data
                          data = data.toSet().toList();
                          List<String> prices = ['Tous'];
                          for (double price in data) {
                            prices.add('${price.ceil().toString()}f');
                          }

                          return prices;
                        },
                        error: (data, stackTrace) => [],
                        loading: () => [],
                      ),
                      dropdownMenuEntriesValues: productsPurchasePrices.when(
                        data: (data) {
                          // parse data list to set for getting only unique data
                          data = data.toSet().toList();
                          List<String> prices = ['*'];
                          for (double price in data) {
                            prices.add(price.ceil().toString());
                          }

                          return prices;
                        },
                        error: (data, stackTrace) => [],
                        loading: () => [],
                      )
                      /*  [
                      '*',
                      '1000',
                      '1500',
                      '2000',
                      '2500',
                      '3000',
                    ],*/
                      ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
