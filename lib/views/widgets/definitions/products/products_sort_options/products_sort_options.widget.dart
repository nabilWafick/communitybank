import 'package:communitybank/controllers/forms/validators/product/product.validator.dart';
import 'package:communitybank/controllers/products/products.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/views/widgets/forms/adding/products/products_adding_form.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchedProductProvider = StateProvider<String>((ref) {
  return '';
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
        bottom: 40.0,
      ),
      width: double.maxFinite,
      child: Column(
        children: [
          CBAddButton(
            onTap: () {
              ref.read(productPictureProvider.notifier).state = null;
              FunctionsController.showAlertDialog(
                context: context,
                alertDialog: const ProductAddingForm(),
              );
            },
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CBSearchInput(
                hintText: 'Rechercher un produit',
                searchProvider: searchedProductProvider,
              ),
              Row(
                children: [
                  const CBText(
                    text: 'Trier par',
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  CBDropdown(
                      label: 'Prix',
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
