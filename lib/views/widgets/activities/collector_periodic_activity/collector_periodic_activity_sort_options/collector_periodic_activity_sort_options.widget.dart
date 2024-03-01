import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/models/data/collector_periodic_activity/collector_periodic_activity.model.dart';
import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/views/widgets/activities/collector_periodic_activity/collector_periodic_activity_data/collector_periodic_activity_data.widget.dart';
import 'package:communitybank/views/widgets/definitions/collectors/collectors_list/collectors_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_accounts/customers_accounts_list/customers_accounts_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/collector/collector_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_account/customer_account_dropdown.widget.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
//import 'package:intl/intl.dart';

final collectorPeriodicActivityCollectionBeginDateProvider =
    StateProvider<DateTime?>((ref) {
  return;
});

final collectorPeriodicActivityCollectionEndDateProvider =
    StateProvider<DateTime?>((ref) {
  return;
});

class CollectorPeriodicActivitySortOptions extends StatefulHookConsumerWidget {
  const CollectorPeriodicActivitySortOptions({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CollectorPeriodicActivitySortOptionsState();
}

class _CollectorPeriodicActivitySortOptionsState
    extends ConsumerState<CollectorPeriodicActivitySortOptions> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final collectorsListStream = ref.watch(collectorsListStreamProvider);
    final customersAccountsListStream =
        ref.watch(customersAccountsListStreamProvider);
    final collectorPeriodicActivityCollectionDate =
        ref.watch(collectorPeriodicActivityCollectionBeginDateProvider);
    final collectorPeriodicActivityCollectionEndDate =
        ref.watch(collectorPeriodicActivityCollectionEndDateProvider);

    final format = DateFormat.yMMMMEEEEd('fr');
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: CBIconButton(
                  icon: Icons.refresh,
                  text: 'Rafraichir',
                  onTap: () {
                    ref.invalidate(collectorPeriodicActivityDataProvider);
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 10.0,
              ),
              SizedBox(
                width: 320.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CBIconButton(
                      icon: Icons.date_range,
                      text: 'Date de Début',
                      onTap: () async {
                        await FunctionsController.showDateTime(
                          context: context,
                          ref: ref,
                          stateProvider:
                              collectorPeriodicActivityCollectionBeginDateProvider,
                        );
                      },
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Flexible(
                      child: CBText(
                        text: collectorPeriodicActivityCollectionDate != null
                            ? format
                                .format(collectorPeriodicActivityCollectionDate)
                            : '',
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    //   const SizedBox(),
                  ],
                ),
              ),
              SizedBox(
                width: 320.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CBIconButton(
                      icon: Icons.date_range,
                      text: 'Date de Fin',
                      onTap: () async {
                        await FunctionsController.showDateTime(
                          context: context,
                          ref: ref,
                          stateProvider:
                              collectorPeriodicActivityCollectionEndDateProvider,
                        );
                      },
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Flexible(
                      child: CBText(
                        text: collectorPeriodicActivityCollectionEndDate != null
                            ? format.format(
                                collectorPeriodicActivityCollectionEndDate)
                            : '',
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    //   const SizedBox(),
                  ],
                ),
              ),
              CBListCollectorDropdown(
                width: 300.0,
                menuHeigth: 500.0,
                label: 'Collecteur',
                providerName: 'collector-periodic-activity-collector',
                dropdownMenuEntriesLabels: collectorsListStream.when(
                  data: (data) => [
                    Collector(
                      id: 0,
                      name: 'Tous',
                      firstnames: '',
                      phoneNumber: '',
                      address: '',
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data,
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
                dropdownMenuEntriesValues: collectorsListStream.when(
                  data: (data) => [
                    Collector(
                      id: 0,
                      name: 'Tous',
                      firstnames: '',
                      phoneNumber: '',
                      address: '',
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
                width: 300.0,
                menuHeigth: 500.0,
                label: 'Clients',
                providerName: 'collector-periodic-activity-customer-account',
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
              Container(
                alignment: Alignment.center,
                width: 100,
                height: 70.0,
                child: TextFormField(
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
                          'collector-periodic-activity-settlements-number',
                        ).notifier)
                        .state = value;
                  },
                ),
              ),
            ],
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(
                top: 10.0,
              ),
              alignment: Alignment.center,
              child: Row(
                children: [
                  const CBText(
                    text: 'Total Réglé:',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final collectorPeriodicActivityDataStream =
                          ref.watch(collectorPeriodicActivityDataProvider);

                      return collectorPeriodicActivityDataStream.when(
                        data: (data) {
                          double settlementsAmountsTotals = 0;

                          for (CollectorPeriodicActivity collectorPeriodicActivity
                              in data) {
                            for (int i = 0;
                                i <
                                    collectorPeriodicActivity
                                        .customerCardSettlementsAmounts.length;
                                i++) {
                              settlementsAmountsTotals +=
                                  collectorPeriodicActivity
                                      .customerCardSettlementsAmounts[i];
                            }
                          }
                          return CBText(
                            text: '${settlementsAmountsTotals.ceil()}f',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          );
                        },
                        error: (error, stackTrace) => const CBText(
                          text: '',
                          fontSize: 12.0,
                        ),
                        loading: () => const CBText(
                          text: '',
                          fontSize: 12.0,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
