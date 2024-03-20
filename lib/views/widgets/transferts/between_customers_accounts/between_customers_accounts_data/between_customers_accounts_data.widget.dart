// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/settlements/settlements.controller.dart';
import 'package:communitybank/functions/crud/transfers/transfers_crud.function.dart';
import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/models/data/settlement/settlement.model.dart';
import 'package:communitybank/models/data/type/type.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards_list/customers_cards_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/types/types_list/types_list.widget.dart';
import 'package:communitybank/views/widgets/globals/elevated_button/elevated_button.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:communitybank/views/widgets/transferts/between_customers_accounts/type_dropdown/type_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final transfersBetweenCustomerCardsSelectedCustomerAccountProvider =
    StateProvider<CustomerAccount?>((ref) {
  return;
});

final transfersBetweenCustomerCardsSelectedCustomerCardsProvider =
    StateProvider<List<CustomerCard>>((ref) {
  return [];
});

final transfersBetweenCustomerCardSelectedIssuingCustomerCardProvider =
    StateProvider<CustomerCard?>((ref) {
  return;
});

final transfersBetweenCustomerCardSelectedIssuingCustomerCardTypeProvider =
    StateProvider<Type?>((ref) {
  return;
});

final transfersBetweenCustomerCardSelectedReceivingCustomerCardProvider =
    StateProvider<CustomerCard?>((ref) {
  return;
});

final transfersBetweenCustomerCardSelectedReceivingCustomerCardTypeProvider =
    StateProvider<Type?>((ref) {
  return;
});

final settlementsProvider = StreamProvider<List<Settlement>>((ref) async* {
  yield* SettlementsController.getAll(
    customerCardId: 0,
  );
});

final transfersBetweenCustomerCardIssuingCustomerCardSettlementsNumbersTotalProvider =
    StateProvider<int>((ref) {
  return 0;
});

final transfersBetweenCustomerCardReceivingCustomerCardSettlementsNumbersTotalProvider =
    StateProvider<int>((ref) {
  return 0;
});

