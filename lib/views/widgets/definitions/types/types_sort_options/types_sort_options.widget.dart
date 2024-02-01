import 'package:communitybank/controllers/forms/validators/type/type.validator.dart';
import 'package:communitybank/controllers/types/types.controller.dart';
import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/views/widgets/definitions/products/products_list/products_list.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/definitions/types/types_list/types_list.widget.dart';
import 'package:communitybank/views/widgets/forms/adding/types/types_adding_form.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/product/product_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/string_dropdown/string_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final typesStakesProvider = StreamProvider<List<double>>((ref) async* {
  yield* TypesController.getAllTypesStakes();
});

class TypesSortOptions extends ConsumerWidget {
  const TypesSortOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typesStakes = ref.watch(typesStakesProvider);
    final productsListStream = ref.watch(productsListStreamProvider);

    return Container(
      margin: const EdgeInsets.only(
        bottom: 40.0,
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
                  ref.invalidate(typesListStreamProvider);
                },
              ),
              CBAddButton(
                onTap: () {
                  ref.read(typeAddedInputsProvider.notifier).state = {};
                  ref.read(typeSelectedProductsProvider.notifier).state = {};
                  showDialog(
                    context: context,
                    builder: (context) => const TypesAddingForm(),
                    // CustomersForm(),
                    // FormCard(),
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CBSearchInput(
                hintText: 'Rechercher un type',
                searchProvider: searchProvider('types'),
              ),
              Row(
                children: [
                  const CBText(
                    text: 'Trier par',
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  CBListStringDropdown(
                    width: 120.0,
                    menuHeigth: 500.0,
                    label: 'Mise',
                    providerName: 'types-stackes',
                    dropdownMenuEntriesLabels: typesStakes.when(
                      data: (data) {
                        // parse data list to set for getting only unique data
                        data = data.toSet().toList();
                        List<String> stakes = ['Toutes'];
                        for (double stake in data) {
                          stakes.add('${stake.ceil().toString()} f/Jour');
                        }

                        return stakes;
                      },
                      error: (data, stackTrace) => [],
                      loading: () => [],
                    ),
                    /*[
                      'Toutes',
                      '100f/Jour',
                      '150f/Jour',
                      '200f/Jour',
                      '250f/Jour',
                      '300f/Jour',
                    ]*/
                    dropdownMenuEntriesValues: typesStakes.when(
                      data: (data) {
                        // parse data list to set for getting only unique data
                        data = data.toSet().toList();
                        List<String> stakes = ['*'];
                        for (double stake in data) {
                          stakes.add(stake.ceil().toString());
                        }

                        return stakes;
                      },
                      error: (data, stackTrace) => [],
                      loading: () => [],
                    ) /* [
                      '*',
                      '100',
                      '150',
                      '200',
                      '250',
                      '300',
                    ]*/
                    ,
                  ),
                  CBListProductDropdown(
                    width: 200.0,
                    menuHeigth: 500.0,
                    label: 'Produit',
                    providerName: 'types-products',
                    dropdownMenuEntriesLabels: productsListStream.when(
                      data: (data) {
                        return [
                          Product(
                            id: 0,
                            name: 'Tous',
                            purchasePrice: 0,
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                          ...data
                        ];
                      },
                      error: (error, stackTrace) => [],
                      loading: () => [],
                    ),
                    dropdownMenuEntriesValues: productsListStream.when(
                      data: (data) {
                        return [
                          Product(
                            id: 0,
                            name: 'Tous',
                            purchasePrice: 0,
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                          ...data
                        ];
                      },
                      error: (error, stackTrace) => [],
                      loading: () => [],
                    ),
                  ),
                  /*  const CBDropdown(
                    label: 'Produit',
                    providerName: 'types-product',
                    dropdownMenuEntriesLabels: [
                      'Tous',
                      'Produit 1',
                      'Produit 2',
                      'Produit 3',
                      'Produit 4',
                      'Produit 5',
                    ],
                    dropdownMenuEntriesValues: [
                      '*',
                      'Produit 1',
                      'Produit 2',
                      'Produit 3',
                      'Produit 4',
                      'Produit 5',
                    ],
                  ),
                */
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
