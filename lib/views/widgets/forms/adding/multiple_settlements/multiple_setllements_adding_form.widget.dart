import 'package:communitybank/controllers/forms/on_changed/multiple_settlements/multiple_settlements.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/multiple_settlements/multiple_settlements.validator.dart';
import 'package:communitybank/controllers/forms/validators/settlement/settlement.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/settlements/settlements_crud.function.dart';
import 'package:communitybank/models/data/collection/collection.model.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';

import 'package:communitybank/models/data/type/type.model.dart';
import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/cash/cash_operations/search_options/search_options.widget.dart';
import 'package:communitybank/views/widgets/cash/collections/collections.widgets.dart';
import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards.widgets.dart';
import 'package:communitybank/views/widgets/definitions/types/types_list/types_list.widget.dart';
import 'package:communitybank/views/widgets/forms/adding/multiple_settlements/settlement_number_textformfield/settlement_number_textformfield.widget.dart';
import 'package:communitybank/views/widgets/forms/adding/multiple_settlements/type_dropdown/type_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class MultipleSettlementsAddingForm extends StatefulHookConsumerWidget {
  const MultipleSettlementsAddingForm({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MultipleSettlementsAddingFormState();
}

class _MultipleSettlementsAddingFormState
    extends ConsumerState<MultipleSettlementsAddingForm> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    initializeDateFormatting('fr');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final showValidatedButton = useState<bool>(true);
    final cashOperationsSelectedCustomerAccount =
        ref.watch(cashOperationsSelectedCustomerAccountProvider);
    final formCardWidth =
        cashOperationsSelectedCustomerAccount!.customerCardsIds.length > 1
            ? 1000.0
            : 500.0;
    final settlementCollectionDate =
        ref.watch(settlementCollectionDateProvider);

    final format = DateFormat.yMMMMEEEEd('fr');

    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CBText(
                text: 'Règlements Multiples',
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close_rounded,
                  color: CBColors.primaryColor,
                  size: 30.0,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  width: 500,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CBIconButton(
                        icon: Icons.date_range,
                        text: 'Date de Collecte',
                        onTap: () {
                          FunctionsController.showDateTime(
                            context: context,
                            ref: ref,
                            stateProvider: settlementCollectionDateProvider,
                          );
                        },
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        child: CBText(
                          text: settlementCollectionDate != null
                              ? format.format(settlementCollectionDate)
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
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  width: 500.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CBText(
                        text: 'Montant Collecte Restant: ',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                      settlementCollectionDate != null
                          ? Consumer(
                              builder: (context, ref, child) {
                                final settlementCollector = ref.watch(
                                    cashOperationsSelectedCustomerAccountCollectorProvider);

                                final collectorsCollections =
                                    ref.watch(collectionsListStreamProvider);

                                return collectorsCollections.when(
                                  data: (data) {
                                    // store the collector collection
                                    // that have the same date whith the
                                    // selected settlement date
                                    final collectorCollection = data.firstWhere(
                                      (collection) =>
                                          collection.collectorId ==
                                              settlementCollector!.id! &&
                                          collection.collectedAt.year ==
                                              settlementCollectionDate.year &&
                                          collection.collectedAt.month ==
                                              settlementCollectionDate.month &&
                                          collection.collectedAt.day ==
                                              settlementCollectionDate.day,
                                      orElse: () => Collection(
                                        collectorId: settlementCollector!.id!,
                                        amount: 0,
                                        rest: 0,
                                        agentId: 0,
                                        collectedAt: settlementCollectionDate,
                                        createdAt: DateTime.now(),
                                        updatedAt: DateTime.now(),
                                      ),
                                    );
                                    return CBText(
                                      text:
                                          '${collectorCollection.rest.ceil().toString()}f',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    );
                                  },
                                  error: (error, stackTrace) =>
                                      const CBText(text: ''),
                                  loading: () => const CBText(text: ''),
                                );
                              },
                            )
                          : const CBText(text: ''),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          //  color: Colors.blueGrey,
          padding: const EdgeInsets.all(20.0),
          width: formCardWidth,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    final multipleSettlementsAddedInputs =
                        ref.watch(multipleSettlementsAddedInputsProvider);
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 20.0,
                      ),
                      child: CBIconButton(
                        // limit the number of customer card settlement visible form to exactly the number of customer card
                        onTap: () {
                          int visibleInputs = 0;

                          for (MapEntry multipleSettlementsAddedInputsEntry
                              in multipleSettlementsAddedInputs.entries) {
                            // verify if the input is visible
                            if (multipleSettlementsAddedInputsEntry.value) {
                              ++visibleInputs;
                            }
                          }

                          if (visibleInputs <
                              cashOperationsSelectedCustomerAccount
                                  .customerCardsIds.length) {
                            ref
                                .read(multipleSettlementsAddedInputsProvider
                                    .notifier)
                                .update((state) {
                              return {
                                ...state,
                                DateTime.now().millisecondsSinceEpoch: true,
                              };
                            });
                          }
                        },
                        icon: Icons.add_circle,
                        text: 'Ajouter une carte',
                      ),
                    );
                  },
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final customerCardsSettlemenentCardsMaps = ref.watch(
                      multipleSettlementsAddedInputsProvider,
                    );
                    List<Widget> customerCardsSettlemenentCardsList = [];
                    for (MapEntry mapEntry
                        in customerCardsSettlemenentCardsMaps.entries) {
                      customerCardsSettlemenentCardsList.add(
                        CustomerCardSettlementCard(
                          index: mapEntry.key,
                          isVisible: mapEntry.value,
                          customerCardSettlementTypeDropdownProvider:
                              'multiple-settements-customer-card-${mapEntry.key}',
                        ),
                      );
                    }

                    return Wrap(
                      runSpacing: 5.0,
                      spacing: 5.0,
                      children: customerCardsSettlemenentCardsList,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Consumer(
              builder: (context, ref, child) {
                final multipleSettlementsSelectedTypes =
                    ref.watch(multipleSettlementsSelectedTypesProvider);
                final multipleSettlementsSelectedCustomerCards =
                    ref.watch(multipleSettlementsSelectedCustomerCardsProvider);
                final multipleSettlementsAddedInputs =
                    ref.watch(multipleSettlementsAddedInputsProvider);

                List<Type> selectedTypes = [];
                // check if a type repeated
                for (MapEntry multipleSettlementsSelectedTypesEntry
                    in multipleSettlementsSelectedTypes.entries) {
                  selectedTypes.add(
                    multipleSettlementsSelectedTypesEntry.value,
                  );
                }

                // store customer cards
                List<CustomerCard> selectedCustomerCards = [];

                // store the numbers of settlements
                List<int> settlementsNumbers = [];

                for (MapEntry multipleSettlementsSelectedCustomerCardsEntry
                    in multipleSettlementsSelectedCustomerCards.entries) {
                  selectedCustomerCards.add(
                    multipleSettlementsSelectedCustomerCardsEntry.value,
                  );
                }

                for (MapEntry multipleSettlementsAddedInputsEntry
                    in multipleSettlementsAddedInputs.entries) {
                  // verify if the input is visible
                  if (multipleSettlementsAddedInputsEntry.value) {
                    settlementsNumbers.add(
                      ref.watch(
                        multipleSettlementsSettlementNumberProvider(
                          multipleSettlementsAddedInputsEntry.key,
                        ),
                      ),
                    );
                  }
                }

                int totalAmount = 0;

                for (int i = 0; i < selectedTypes.length; ++i) {
                  totalAmount += (selectedCustomerCards[i].typeNumber *
                          selectedTypes[i].stake *
                          settlementsNumbers[i])
                      .round();
                }

                return CBText(
                  text: 'Montant Total: ${totalAmount}f',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                );
              },
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 170.0,
                  child: CBElevatedButton(
                    text: 'Fermer',
                    backgroundColor: CBColors.sidebarTextColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                showValidatedButton.value
                    ? SizedBox(
                        width: 170.0,
                        child: CBElevatedButton(
                          text: 'Valider',
                          onPressed: () async {
                            SettlementCRUDFunctions.createMultipleSettlements(
                              context: context,
                              formKey: formKey,
                              ref: ref,
                              showValidatedButton: showValidatedButton,
                            );
                          },
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class CustomerCardSettlementCard extends StatefulHookConsumerWidget {
  final int index;
  final bool isVisible;
  final String customerCardSettlementTypeDropdownProvider;
  const CustomerCardSettlementCard({
    super.key,
    required this.index,
    required this.isVisible,
    required this.customerCardSettlementTypeDropdownProvider,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomerCardSettlementCardState();
}

class _CustomerCardSettlementCardState
    extends ConsumerState<CustomerCardSettlementCard> {
  @override
  Widget build(BuildContext context) {
    final showForm = useState<bool>(widget.isVisible);
    final cashOperationsSelectedCustomerAccountOwnerCustomerCards = ref
        .watch(cashOperationsSelectedCustomerAccountOwnerCustomerCardsProvider);
    final cashOperationsSelectedCustomerAccount =
        ref.watch(cashOperationsSelectedCustomerAccountProvider);
    final typesListStream = ref.watch(typesListStreamProvider);

    final selectedCustomerCard = useState<CustomerCard>(
      CustomerCard(
        label: 'Carte *',
        typeId: 0,
        typeNumber: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    final selectedType = ref.watch(
      multipleSettlementsSelectedTypeDropdownProvider(
          widget.customerCardSettlementTypeDropdownProvider),
    );

    final settlementNumber = ref.watch(
      multipleSettlementsSettlementNumberProvider(widget.index),
    );

    return showForm.value
        ? SizedBox(
            width: 500,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          final customerCardsListStream =
                              ref.watch(customersCardsListStreamProvider);
                          final selectedCustomerCardSettlementType = ref.watch(
                            multipleSettlementsSelectedTypeDropdownProvider(
                              widget.customerCardSettlementTypeDropdownProvider,
                            ),
                          );

                          return customerCardsListStream.when(
                            data: (data) {
                              final realTimeCustomerCard = data.firstWhere(
                                (customerCard) =>
                                    cashOperationsSelectedCustomerAccount!
                                        .customerCardsIds
                                        .contains(customerCard.id) &&
                                    customerCard.typeId ==
                                        selectedCustomerCardSettlementType.id,
                                orElse: () => CustomerCard(
                                  label: 'Carte *',
                                  typeId: 0,
                                  typeNumber: 0,
                                  createdAt: DateTime.now(),
                                  updatedAt: DateTime.now(),
                                ),
                              );

                              Future.delayed(
                                const Duration(
                                  milliseconds: 100,
                                ),
                                () {
                                  // this is for calculating and showing
                                  // settlement amount
                                  selectedCustomerCard.value =
                                      realTimeCustomerCard;

                                  // store customer card in
                                  // multipleSettlementsSelectedCustomerCards
                                  // like selected type are stored

                                  ref
                                      .read(
                                          multipleSettlementsSelectedCustomerCardsProvider
                                              .notifier)
                                      .update((state) {
                                    state[widget
                                            .customerCardSettlementTypeDropdownProvider] =
                                        realTimeCustomerCard;
                                    return state;
                                  });
                                },
                              );

                              return CustomerCardWidget(
                                customerCard: realTimeCustomerCard,
                              );
                            },
                            error: (error, stackTrace) => CustomerCardWidget(
                              customerCard: CustomerCard(
                                label: 'Carte *',
                                typeId: 0,
                                typeNumber: 0,
                                createdAt: DateTime.now(),
                                updatedAt: DateTime.now(),
                              ),
                            ),
                            loading: () => CustomerCardWidget(
                              customerCard: CustomerCard(
                                label: 'Carte *',
                                typeId: 0,
                                typeNumber: 0,
                                createdAt: DateTime.now(),
                                updatedAt: DateTime.now(),
                              ),
                            ),
                          );
                        },
                      ),
                      CBMultipleSettlementsCustomerCardTypeDropdown(
                        label: 'Type',
                        providerName:
                            widget.customerCardSettlementTypeDropdownProvider,
                        dropdownMenuEntriesLabels: typesListStream.when(
                          data: (data) => data.where((type) {
                            // get all only customers cards types and unselected types for multiple settlements card
                            return cashOperationsSelectedCustomerAccountOwnerCustomerCards
                                .any(
                              (customerCard) =>
                                  customerCard.satisfiedAt == null &&
                                  customerCard.repaidAt == null &&
                                  customerCard.transferredAt == null &&
                                  customerCard.typeId == type.id,
                            );
                          } /* &&
                                    !multipleSettlementsSelectedTypes
                                        .containsValue(type),*/
                              ).toList(),
                          error: (errror, stackTrace) => [],
                          loading: () => [],
                        ),
                        dropdownMenuEntriesValues: typesListStream.when(
                          data: (data) => data
                              .where((type) =>
                                      // get all only customers cards types and unselected types for multiple settlements card
                                      cashOperationsSelectedCustomerAccountOwnerCustomerCards
                                          .any(
                                        (customerCard) =>
                                            customerCard.satisfiedAt == null &&
                                            customerCard.repaidAt == null &&
                                            customerCard.transferredAt ==
                                                null &&
                                            customerCard.typeId == type.id,
                                      )
                                  /* &&
                                    !multipleSettlementsSelectedTypes
                                        .containsValue(type),*/
                                  )
                              .toList(),
                          error: (errror, stackTrace) => [],
                          loading: () => [],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showForm.value = false;

                          ref
                              .read(multipleSettlementsAddedInputsProvider
                                  .notifier)
                              .update(
                            (state) {
                              // if input is visible, hide it
                              state[widget.index] = showForm.value;

                              return state;
                            },
                          );

                          // remove the selected type from multipleSettlementsSelectedTypes

                          ref
                              .read(
                            multipleSettlementsSelectedTypesProvider.notifier,
                          )
                              .update(
                            (state) {
                              // since typeSelectedProducts use type selection
                              // dropdown provider as key
                              state.remove(
                                widget
                                    .customerCardSettlementTypeDropdownProvider,
                              );

                              return state;
                            },
                          );

                          // remove the selected customer card from multipleSettlementsSelectedCustomerCards

                          // customer cards and types used the same mapEntry.key
                          ref
                              .read(
                                  multipleSettlementsSelectedCustomerCardsProvider
                                      .notifier)
                              .update((state) {
                            state.remove(widget
                                .customerCardSettlementTypeDropdownProvider);
                            return state;
                          });
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 30.0,
                          color: CBColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      width: 500,
                      child: CBMultipleSettementsSettlementNumberTextFormField(
                        inputIndex: widget.index,
                        label: 'Nombre',
                        hintText: 'Nombre',
                        textInputType: TextInputType.number,
                        validator: MultipleSettlementsValidators
                            .multipleSettlementsSettlementNumber,
                        onChanged: MultipleSttlementsOnChanged
                            .multipleSettlementsSettlementNumber,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 5.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const CBText(
                            text: 'Montant: ',
                            fontSize: 12,
                          ),
                          CBText(
                            text:
                                '${selectedCustomerCard.value.typeNumber * selectedType.stake.ceil() * settlementNumber}f',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        : const SizedBox();
  }
}

class CustomerCardWidget extends ConsumerWidget {
  final CustomerCard customerCard;
  const CustomerCardWidget({
    super.key,
    required this.customerCard,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 7.0,
      color: CBColors.primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 15.0,
        ),
        child: Consumer(
          builder: (context, ref, child) {
            final customersCardsListStream =
                ref.watch(customersCardsListStreamProvider);

            return customersCardsListStream.when(
              data: (data) {
                /* String customerCardLabel = '';

                    for (CustomerCard customerCard in data) {
                      if (customerCard.id ==
                          cashOperationsSelectedCustomerAccountOwnerSelectedCard
                              .id) {
                        customerCardLabel = customerCard.label;
                      }
                    }*/

                final realTimeCustomerCard = data.firstWhere(
                  (realTimeCustomerCard) =>
                      customerCard.id == realTimeCustomerCard.id,
                  orElse: () => CustomerCard(
                    label: '',
                    typeId: 0,
                    typeNumber: 0,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  ),
                );

                return CBText(
                  text: realTimeCustomerCard.label,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                );
              },
              error: (error, stackTrace) => CBText(
                text: customerCard.label,

                // sidebarSubOptionData.name
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              loading: () => const CBText(
                text: '',

                // sidebarSubOptionData.name
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}
