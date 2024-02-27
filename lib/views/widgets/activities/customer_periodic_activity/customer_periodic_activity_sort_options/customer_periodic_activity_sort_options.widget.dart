import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/views/widgets/activities/customer_periodic_activity/customer_periodic_activity_data/customer_account_dopdown/customer_account_dropdown.widget.dart';
import 'package:communitybank/views/widgets/activities/customer_periodic_activity/customer_periodic_activity_data/customer_periodic_activity_data.widget.dart';
import 'package:communitybank/views/widgets/definitions/collectors/collectors_list/collectors_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_accounts/customers_accounts_list/customers_accounts_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/collector/collector_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_account/customer_account_dropdown.widget.dart';
import 'package:communitybank/views/widgets/printing_data_preview/customer_card_settlements_details/customer_card_settlements_details_printing.widget.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
//import 'package:intl/intl.dart';

final customerPeriodicActivityCollectionBeginDateProvider =
    StateProvider<DateTime?>((ref) {
  return;
});

final customerPeriodicActivityCollectionEndDateProvider =
    StateProvider<DateTime?>((ref) {
  return;
});

class CustomerPeriodicActivitySortOptions extends StatefulHookConsumerWidget {
  const CustomerPeriodicActivitySortOptions({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomerPeriodicActivitySortOptionsState();
}

class _CustomerPeriodicActivitySortOptionsState
    extends ConsumerState<CustomerPeriodicActivitySortOptions> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final customersAccountsListStream =
        ref.watch(customersAccountsListStreamProvider);
    final customerPeriodicActivitySelectedCustomerCard =
        ref.watch(customerPeriodicActivitySelectedCustomerCardProvider);

    //  final format = DateFormat.yMMMMEEEEd('fr');
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: CBIconButton(
                  icon: Icons.refresh,
                  text: 'Rafraichir',
                  onTap: () {
                    ref.invalidate(
                      customerCardSettlementsDetailsProvider(
                        customerPeriodicActivitySelectedCustomerCard != null
                            ? customerPeriodicActivitySelectedCustomerCard.id!
                            : 0,
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: CBIconButton(
                  icon: Icons.print,
                  text: 'Imprimer',
                  onTap: () {
                    //  ref.invalidate(customerPeriodicActivityDataProvider);
                  },
                ),
              ),
            ],
          ),
          CBCustomerActivityCustomerAccountDropdown(
            width: 400.0,
            menuHeigth: 500.0,
            label: 'Clients',
            providerName: 'customer-periodic-activity-customer-account',
            dropdownMenuEntriesLabels: customersAccountsListStream.when(
              data: (data) => [
                CustomerAccount(
                  customerId: 0,
                  collectorId: 0,
                  customerCardsIds: [],
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ),
                ...data,
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
                ...data,
              ],
              error: (error, stackTrace) => [],
              loading: () => [],
            ),
          ),
        ],
      ),
    );
  }
}