class TransfersBetweenCustomersAccountsData extends StatefulHookConsumerWidget {
  const TransfersBetweenCustomersAccountsData({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransfersBetweenCustomersAccountsDataState();
}

class _TransfersBetweenCustomersAccountsDataState
    extends ConsumerState<TransfersBetweenCustomersAccountsData> {
  @override
  Widget build(BuildContext context) {
    final enableTransferButton = useState<bool>(true);
    final customersCardsListStream =
        ref.watch(customersCardsListStreamProvider);
    final typeListStream = ref.watch(typesListStreamProvider);

    final transfersBetweenCustomerCardsSelectedCustomerCards =
        ref.watch(transfersBetweenCustomerCardsSelectedCustomerCardsProvider);

    final transfersBetweenCustomerCardSelectedIssuingCustomerCard = ref
        .watch(transfersBetweenCustomerCardSelectedIssuingCustomerCardProvider);

    final transfersBetweenCustomerCardSelectedIssuingCustomerCardType =
        ref.watch(
            transfersBetweenCustomerCardSelectedIssuingCustomerCardTypeProvider);

    final transfersBetweenCustomerCardSelectedReceivingCustomerCard = ref.watch(
        transfersBetweenCustomerCardSelectedReceivingCustomerCardProvider);

    final transfersBetweenCustomerCardSelectedReceivingCustomerCardType =
        ref.watch(
            transfersBetweenCustomerCardSelectedReceivingCustomerCardTypeProvider);

    final issuingCustomerCardSettlementsNumbersTotal = ref.watch(
      transfersBetweenCustomerCardIssuingCustomerCardSettlementsNumbersTotalProvider,
    );
    final receivingCustomerCardSettlementsNumbersTotal = ref.watch(
      transfersBetweenCustomerCardReceivingCustomerCardSettlementsNumbersTotalProvider,
    );

    ref.listen(
      transfersBetweenCustomerCardsSelectedCustomerAccountProvider,
      (previous, next) {
        Future.delayed(
          const Duration(
            milliseconds: 100,
          ),
          () {
            // reset providers for avoiding showing previous customer cards data
            ref.invalidate(
              transfersTypeDropdownProvider(
                'transfers-between-customer-cards-issuing-card-type',
              ),
            );
            ref.invalidate(
              transfersTypeDropdownProvider(
                'transfers-between-customer-cards-receiving-card-type',
              ),
            );
            ref.invalidate(
              transfersBetweenCustomerCardSelectedIssuingCustomerCardProvider,
            );
            ref.invalidate(
              transfersBetweenCustomerCardSelectedIssuingCustomerCardTypeProvider,
            );
            ref.invalidate(
              transfersBetweenCustomerCardSelectedReceivingCustomerCardProvider,
            );
            ref.invalidate(
              transfersBetweenCustomerCardSelectedReceivingCustomerCardTypeProvider,
            );
            ref.invalidate(
              transfersBetweenCustomerCardIssuingCustomerCardSettlementsNumbersTotalProvider,
            );

            ref.invalidate(
              transfersBetweenCustomerCardReceivingCustomerCardSettlementsNumbersTotalProvider,
            );

            customersCardsListStream.when(
              data: (data) {
                final customerCards = data
                    .where(
                      (customerCard) =>
                          // stored only usable customerCards
                          customerCard.repaidAt == null &&
                          customerCard.satisfiedAt == null &&
                          customerCard.transferredAt == null &&
                          next!.customerCardsIds.contains(customerCard.id),
                    )
                    .toList();
                // update account owner cards list
                ref
                    .read(
                      transfersBetweenCustomerCardsSelectedCustomerCardsProvider
                          .notifier,
                    )
                    .state = customerCards;
              },
              error: (error, stackTrace) {},
              loading: () {},
            );
          },
        );
      },
    );

    // update issuing card and type
    ref.listen(
      transfersTypeDropdownProvider(
        'transfers-between-customer-cards-issuing-card-type',
      ),
      (previous, next) {
        Future.delayed(
          const Duration(
            milliseconds: 100,
          ),
          () {
            // update issuingCustomerCardType
            ref
                .read(
                  transfersBetweenCustomerCardSelectedIssuingCustomerCardTypeProvider
                      .notifier,
                )
                .state = next;

            final issuingCustomerCard =
                transfersBetweenCustomerCardsSelectedCustomerCards.firstWhere(
              (customerCard) => customerCard.typeId == next.id,
              orElse: () => CustomerCard(
                label: 'Carte *',
                typeId: 1,
                typeNumber: 1,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
            );

            // update issuingCustomerCard
            ref
                .read(
                  transfersBetweenCustomerCardSelectedIssuingCustomerCardProvider
                      .notifier,
                )
                .state = issuingCustomerCard;
          },
        );
      },
    );

    // update receiving card and type
    ref.listen(
      transfersTypeDropdownProvider(
        'transfers-between-customer-cards-receiving-card-type',
      ),
      (previous, next) {
        Future.delayed(
          const Duration(
            milliseconds: 100,
          ),
          () {
            // update receivingCustomerCardType
            ref
                .read(
                  transfersBetweenCustomerCardSelectedReceivingCustomerCardTypeProvider
                      .notifier,
                )
                .state = next;

            final receivingCustomerCard =
                transfersBetweenCustomerCardsSelectedCustomerCards.firstWhere(
              (customerCard) => customerCard.typeId == next.id,
              orElse: () => CustomerCard(
                label: 'Carte *',
                typeId: 1,
                typeNumber: 1,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
            );

            // update receivingCustomerCard
            ref
                .read(
                  transfersBetweenCustomerCardSelectedReceivingCustomerCardProvider
                      .notifier,
                )
                .state = receivingCustomerCard;
          },
        );
      },
    );

// listening to issuing customer card
    ref.listen(transfersBetweenCustomerCardSelectedIssuingCustomerCardProvider,
        (previous, next) {
      Future.delayed(
          const Duration(
            milliseconds: 100,
          ), () async {
        if (next != null) {
          final issuingCustomerCardSettlements =
              await SettlementsController.getAll(
            customerCardId: next.id ?? 1000000000000000000,
          ).first;

          int settlementsNumbersTotal = 0;
          for (Settlement settlement in issuingCustomerCardSettlements) {
            settlementsNumbersTotal += settlement.number;
          }
          ref
              .read(
                transfersBetweenCustomerCardIssuingCustomerCardSettlementsNumbersTotalProvider
                    .notifier,
              )
              .state = settlementsNumbersTotal;
        }
      });
    });

// listening to receiving customer card
    ref.listen(
        transfersBetweenCustomerCardSelectedReceivingCustomerCardProvider,
        (previous, next) {
      Future.delayed(
        const Duration(
          milliseconds: 100,
        ),
        () async {
          if (next != null) {
            final receivingCustomerCardSettlements =
                await SettlementsController.getAll(
              customerCardId: next.id ?? 1000000000000000000,
            ).first;

            int settlementsNumbersTotal = 0;
            for (Settlement settlement in receivingCustomerCardSettlements) {
              settlementsNumbersTotal += settlement.number;
            }
            ref
                .read(
                  transfersBetweenCustomerCardReceivingCustomerCardSettlementsNumbersTotalProvider
                      .notifier,
                )
                .state = settlementsNumbersTotal;
          }
        },
      );
    });

    // listening to settlements stream for updating setlements data for each card
    ref.listen(settlementsProvider, (previous, next) {
      // issuing customer card settlements
      if (transfersBetweenCustomerCardSelectedIssuingCustomerCard != null &&
          transfersBetweenCustomerCardSelectedIssuingCustomerCard.id != null) {
        Future.delayed(
            const Duration(
              milliseconds: 100,
            ), () async {
          final issuingCustomerCardSettlements =
              await SettlementsController.getAll(
            customerCardId:
                transfersBetweenCustomerCardSelectedIssuingCustomerCard.id,
          ).first;

          int settlementsNumbersTotal = 0;
          for (Settlement settlement in issuingCustomerCardSettlements) {
            settlementsNumbersTotal += settlement.number;
          }
          ref
              .read(
                transfersBetweenCustomerCardIssuingCustomerCardSettlementsNumbersTotalProvider
                    .notifier,
              )
              .state = settlementsNumbersTotal;
        });
      }

// receiving customer card settlements
      if (transfersBetweenCustomerCardSelectedReceivingCustomerCard != null &&
          transfersBetweenCustomerCardSelectedReceivingCustomerCard.id !=
              null) {
        Future.delayed(
            const Duration(
              milliseconds: 100,
            ), () async {
          final receivingCustomerCardSettlements =
              await SettlementsController.getAll(
            customerCardId:
                transfersBetweenCustomerCardSelectedReceivingCustomerCard.id,
          ).first;

          int settlementsNumbersTotal = 0;
          for (Settlement settlement in receivingCustomerCardSettlements) {
            settlementsNumbersTotal += settlement.number;
          }
          ref
              .read(
                transfersBetweenCustomerCardReceivingCustomerCardSettlementsNumbersTotalProvider
                    .notifier,
              )
              .state = settlementsNumbersTotal;
        });
      }
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 50.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 25.0,
                ),
                padding: const EdgeInsetsDirectional.all(
                  15.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: CBColors.sidebarTextColor,
                    width: .5,
                  ),
                  borderRadius: BorderRadius.circular(
                    15.0,
                  ),
                ),
                width: 500.0,
                child: Column(
                  children: [
                    const CBText(
                      text: 'Compte Émetteur',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            final issuingCustomerCardType = ref.watch(
                              transfersTypeDropdownProvider(
                                'transfers-between-customer-cards-issuing-card-type',
                              ),
                            );

                            final issuingCustomerCard =
                                transfersBetweenCustomerCardsSelectedCustomerCards
                                    .firstWhere(
                              (customerCard) =>
                                  customerCard.typeId ==
                                  issuingCustomerCardType.id,
                              orElse: () => CustomerCard(
                                label: 'Carte *',
                                typeId: 1,
                                typeNumber: 1,
                                createdAt: DateTime.now(),
                                updatedAt: DateTime.now(),
                              ),
                            );

                            return CustomerCardWidget(
                              customerCard: issuingCustomerCard,
                            );
                          },
                        ),
                        CBTransfersTypeDropdown(
                          label: 'Type',
                          width: 150,
                          menuHeigth: 300.0,
                          providerName:
                              'transfers-between-customer-cards-issuing-card-type',
                          dropdownMenuEntriesLabels: typeListStream.when(
                            data: (data) => data
                                .where(
                                  (type) =>
                                      transfersBetweenCustomerCardsSelectedCustomerCards
                                          .any(
                                    (customerCard) =>
                                        customerCard.typeId == type.id,
                                  ),
                                )
                                .toList(),
                            error: (error, stackTrace) => [],
                            loading: () => [],
                          ),
                          dropdownMenuEntriesValues: typeListStream.when(
                            data: (data) => data
                                .where(
                                  (type) =>
                                      transfersBetweenCustomerCardsSelectedCustomerCards
                                          .any(
                                    (customerCard) =>
                                        customerCard.typeId == type.id,
                                  ),
                                )
                                .toList(),
                            error: (error, stackTrace) => [],
                            loading: () => [],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 25.0,
                      ),
                      child: StaggeredGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5.0,
                        //  crossAxisSpacing: ,
                        children: [
                          OtherInfos(
                            label: 'Nombre Type',
                            value: transfersBetweenCustomerCardSelectedIssuingCustomerCard !=
                                        null &&
                                    transfersBetweenCustomerCardSelectedIssuingCustomerCard
                                            .id !=
                                        null
                                ? transfersBetweenCustomerCardSelectedIssuingCustomerCard
                                    .typeNumber
                                    .toString()
                                : '',
                          ),
                          OtherInfos(
                            label: 'Mise Type',
                            value: transfersBetweenCustomerCardSelectedIssuingCustomerCardType !=
                                        null &&
                                    transfersBetweenCustomerCardSelectedIssuingCustomerCardType
                                            .id !=
                                        null
                                ? '${transfersBetweenCustomerCardSelectedIssuingCustomerCardType.stake.toInt()}'
                                : '',
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              return OtherInfos(
                                label: 'Total Règlements',
                                value: transfersBetweenCustomerCardSelectedIssuingCustomerCardType !=
                                        null
                                    ? issuingCustomerCardSettlementsNumbersTotal
                                        .toString()
                                    : '',
                              );
                            },
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              final amount = transfersBetweenCustomerCardSelectedIssuingCustomerCard !=
                                          null &&
                                      transfersBetweenCustomerCardSelectedIssuingCustomerCardType !=
                                          null
                                  ? (transfersBetweenCustomerCardSelectedIssuingCustomerCard
                                              .typeNumber *
                                          transfersBetweenCustomerCardSelectedIssuingCustomerCardType
                                              .stake *
                                          issuingCustomerCardSettlementsNumbersTotal)
                                      .round()
                                  : 0;
                              return OtherInfos(
                                label: 'Montant Réglé',
                                value: transfersBetweenCustomerCardSelectedIssuingCustomerCard !=
                                            null &&
                                        transfersBetweenCustomerCardSelectedIssuingCustomerCardType !=
                                            null
                                    ? amount > 0
                                        ? '${amount}f'
                                        : '0f'
                                    : '',
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CBText(
                          text: 'Montant à transférer: ',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        // the amount to transfer is equal to customer card total amount *2/3 - 300. 300 for customerCard fee
                        Consumer(
                          builder: (context, ref, child) {
                            final amount = transfersBetweenCustomerCardSelectedIssuingCustomerCard != null &&
                                    transfersBetweenCustomerCardSelectedIssuingCustomerCard
                                            .id !=
                                        null &&
                                    transfersBetweenCustomerCardSelectedIssuingCustomerCardType !=
                                        null
                                ? (2 *
                                            (transfersBetweenCustomerCardSelectedIssuingCustomerCard
                                                    .typeNumber *
                                                transfersBetweenCustomerCardSelectedIssuingCustomerCardType
                                                    .stake *
                                                issuingCustomerCardSettlementsNumbersTotal) /
                                            3 -
                                        300)
                                    .round()
                                : 0;
                            return CBText(
                              text: transfersBetweenCustomerCardSelectedIssuingCustomerCard !=
                                          null &&
                                      transfersBetweenCustomerCardSelectedIssuingCustomerCardType !=
                                          null
                                  ? amount > 0
                                      ? '${amount}f'
                                      : '0f'
                                  : '',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            );
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 25.0,
                ),
                padding: const EdgeInsetsDirectional.all(
                  15.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: CBColors.sidebarTextColor,
                    width: .5,
                  ),
                  borderRadius: BorderRadius.circular(
                    15.0,
                  ),
                ),
                width: 500.0,
                child: Column(
                  children: [
                    const CBText(
                      text: 'Compte Récepteur',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            final receivingCustomerCardType = ref.watch(
                              transfersTypeDropdownProvider(
                                'transfers-between-customer-cards-receiving-card-type',
                              ),
                            );
                            final receivingCustomerCard =
                                transfersBetweenCustomerCardsSelectedCustomerCards
                                    .firstWhere(
                              (customerCard) =>
                                  customerCard.typeId ==
                                  receivingCustomerCardType.id,
                              orElse: () => CustomerCard(
                                label: 'Carte *',
                                typeId: 1,
                                typeNumber: 1,
                                createdAt: DateTime.now(),
                                updatedAt: DateTime.now(),
                              ),
                            );

                            return CustomerCardWidget(
                              customerCard: receivingCustomerCard,
                            );
                          },
                        ),
                        CBTransfersTypeDropdown(
                          label: 'Type',
                          width: 150,
                          menuHeigth: 300.0,
                          providerName:
                              'transfers-between-customer-cards-receiving-card-type',
                          dropdownMenuEntriesLabels: typeListStream.when(
                            data: (data) => data
                                .where(
                                  (type) =>
                                      transfersBetweenCustomerCardsSelectedCustomerCards
                                          .any(
                                    (customerCard) =>
                                        customerCard.typeId == type.id,
                                  ),
                                )
                                .toList(),
                            error: (error, stackTrace) => [],
                            loading: () => [],
                          ),
                          dropdownMenuEntriesValues: typeListStream.when(
                            data: (data) => data
                                .where(
                                  (type) =>
                                      transfersBetweenCustomerCardsSelectedCustomerCards
                                          .any(
                                    (customerCard) =>
                                        customerCard.typeId == type.id,
                                  ),
                                )
                                .toList(),
                            error: (error, stackTrace) => [],
                            loading: () => [],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 25.0,
                      ),
                      child: StaggeredGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5.0,
                        //  crossAxisSpacing: ,
                        children: [
                          OtherInfos(
                            label: 'Nombre Type',
                            value: transfersBetweenCustomerCardSelectedReceivingCustomerCard !=
                                        null &&
                                    transfersBetweenCustomerCardSelectedReceivingCustomerCard
                                            .id !=
                                        null
                                ? transfersBetweenCustomerCardSelectedReceivingCustomerCard
                                    .typeNumber
                                    .toString()
                                : '',
                          ),
                          OtherInfos(
                            label: 'Mise Type',
                            value: transfersBetweenCustomerCardSelectedReceivingCustomerCardType !=
                                        null &&
                                    transfersBetweenCustomerCardSelectedReceivingCustomerCardType
                                            .id !=
                                        null
                                ? '${transfersBetweenCustomerCardSelectedReceivingCustomerCardType.stake.ceil()}'
                                : '',
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              return OtherInfos(
                                label: 'Total Règlements',
                                value: transfersBetweenCustomerCardSelectedReceivingCustomerCardType !=
                                        null
                                    ? receivingCustomerCardSettlementsNumbersTotal
                                        .toString()
                                    : '',
                              );
                            },
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              final amount = transfersBetweenCustomerCardSelectedReceivingCustomerCard !=
                                          null &&
                                      transfersBetweenCustomerCardSelectedReceivingCustomerCardType !=
                                          null
                                  ? (transfersBetweenCustomerCardSelectedReceivingCustomerCard
                                              .typeNumber *
                                          transfersBetweenCustomerCardSelectedReceivingCustomerCardType
                                              .stake *
                                          receivingCustomerCardSettlementsNumbersTotal)
                                      .ceil()
                                  : 0;
                              return OtherInfos(
                                label: 'Montant Réglé',
                                value: transfersBetweenCustomerCardSelectedReceivingCustomerCard !=
                                            null &&
                                        transfersBetweenCustomerCardSelectedReceivingCustomerCardType !=
                                            null
                                    ? amount > 0
                                        ? '${amount}f'
                                        : '0f'
                                    : '',
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CBText(
                          text: 'Règlements à recevoir: ',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        // the number of settlements to receive is equal to the amount to receive / receiving card type stake (round)
                        Consumer(
                          builder: (context, ref, child) {
                            final settlementNumber = transfersBetweenCustomerCardSelectedIssuingCustomerCard != null &&
                                    transfersBetweenCustomerCardSelectedIssuingCustomerCard
                                            .id !=
                                        null &&
                                    transfersBetweenCustomerCardSelectedIssuingCustomerCardType !=
                                        null &&
                                    transfersBetweenCustomerCardSelectedReceivingCustomerCard !=
                                        null &&
                                    transfersBetweenCustomerCardSelectedReceivingCustomerCard
                                            .id !=
                                        null &&
                                    transfersBetweenCustomerCardSelectedReceivingCustomerCardType !=
                                        null
                                ? ((2 *
                                                (transfersBetweenCustomerCardSelectedIssuingCustomerCard
                                                        .typeNumber *
                                                    transfersBetweenCustomerCardSelectedIssuingCustomerCardType
                                                        .stake *
                                                    issuingCustomerCardSettlementsNumbersTotal) /
                                                3 -
                                            300) /
                                        transfersBetweenCustomerCardSelectedReceivingCustomerCardType
                                            .stake)
                                    .round()
                                : 0;
                            return CBText(
                              text: transfersBetweenCustomerCardSelectedIssuingCustomerCard != null &&
                                      transfersBetweenCustomerCardSelectedIssuingCustomerCardType !=
                                          null &&
                                      transfersBetweenCustomerCardSelectedReceivingCustomerCard !=
                                          null &&
                                      transfersBetweenCustomerCardSelectedReceivingCustomerCardType !=
                                          null
                                  ? settlementNumber > 0
                                      ? settlementNumber.toString()
                                      : '0'
                                  : '',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            );
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        /*   const SizedBox(
          height: 100.0,
        ),*/
        SizedBox(
          width: 500.0,
          child: CBElevatedButton(
            text: enableTransferButton.value
                ? "Transférer"
                : "Veuillez patienter",
            onPressed: () async {
              enableTransferButton.value
                  ? await TransferCRUDFunctions.create(
                      context: context,
                      ref: ref,
                      enableTransferButton: enableTransferButton,
                    )
                  : () {};
            },
          ),
        ),
      ],
    );
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
                    label: 'Carte *',
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

class OtherInfos extends ConsumerWidget {
  final String label;
  final String value;
  const OtherInfos({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      //  width: 240.0,
      child: Row(
        children: [
          CBText(
            text: '$label: ',
            fontSize: 10,
            //  fontWeight: FontWeight.w500,
          ),
          CBText(
            text: value,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }
}
