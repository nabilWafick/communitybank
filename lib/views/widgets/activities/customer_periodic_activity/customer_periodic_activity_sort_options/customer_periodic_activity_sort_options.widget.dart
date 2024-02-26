import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/views/widgets/cash/settlements/settlements_list/settlements_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/collectors/collectors_list/collectors_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_accounts/customers_accounts_list/customers_accounts_list.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/collector/collector_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_account/customer_account_dropdown.widget.dart';

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
    final collectorsListStream = ref.watch(collectorsListStreamProvider);
    final customersAccountsListStream =
        ref.watch(customersAccountsListStreamProvider);
    final customerPeriodicActivityCollectionDate =
        ref.watch(customerPeriodicActivityCollectionBeginDateProvider);
    final customerPeriodicActivityCollectionEndDate =
        ref.watch(customerPeriodicActivityCollectionEndDateProvider);

    final format = DateFormat.yMMMMEEEEd('fr');
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
      width: double.maxFinite,
      child: Column(
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
                    ref.invalidate(settlementsListStreamProvider);
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
                          context,
                          ref,
                          customerPeriodicActivityCollectionBeginDateProvider,
                        );
                      },
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Flexible(
                      child: CBText(
                        text: customerPeriodicActivityCollectionDate != null
                            ? format
                                .format(customerPeriodicActivityCollectionDate)
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
                          context,
                          ref,
                          customerPeriodicActivityCollectionEndDateProvider,
                        );
                      },
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Flexible(
                      child: CBText(
                        text: customerPeriodicActivityCollectionEndDate != null
                            ? format.format(
                                customerPeriodicActivityCollectionEndDate)
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
                label: 'Collecteur',
                providerName: 'customer-periodic-activity-collector',
                dropdownMenuEntriesLabels: collectorsListStream.when(
                  data: (data) => data,
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
                dropdownMenuEntriesValues: collectorsListStream.when(
                  data: (data) => data,
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
              ),
              CBListCustomerAccountDropdown(
                label: 'Clients',
                providerName: 'customer-periodic-activity-customer',
                dropdownMenuEntriesLabels: customersAccountsListStream.when(
                  data: (data) => data,
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
                dropdownMenuEntriesValues: customersAccountsListStream.when(
                  data: (data) => data,
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
              ),
              SizedBox(
                width: 100,
                child: CBTextFormField(
                  hintText: 'Nombre de règlements',
                  isMultilineTextForm: false,
                  obscureText: false,
                  textInputType: TextInputType.number,
                  validator: (p0, p1) {
                    return null;
                  },
                  onChanged: (p0, p1) {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
