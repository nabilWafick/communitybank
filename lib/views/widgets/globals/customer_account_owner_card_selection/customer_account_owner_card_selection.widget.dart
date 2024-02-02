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
  final int? customerCardId;
  final double formCardWidth;
  const CustomerAccountOwnerCardSelection({
    super.key,
    required this.index,
    required this.isVisible,
    required this.customerCardDropdownProvider,
    this.customerCardId,
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

    final customerAccountSelectedOwnerCards =
        ref.watch(customerAccountSelectedOwnerCardsProvider);
    return showWidget.value
        ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
            width: widget.formCardWidth / 2.5,
            child: Consumer(
              builder: (context, ref, child) {
                final customersCardsListStream =
                    ref.watch(customersCardsListStreamProvider);

                return customersCardsListStream.when(
                  data: (data) {
                    if (widget.customerCardId != null) {
                      CustomerCard? accountOwnerCard;
                      for (CustomerCard customerCard in data) {
                        if (customerCard.id == widget.customerCardId) {
                          accountOwnerCard = customerCard;
                          break;
                        }
                      }

                      data = [
                        accountOwnerCard!,
                        ...data,
                      ];

                      data = data.toSet().toList();
                    }

                    final remainCustomerCards = data
                        .where(
                          (customerCard) =>
                              customerAccountSelectedOwnerCards
                                  .containsValue(customerCard) ==
                              false,
                        )
                        .toList();

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /* const CBText(
                  text: 'Customer Card Dropdown',
                ),*/
                        CBCustomerAccountOwnerCardSelectionDropdown(
                          width: widget.formCardWidth / 2,
                          label: 'Carte',
                          providerName: widget.customerCardDropdownProvider,
                          dropdownMenuEntriesLabels: remainCustomerCards,
                          dropdownMenuEntriesValues: remainCustomerCards,
                        ),
                        IconButton(
                          onPressed: () {
                            showWidget.value = false;
                            ref
                                .read(
                                    customerAccountAddedInputsProvider.notifier)
                                .update((state) {
                              // if input is visible, hide it
                              state[widget.index] = showWidget.value;
                              //  debugPrint('typeAddedInputsProvider');
                              //  debugPrint(state.toString());

                              return state;
                            });

                            // remove the selected customerCard from customerAccountSelectedCards
                            ref
                                .read(customerAccountSelectedOwnerCardsProvider
                                    .notifier)
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
                    );
                  },
                  error: (error, stackTrace) => SizedBox(
                    width: widget.formCardWidth / 3.5,
                  ),
                  loading: () => SizedBox(
                    width: widget.formCardWidth / 3.5,
                  ),
                );
              },
            ))
        : const SizedBox();
  }
}
