import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/models/data/type/type.model.dart';
import 'package:communitybank/views/widgets/definitions/collectors/collectors_list/collectors_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/types/types.widgets.dart';
import 'package:communitybank/views/widgets/definitions/customers_accounts/customers_accounts_list/customers_accounts_list.widget.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/collector/collector_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_account/customer_account_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/type/type_dropdown.widget.dart';
//import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/statistics/customers_types/customers_types_data/customers_types_data.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
//import 'package:intl/intl.dart';

class CustomersTypesStatisticsSortOptions extends StatefulHookConsumerWidget {
  const CustomersTypesStatisticsSortOptions({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomersTypesStatisticsSortOptionsState();
}

class _CustomersTypesStatisticsSortOptionsState
    extends ConsumerState<CustomersTypesStatisticsSortOptions> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final customersAccountsListStream =
        ref.watch(customersAccountsListStreamProvider);
    final collectorsListStream = ref.watch(collectorsListStreamProvider);
    final typesListStream = ref.watch(typesListStreamProvider);
    //  final CustomersTypesStatisticsDataCollectionDate =
    //      ref.watch(CustomersTypesStatisticsDataCollectionDateProvider);
    //  final CustomersTypesStatisticsDataEntryDate =
    //      ref.watch(CustomersTypesStatisticsDataEntryDateProvider);

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
                    ref.invalidate(customersTypesStatisticsDataStreamProvider);
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
                providerName: 'customers-types-statistics-customer-account',
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
                providerName: 'customers-types-statistics-collector',
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
              CBListTypeDropdown(
                width: 250.0,
                label: 'Type',
                menuHeigth: 500.0,
                providerName: 'customers-types-statistics-type',
                dropdownMenuEntriesLabels: typesListStream.when(
                  data: (data) => [
                    Type(
                      name: 'Tous',
                      stake: 0.0,
                      productsIds: [],
                      productsNumber: [],
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
                dropdownMenuEntriesValues: typesListStream.when(
                  data: (data) => [
                    Type(
                      name: 'Tous',
                      stake: 0.0,
                      productsIds: [],
                      productsNumber: [],
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
