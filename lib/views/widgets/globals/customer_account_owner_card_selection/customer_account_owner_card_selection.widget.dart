import 'dart:math';

import 'package:communitybank/controllers/forms/on_changed/customer_account/customer_account.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/customer_account/customer_account.validator.dart';
import 'package:communitybank/controllers/forms/validators/type/type.validator.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/models/data/type/type.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards.widgets.dart';
import 'package:communitybank/views/widgets/definitions/types/types_list/types_list.widget.dart';
import 'package:communitybank/views/widgets/globals/customer_account_owner_card_selection_dropdown/customer_account_owner_card_selection_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/customer_account_owner_card_selection_textformfield/customer_account_owner_card_selection_textformfield.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomerAccountOwnerCardSelection extends StatefulHookConsumerWidget {
  final int index;
  final bool isVisible;
  final String customerCardTypeSelectionDropdownProvider;
  final int? customerCardId;

  final double formCardWidth;
  const CustomerAccountOwnerCardSelection({
    super.key,
    required this.index,
    required this.isVisible,
    required this.customerCardTypeSelectionDropdownProvider,
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
    //  const formCardWidth = 450.0;
    final showWidget = useState(widget.isVisible);

    final customerAccountOwnerSelectedCardsTypes =
        ref.watch(customerAccountOwnerSelectedCardsTypesProvider);
    return showWidget.value
        ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
            width: widget.formCardWidth,
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final customersCardsListStream =
                    ref.watch(customersCardsListStreamProvider);

                return customersCardsListStream.when(
                  data: (data) {
                    // store the customer card, generated letters by default
                    String accountOwnerCardLabel = '';

                    // store the cstomer card if it's existed
                    CustomerCard? accountOwnerCard;

                    if (widget.customerCardId != null) {
                      for (CustomerCard customerCard in data) {
                        if (customerCard.id == widget.customerCardId) {
                          accountOwnerCard = customerCard;
                          break;
                        }
                      }

                      // set the account owner card label
                      accountOwnerCardLabel = accountOwnerCard!.label;

                      data = [
                        accountOwnerCard,
                        ...data,
                      ];

                      data = data.toSet().toList();
                    } else {
                      accountOwnerCardLabel =
                          generateRandomStringFromDateTimeNowMillis();
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: widget.formCardWidth / 2.5,
                              child:
                                  CBCustomerAccountOwnerCardLabelTextFormField(
                                inputIndex: widget.index,
                                label: 'Libellé',
                                hintText: 'Libellé de la carte',
                                initialValue: accountOwnerCardLabel,
                                textInputType: TextInputType.number,
                                validator: CustomerAccountValidators
                                    .customerAccountOwnerCardLabel,
                                onChanged: CustomerAccountOnChanged
                                    .customerAccountOwnerCardLabel,
                              ),
                            ),
                            Consumer(
                              builder: (context, ref, child) {
                                final typesListStream =
                                    ref.watch(typesListStreamProvider);

                                return typesListStream.when(
                                  data: (data) {
                                    Type? accountOwnerCardType;
                                    if (accountOwnerCard != null) {
                                      for (Type type in data) {
                                        if (type.id ==
                                            accountOwnerCard.typeId) {
                                          accountOwnerCardType = type;
                                          break;
                                        }
                                      }

                                      data = [
                                        accountOwnerCardType!,
                                        ...data,
                                      ];

                                      data.toSet().toSet();
                                    }

                                    final remainProducts = data
                                        .where(
                                          (customerCard) =>
                                              customerAccountOwnerSelectedCardsTypes
                                                  .containsValue(
                                                      customerCard) ==
                                              false,
                                        )
                                        .toList();

                                    return CBCustomerAccountOwnerCardTypeSelectionDropdown(
                                      width: widget.formCardWidth / 2.5,
                                      menuHeigth: 500.0,
                                      label: 'Type',
                                      providerName: widget
                                          .customerCardTypeSelectionDropdownProvider,
                                      dropdownMenuEntriesLabels: remainProducts,
                                      dropdownMenuEntriesValues: remainProducts,
                                    );
                                  },
                                  error: (error, stackTrace) =>
                                      CBCustomerAccountOwnerCardTypeSelectionDropdown(
                                    width: widget.formCardWidth / 2.5,
                                    menuHeigth: 500.0,
                                    label: 'Type',
                                    providerName: widget
                                        .customerCardTypeSelectionDropdownProvider,
                                    dropdownMenuEntriesLabels: const [],
                                    dropdownMenuEntriesValues: const [],
                                  ),
                                  loading: () =>
                                      CBCustomerAccountOwnerCardTypeSelectionDropdown(
                                    width: widget.formCardWidth / 2.5,
                                    menuHeigth: 500.0,
                                    label: 'Type',
                                    providerName: widget
                                        .customerCardTypeSelectionDropdownProvider,
                                    dropdownMenuEntriesLabels: const [],
                                    dropdownMenuEntriesValues: const [],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            showWidget.value = false;
                            ref
                                .read(typeAddedInputsProvider.notifier)
                                .update((state) {
                              // if input is visible, hide it
                              state[widget.index] = showWidget.value;
                              //  debugPrint('typeAddedInputsProvider');
                              //  debugPrint(state.toString());

                              return state;
                            });

                            // remove the selected product from customerAccountOwnerSelectedCardsTypes
                            ref
                                .read(
                                    customerAccountOwnerSelectedCardsTypesProvider
                                        .notifier)
                                .update((state) {
                              // since customerAccountOwnerSelectedCardsTypes use type selection dropdown provider as key
                              state.remove(widget
                                  .customerCardTypeSelectionDropdownProvider);
                              // debugPrint('customerAccountOwnerSelectedCardsTypesProvider');
                              // debugPrint('length: ${state.length}');
                              // debugPrint(state.toString());
                              return state;
                            });
                          },
                          icon: const Icon(
                            Icons.close_rounded,
                            color: CBColors.primaryColor,
                            size: 30.0,
                          ),
                        ),
                      ],
                    );
                  },
                  error: (error, stackTrace) => SizedBox(
                    width: widget.formCardWidth / 2.5,
                  ),
                  loading: () => SizedBox(
                    width: widget.formCardWidth / 2.5,
                  ),
                );
              },
            ),
          )
        : const SizedBox();
  }
}

String generateRandomStringFromDateTimeNowMillis() {
  String millisecondsString = DateTime.now().millisecondsSinceEpoch.toString();
  String result = '';
  Random random = Random();

  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  for (int i = 0; i < millisecondsString.length; i++) {
    result += millisecondsString[i];
    if ((i + 1) % 3 == 0 && i != millisecondsString.length - 1) {
      // add a random letter  after each three letters
      result += characters[random.nextInt(characters.length)];
    }
  }

  return result;
}
