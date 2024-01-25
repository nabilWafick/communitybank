import 'package:communitybank/controllers/settlement/settlement.controller.dart';
import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/models/data/settlement/settlement.model.dart';
import 'package:communitybank/views/widgets/definitions/cash_operations/cash_operations_search_options/cash_operations_search_options_custumer_account_dropdown/cash_operations_search_options_customer_account_dropdown.widget.dart';
import 'package:communitybank/views/widgets/definitions/cash_operations/cash_operations_search_options/cash_operations_search_options_customer_card_dropdown/cash_operations_search_options_customer_card_dropdown.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_accounts/customers_accounts_list/customers_accounts_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards_list/customers_cards_list.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:communitybank/models/data/type/type.model.dart';

final cashOperationsSelectedCustomerAccountProvider =
    StateProvider<CustomerAccount?>((ref) {
  return;
});

final cashOperationsSelectedCustomerAccountOwnerProvider =
    StateProvider<Customer?>((ref) {
  return;
});

final cashOperationsSelectedCustomerAccountCollectorProvider =
    StateProvider<Collector?>((ref) {
  return;
});

final cashOperationsSelectedCustomerAccountOwnerCustomerCardsProvider =
    StateProvider<List<CustomerCard>>((ref) {
  return [];
});

final cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider =
    StateProvider<CustomerCard?>((ref) {
  return;
});

final cashOperationsSelectedCustomerAccountOwnerSelectedCardTypeProvider =
    StateProvider<Type?>((ref) {
  return;
});

final cashOperationsSelectedCustomerAccountOwnerSelectedCardSettlementsProvider =
    StreamProvider<List<Settlement>>((ref) {
  final selectedAccountCard =
      ref.watch(cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider);

  return selectedAccountCard != null
      ? SettlementsController.getAll(customerCardId: selectedAccountCard.id)
      : SettlementsController.getAll(
          customerCardId: 1000000000000000000,
        );
});

class CashOperationsSearchOptions extends ConsumerWidget {
  const CashOperationsSearchOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final custumersAccountsOwners =
        ref.watch(customersAccountsListStreamProvider);
    final customersCardsWithOwners =
        ref.watch(customersCardsWithOwnerListStreamProvider);

    return Container(
      margin: const EdgeInsets.only(
        top: 20.0,
        bottom: 20.0,
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CBCashOperationsSearchOptionsCustomerAccountDropdown(
            width: 400.0,
            label: 'Compte Client',
            providerName: 'cash-operations-search-options-customer-account',
            dropdownMenuEntriesLabels: custumersAccountsOwners.when(
              data: (data) => data,
              error: (error, stackTrace) => [],
              loading: () => [],
            ),
            dropdownMenuEntriesValues: custumersAccountsOwners.when(
              data: (data) => data,
              error: (error, stackTrace) => [],
              loading: () => [],
            ),
          ),
          CBCashOperationsSearchOptionsCustumerCardDropdown(
            width: 200.0,
            label: 'Carte',
            providerName: 'cash-operations-search-option-customer-card',
            dropdownMenuEntriesLabels: customersCardsWithOwners.when(
              data: (data) => data,
              error: (error, stackTrace) => [],
              loading: () => [],
            ),
            dropdownMenuEntriesValues: customersCardsWithOwners.when(
              data: (data) => data,
              error: (error, stackTrace) => [],
              loading: () => [],
            ),
          )
        ],
      ),
    );
  }
}
