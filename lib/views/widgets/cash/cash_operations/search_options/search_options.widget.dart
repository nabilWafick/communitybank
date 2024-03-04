import 'package:communitybank/controllers/forms/validators/multiple_settlements/multiple_settlements.validator.dart';
import 'package:communitybank/controllers/forms/validators/settlement/settlement.validator.dart';
import 'package:communitybank/controllers/settlement/settlement.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/models/data/settlement/settlement.model.dart';
import 'package:communitybank/views/widgets/cash/cash_operations/search_options/custumer_account_dropdown/customer_account_dropdown.widget.dart';
import 'package:communitybank/views/widgets/cash/cash_operations/search_options/customer_card_dropdown/customer_card_dropdown.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_accounts/customers_accounts_list/customers_accounts_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards_list/customers_cards_list.widget.dart';
import 'package:communitybank/views/widgets/forms/adding/multiple_settlements/multiple_setllements_adding_form.widget.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
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

// for refresheshing cash operation providers
final isRefreshingProvider = StateProvider<bool>((ref) {
  return true;
});

class CashOperationsSearchOptions extends ConsumerWidget {
  const CashOperationsSearchOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final custumersAccountsOwners =
        ref.watch(customersAccountsListStreamProvider);
    final customersCardsWithOwners =
        ref.watch(customersCardsWithOwnerListStreamProvider);
    final cashOperationsSelectedCustomerAccount =
        ref.watch(cashOperationsSelectedCustomerAccountProvider);

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 15.0,
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CBIconButton(
            icon: Icons.refresh,
            text: 'Rafraichir',
            onTap: () {
              // refresh customer account dropdown
              ref
                  .read(
                      cashOperationsSearchOptionsCustomerAccountDropdownProvider(
                              'cash-operations-search-options-customer-account')
                          .notifier)
                  .state = null;

              // refresh customer card dropdown
              ref
                  .read(
                    cashOperationsSearchOptionsCustomerCardDropdownProvider(
                      'cash-operations-search-options-customer-card',
                    ).notifier,
                  )
                  .state = null;

              ref.read(isRefreshingProvider.notifier).state = true;
              // customer account
              ref.invalidate(cashOperationsSelectedCustomerAccountProvider);
              // account owner
              ref.invalidate(
                  cashOperationsSelectedCustomerAccountOwnerProvider);
              // selected customer card
              ref.invalidate(
                  cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider);
              // account owner customer cards
              ref.invalidate(
                  cashOperationsSelectedCustomerAccountOwnerCustomerCardsProvider);
              // collector
              ref.invalidate(
                  cashOperationsSelectedCustomerAccountCollectorProvider);
              // selected customer card type
              ref.invalidate(
                cashOperationsSelectedCustomerAccountOwnerSelectedCardTypeProvider,
              );

              // settlements
              ref.invalidate(
                  cashOperationsSelectedCustomerAccountOwnerSelectedCardSettlementsProvider);
            },
          ),
          CBCashOperationsSearchOptionsCustomerAccountDropdown(
            width: 400.0,
            menuHeigth: 500.0,
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
            width: 220.0,
            menuHeigth: 500.0,
            label: 'Carte',
            providerName: 'cash-operations-search-options-customer-card',
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
          ),
          cashOperationsSelectedCustomerAccount != null &&
                  cashOperationsSelectedCustomerAccount
                          .customerCardsIds.length >
                      1
              ? CBIconButton(
                  icon: Icons.add_circle,
                  text: 'Régler plusieurs cartes',
                  onTap: () {
                    // reset collection date provider
                    ref.read(settlementCollectionDateProvider.notifier).state =
                        null;
                    // reset added inputs provider
                    ref
                        .read(
                          multipleSettlementsAddedInputsProvider.notifier,
                        )
                        .state = {};
                    // reset selected types provider
                    ref
                        .read(
                          multipleSettlementsSelectedTypesProvider.notifier,
                        )
                        .state = {};
                    // reset selected customer cards provider
                    ref
                        .read(
                          multipleSettlementsSelectedCustomerCardsProvider
                              .notifier,
                        )
                        .state = {};

                    FunctionsController.showAlertDialog(
                      context: context,
                      alertDialog: const MultipleSettlementsAddingForm(),
                    );
                  },
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
