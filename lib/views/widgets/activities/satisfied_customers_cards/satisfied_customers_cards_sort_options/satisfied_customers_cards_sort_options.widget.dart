import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/models/data/type/type.model.dart';
import 'package:communitybank/views/widgets/activities/satisfied_customers_cards/satisfied_customers_cards.widgets.dart';
import 'package:communitybank/views/widgets/definitions/collectors/collectors_list/collectors_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_accounts/customers_accounts_list/customers_accounts_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/types/types_list/types_list.widget.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/collector/collector_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_account/customer_account_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/type/type_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
//import 'package:intl/intl.dart';

final satisfiedCustomersCardsBeginDateProvider =
    StateProvider<DateTime?>((ref) {
  return;
});

final satisfiedCustomersCardsEndDateProvider = StateProvider<DateTime?>((ref) {
  return;
});

class SatisfiedCustomersCardsSortOptions extends StatefulHookConsumerWidget {
  const SatisfiedCustomersCardsSortOptions({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SatisfiedCustomersCardsSortOptionsState();
}

class _SatisfiedCustomersCardsSortOptionsState
    extends ConsumerState<SatisfiedCustomersCardsSortOptions> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final satisfiedCustomersCardsBeginDate =
        ref.watch(satisfiedCustomersCardsBeginDateProvider);
    final satisfiedCustomersCardsEndDate =
        ref.watch(satisfiedCustomersCardsBeginDateProvider);
    final collectorsListStream = ref.watch(collectorsListStreamProvider);
    final customersAccountsListStream =
        ref.watch(customersAccountsListStreamProvider);
    final typesListStreamListStream = ref.watch(typesListStreamProvider);
    //   final settlementsListEntryDate =
    //       ref.watch(settlementsListEntryDateProvider);

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
                    ref.invalidate(satisfiedCustomersCardsListStreamProvider);
                  },
                ),
              ),
            ],
          ),
          Wrap(
            runSpacing: 10.0,
            spacing: 10.0,
            children: [
              const SizedBox(
                width: 10.0,
              ),
              SizedBox(
                width: 400.0,
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
                              satisfiedCustomersCardsBeginDateProvider,
                        );
                      },
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Flexible(
                      child: CBText(
                        text: satisfiedCustomersCardsBeginDate != null
                            ? format.format(satisfiedCustomersCardsBeginDate)
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
                width: 400.0,
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
                          stateProvider: satisfiedCustomersCardsEndDateProvider,
                        );
                      },
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Flexible(
                      child: CBText(
                        text: satisfiedCustomersCardsEndDate != null
                            ? format.format(satisfiedCustomersCardsEndDate)
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
                providerName: 'satisfied-customers-cards-collector',
                dropdownMenuEntriesLabels: collectorsListStream.when(
                  data: (data) => [
                    Collector(
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
                providerName: 'satisfied-customers-cards-customer-account',
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
              CBListTypeDropdown(
                width: 300.0,
                menuHeigth: 500.0,
                label: 'Type',
                providerName: 'satisfied-customers-cards-type',
                dropdownMenuEntriesLabels: typesListStreamListStream.when(
                  data: (data) => [
                    Type(
                      name: 'Tous',
                      stake: .0,
                      productsIds: [],
                      productsNumber: [],
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data,
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
                dropdownMenuEntriesValues: typesListStreamListStream.when(
                  data: (data) => [
                    Type(
                      name: 'Tous',
                      stake: .0,
                      productsIds: [],
                      productsNumber: [],
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
        ],
      ),
    );
  }
}
