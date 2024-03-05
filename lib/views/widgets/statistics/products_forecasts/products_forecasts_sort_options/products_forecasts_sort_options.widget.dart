import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/views/widgets/definitions/collectors/collectors_list/collectors_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_accounts/customers_accounts_list/customers_accounts_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/products/products.widgets.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/collector/collector_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_account/customer_account_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/product/product_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:communitybank/views/widgets/statistics/products_forecasts/products_forecasts_data/products_forecasts_data.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
//import 'package:intl/intl.dart';

class ProductsForecastsStatisticsSortOptions
    extends StatefulHookConsumerWidget {
  const ProductsForecastsStatisticsSortOptions({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductsForecastsStatisticsSortOptionsState();
}

class _ProductsForecastsStatisticsSortOptionsState
    extends ConsumerState<ProductsForecastsStatisticsSortOptions> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final productListStream = ref.watch(productsListStreamProvider);
    final customersAccountsListStream =
        ref.watch(customersAccountsListStreamProvider);
    final collectorsListStream = ref.watch(collectorsListStreamProvider);

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
                      productsForecastsStatisticsDataStreamProvider,
                    );
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CBListProductDropdown(
                width: 350.0,
                menuHeigth: 500.0,
                label: 'Produit',
                providerName: 'products-forecasts-statistics-product',
                dropdownMenuEntriesLabels: productListStream.when(
                  data: (data) => [
                    Product(
                      name: 'Tous',
                      purchasePrice: 0,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data,
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
                dropdownMenuEntriesValues: productListStream.when(
                  data: (data) => [
                    Product(
                      name: 'Tous',
                      purchasePrice: 0,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data,
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
              ),
              CBListCustomerAccountDropdown(
                width: 350.0,
                menuHeigth: 500.0,
                label: 'Client',
                providerName: 'products-forecasts-statistics-customer-account',
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
              CBListCollectorDropdown(
                width: 350.0,
                menuHeigth: 500.0,
                label: 'Chargé de compte',
                providerName: 'products-forecasts-statistics-collector',
                dropdownMenuEntriesLabels: collectorsListStream.when(
                  data: (data) => [
                    Collector(
                      name: 'Tous',
                      firstnames: '',
                      phoneNumber: '',
                      address: 'Address',
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
                dropdownMenuEntriesValues: collectorsListStream.when(
                  data: (data) => [
                    Collector(
                      name: 'Tous',
                      firstnames: '',
                      phoneNumber: '',
                      address: 'Address',
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 200,
                height: 70.0,
                child: TextFormField(
                  initialValue: '186',
                  cursorHeight: 20.0,
                  style: const TextStyle(
                    fontSize: 12.0,
                  ),
                  decoration: const InputDecoration(
                    label: CBText(
                      text: 'Règlement',
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    hintText: 'Nbre Règlement',
                  ),
                  onChanged: (value) {
                    ref
                        .read(searchProvider(
                          'products-forecasts-statistics-settlements-number',
                        ).notifier)
                        .state = value;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
