import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/views/widgets/definitions/customers_accounts/customers_accounts_list/customers_accounts_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/products/products_list/products_list.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_account/customer_account_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/product/product_dropdown.widget.dart';
//import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/statistics/customers_products/customers_products_data/customers_products_data.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
//import 'package:intl/intl.dart';

class CustomersProductsStatisticsSortOptions
    extends StatefulHookConsumerWidget {
  const CustomersProductsStatisticsSortOptions({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomersProductsStatisticsSortOptionsState();
}

class _CustomersProductsStatisticsSortOptionsState
    extends ConsumerState<CustomersProductsStatisticsSortOptions> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final customersAccountsListStream =
        ref.watch(customersAccountsListStreamProvider);
    final productsListStream = ref.watch(productsListStreamProvider);
    //  final CustomersProductsStatisticsDataCollectionDate =
    //      ref.watch(CustomersProductsStatisticsDataCollectionDateProvider);
    //  final CustomersProductsStatisticsDataEntryDate =
    //      ref.watch(CustomersProductsStatisticsDataEntryDateProvider);

    // final format = DateFormat.yMMMMEEEEd('fr');
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
      width: double.maxFinite,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CBIconButton(
                  icon: Icons.refresh,
                  text: 'Rafraichir',
                  onTap: () {
                    ref.invalidate(
                        customersProductsStatisticsDataStreamProvider);
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CBListCustomerAccountDropdown(
                width: 350.0,
                menuHeigth: 500.0,
                label: 'Client',
                providerName: 'customers-products-statistics-customer-account',
                dropdownMenuEntriesLabels: customersAccountsListStream.when(
                  data: (data) => [
                    CustomerAccount(
                      customerId: 0,
                      collectorId: 0,
                      customerCardsIds: [],
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
                dropdownMenuEntriesValues: customersAccountsListStream.when(
                  data: (data) => [
                    CustomerAccount(
                      customerId: 0,
                      collectorId: 0,
                      customerCardsIds: [],
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
              ),
              CBListProductDropdown(
                width: 250.0,
                label: 'Produit',
                menuHeigth: 500.0,
                providerName: 'customers-products-statistics-product',
                dropdownMenuEntriesLabels: productsListStream.when(
                  data: (data) => [
                    Product(
                      name: 'Tous',
                      purchasePrice: 0.0,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
                dropdownMenuEntriesValues: productsListStream.when(
                  data: (data) => [
                    Product(
                      name: 'Tous',
                      purchasePrice: 0.0,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
