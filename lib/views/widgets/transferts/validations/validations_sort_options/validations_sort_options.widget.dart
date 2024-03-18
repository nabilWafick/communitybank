//import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/agent/agent.model.dart';
import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/views/widgets/cash/settlements/settlements_list/settlements_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/agents/agents.widgets.dart';
import 'package:communitybank/views/widgets/definitions/customers_accounts/customers_accounts_list/customers_accounts_list.widget.dart';
//import 'package:communitybank/views/widgets/definitions/cash_operations/cash_operations_infos/cash_operations_customer_card_infos/cash_operations_customer_card_infos.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards_list/customers_cards_list.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/agent/agent_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_account/customer_account_dropdown.widget.dart';
//import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_card/customer_card_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
//import 'package:intl/intl.dart';

final settlementsListCollectionDateProvider = StateProvider<DateTime?>((ref) {
  return;
});
final settlementsListEntryDateProvider = StateProvider<DateTime?>((ref) {
  return;
});

class TransfersValidationsSortOptions extends StatefulHookConsumerWidget {
  const TransfersValidationsSortOptions({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransfersValidationsSortOptionsState();
}

class _TransfersValidationsSortOptionsState
    extends ConsumerState<TransfersValidationsSortOptions> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final customersCardsWithOwnerListStream =
        ref.watch(customersCardsWithOwnerListStreamProvider);
    final customersAccountsListStream =
        ref.watch(customersAccountsListStreamProvider);
    final agentsListStream = ref.watch(agentsListStreamProvider);

    //   final format = DateFormat.yMMMMEEEEd('fr');
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
              CBListCustomerAccountDropdown(
                label: 'Client',
                providerName:
                    'transfer-between-customer-cards-customer-account',
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
              CBListCustomerCardDropdown(
                width: 200.0,
                label: 'Carte Émettrice',
                menuHeigth: 500.0,
                providerName: 'transfer-between-customer-cards-issuing-card',
                dropdownMenuEntriesLabels:
                    customersCardsWithOwnerListStream.when(
                  data: (data) => [
                    CustomerCard(
                      label: 'Tous',
                      typeId: 0,
                      typeNumber: 1,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
                dropdownMenuEntriesValues:
                    customersCardsWithOwnerListStream.when(
                  data: (data) => [
                    CustomerCard(
                      label: 'Tous',
                      typeId: 0,
                      typeNumber: 1,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
              ),
              CBListCustomerCardDropdown(
                width: 200.0,
                label: 'Carte Réceptrice',
                menuHeigth: 500.0,
                providerName: 'transfer-between-customer-cards-receiving-card',
                dropdownMenuEntriesLabels:
                    customersCardsWithOwnerListStream.when(
                  data: (data) => [
                    CustomerCard(
                      label: 'Tous',
                      typeId: 0,
                      typeNumber: 1,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
                dropdownMenuEntriesValues:
                    customersCardsWithOwnerListStream.when(
                  data: (data) => [
                    CustomerCard(
                      label: 'Tous',
                      typeId: 0,
                      typeNumber: 1,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
              ),
              CBListAgentDropdown(
                label: 'Agent',
                providerName: 'transfer-between-customer-cards-agent',
                dropdownMenuEntriesLabels: agentsListStream.when(
                  data: (data) => [
                    Agent(
                      name: 'Tous',
                      firstnames: '',
                      phoneNumber: '',
                      email: '',
                      address: '',
                      role: '',
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
                dropdownMenuEntriesValues: agentsListStream.when(
                  data: (data) => [
                    Agent(
                      name: 'Tous',
                      firstnames: '',
                      phoneNumber: '',
                      email: '',
                      address: '',
                      role: '',
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
