import 'package:communitybank/controllers/forms/validators/customer_account/customer_account.validator.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards_list/customers_cards_list.widget.dart';
import 'package:communitybank/views/widgets/globals/customer_account_owner_card_selection_dropdown/customer_account_owner_card_selection_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomerAccountOwnerCardSelection extends StatefulHookConsumerWidget {
  final int index;
  final bool isVisible;
  final String customerCardDropdownProvider;
  final CustomerCard? customerCard;
  final double formCardWidth;
  const CustomerAccountOwnerCardSelection({
    super.key,
    required this.index,
    required this.isVisible,
    required this.customerCardDropdownProvider,
    this.customerCard,
    required this.formCardWidth,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomerAccountOwnerCardSelectionState();
}

class _CustomerAccountOwnerCardSelectionState
    extends ConsumerState<CustomerAccountOwnerCardSelection> {
  @override
  Widget build(BuildContext context) {
    // const formCardWidth = 50.0;
    final showWidget = useState(widget.isVisible);
    final customersCardsListStream =
        ref.watch(customersCardsListStreamProvider);
    final customerAccountSelectedOwnerCards =
        ref.watch(customerAccountSelectedOwnerCardsProvider);
    return showWidget.value
        ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
            width: widget.formCardWidth / 2.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /* const CBText(
                  text: 'Customer Card Dropdown',
                ),*/
                CBCustomerAccountOwnerCardSelectionDropdown(
                  width: widget.formCardWidth / 3.5,
                  label: 'Carte',
                  providerName: widget.customerCardDropdownProvider,
                  dropdownMenuEntriesLabels: customersCardsListStream.when(
                    data: (data) {
                      // verify if the customerCard isn't null, necessary in the
                      // the case where it's adding, because any won't be
                      // passed in case of adding
                      // the customerCard have been putted in first position so
                      // as to it selected as the first dropdow element
                      // after rending

                      if (widget.customerCard != null) {
                        data.remove(widget.customerCard);
                        data = [widget.customerCard!, ...data];
                      }
                      return data
                          .where(
                            (customerCard) =>
                                customerAccountSelectedOwnerCards
                                    .containsValue(customerCard) ==
                                false,
                          )
                          .toList();
                    },
                    error: (error, stackTrace) => [],
                    loading: () => [],
                  ),
                  dropdownMenuEntriesValues: customersCardsListStream.when(
                    data: (data) {
                      if (widget.customerCard != null) {
                        data.remove(widget.customerCard);
                        data = [widget.customerCard!, ...data];
                      }
                      return data
                          .where(
                            (customerCard) =>
                                customerAccountSelectedOwnerCards
                                    .containsValue(customerCard) ==
                                false,
                          )
                          .toList();
                    },
                    error: (error, stackTrace) => [],
                    loading: () => [],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showWidget.value = false;
                    ref
                        .read(customerAccountAddedInputsProvider.notifier)
                        .update((state) {
                      // if input is visible, hide it
                      state[widget.index] = showWidget.value;
                      //  debugPrint('typeAddedInputsProvider');
                      //  debugPrint(state.toString());

                      return state;
                    });

                    // remove the selected customerCard from customerAccountSelectedCards
                    ref
                        .read(
                            customerAccountSelectedOwnerCardsProvider.notifier)
                        .update((state) {
                      // since customerAccountSelectedCards use type selection dropdown provider as key
                      state.remove(widget.customerCardDropdownProvider);
                      // debugPrint('customerAccountSelectedCardsProvider');
                      // debugPrint('length: ${state.length}');
                      // debugPrint(state.toString());
                      return state;
                    });
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: CBColors.primaryColor,
                    size: 25.0,
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
