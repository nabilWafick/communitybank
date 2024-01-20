import 'package:communitybank/views/widgets/definitions/customers_accounts/customers_accounts_list/customers_accounts_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards_list/customers_cards_list.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/customer_account/customer_account_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/customer_card/customer_card_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CashOperationsSearchOptions extends ConsumerWidget {
  const CashOperationsSearchOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final custumersAccountsOwners =
        ref.watch(customersAccountsListStreamProvider);
    final customersCards = ref.watch(customersCardsListStreamProvider);
    return Container(
      margin: const EdgeInsets.only(
        top: 20.0,
        bottom: 20.0,
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CBFormCustomerAccountDropdown(
            width: 400.0,
            label: 'Compte Client',
            providerName: 'cash-operations-customer-accounts',
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
          CBFormCustomerCardDropdown(
            width: 200.0,
            label: 'Carte',
            providerName: 'cash-operations-customer-card',
            dropdownMenuEntriesLabels: customersCards.when(
              data: (data) => data,
              error: (error, stackTrace) => [],
              loading: () => [],
            ),
            dropdownMenuEntriesValues: customersCards.when(
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
