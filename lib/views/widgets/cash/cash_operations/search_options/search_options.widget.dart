import 'package:communitybank/controllers/forms/validators/multiple_settlements/multiple_settlements.validator.dart';
import 'package:communitybank/controllers/forms/validators/settlement/settlement.validator.dart';
import 'package:communitybank/controllers/settlements/settlements.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/models/data/settlement/settlement.model.dart';
import 'package:communitybank/models/data/type/type.model.dart';
import 'package:communitybank/views/widgets/cash/cash_operations/search_options/customer_account_search_input/customer_account_search_input.widget.dart';
import 'package:communitybank/views/widgets/cash/cash_operations/search_options/customer_card_dropdown/customer_card_dropdown.widget.dart';
import 'package:communitybank/views/widgets/cash/cash_operations/search_options/custumer_account_dropdown/customer_account_dropdown.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards_list/customers_cards_list.widget.dart';
import 'package:communitybank/views/widgets/forms/adding/multiple_settlements/multiple_setllements_adding_form.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

// for showing | hiding repaid, satisfied, transfered  customer card
final showAllCustomerCardsProvider = StateProvider<bool>((ref) {
  return false;
});

class CashOperationsSearchOptions extends ConsumerWidget {
  const CashOperationsSearchOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final custumersAccountsOwners =
    //     ref.watch(customersAccountsListStreamProvider);
    final customersCardsWithOwners =
        ref.watch(customersCardsWithOwnerListStreamProvider);
    final cashOperationsSelectedCustomerAccount =
        ref.watch(cashOperationsSelectedCustomerAccountProvider);
    final showAllCustomerCards = ref.watch(showAllCustomerCardsProvider);

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 15.0,
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          const CBCashOperationsCustomerAccountSearchInput(),
          CBCashOperationsSearchOptionsCustumerCardDropdown(
            width: 200.0,
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
          SizedBox(
            width: 220.0,
            child: CheckboxListTile(
              value: showAllCustomerCards,
              title: const CBText(
                text: 'Toutes les cartes',
                fontSize: 12,
              ),
              hoverColor: Colors.transparent,
              onChanged: (value) {
                ref
                    .read(
                      showAllCustomerCardsProvider.notifier,
                    )
                    .state = value!;
              },
            ),
          ),
        ],
      ),
    );
  }
}
