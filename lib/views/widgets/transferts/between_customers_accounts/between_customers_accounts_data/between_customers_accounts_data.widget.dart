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
import 'package:communitybank/views/widgets/transferts/between_customers_accounts/customer_account_dropdown/customer_account_dropdown.widget.dart';
import 'package:communitybank/views/widgets/transferts/between_customers_accounts/type_dropdown/type_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final transfersBetweenCustomersAccountsSelectedIssuingCustomerAccountProvider =
    StateProvider<CustomerAccount?>((ref) {
  return;
});

final transfersBetweenCustomersAccountsSelectedReceivingCustomerAccountProvider =
    StateProvider<CustomerAccount?>((ref) {
  return;
});

final transfersBetweenCustomersAccountsSelectedIssuingCustomerCardsProvider =
    StateProvider<List<CustomerCard>>((ref) {
  return [];
});

final transfersBetweenCustomersAccountsSelectedReceivingCustomerCardsProvider =
    StateProvider<List<CustomerCard>>((ref) {
  return [];
});

final transfersBetweenCustomersAccountsSelectedIssuingCustomerCardProvider =
    StateProvider<CustomerCard?>((ref) {
  return;
});

final transfersBetweenCustomersAccountsSelectedIssuingCustomerCardTypeProvider =
    StateProvider<Type?>((ref) {
  return;
});

final transfersBetweenCustomersAccountsSelectedReceivingCustomerCardProvider =
    StateProvider<CustomerCard?>((ref) {
  return;
});

final transfersBetweenCustomersAccountsSelectedReceivingCustomerCardTypeProvider =
    StateProvider<Type?>((ref) {
  return;
});

final settlementsProvider = StreamProvider<List<Settlement>>((ref) async* {
  yield* SettlementsController.getAll(
    customerCardId: 0,
  );
});

final transfersBetweenCustomersAccountIssuingCustomerCardSettlementsNumbersTotalProvider =
    StateProvider<int>((ref) {
  return 0;
});

final transfersBetweenCustomersAccountReceivingCustomerCardSettlementsNumbersTotalProvider =
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

    final transfersBetweenCustomersAccountsSelectedIssuingCustomerCards =
        ref.watch(
            transfersBetweenCustomersAccountsSelectedIssuingCustomerCardsProvider);

    final transfersBetweenCustomersAccountsSelectedReceivingCustomerCards =
        ref.watch(
            transfersBetweenCustomersAccountsSelectedReceivingCustomerCardsProvider);

    final transfersBetweenCustomersAccountsSelectedIssuingCustomerCard =
        ref.watch(
            transfersBetweenCustomersAccountsSelectedIssuingCustomerCardProvider);

    final transfersBetweenCustomersAccountsSelectedIssuingCustomerCardType =
        ref.watch(
            transfersBetweenCustomersAccountsSelectedIssuingCustomerCardTypeProvider);

    final transfersBetweenCustomersAccountsSelectedReceivingCustomerCard =
        ref.watch(
            transfersBetweenCustomersAccountsSelectedReceivingCustomerCardProvider);

    final transfersBetweenCustomersAccountsSelectedReceivingCustomerCardType =
        ref.watch(
            transfersBetweenCustomersAccountsSelectedReceivingCustomerCardTypeProvider);

    final issuingCustomerCardSettlementsNumbersTotal = ref.watch(
      transfersBetweenCustomersAccountIssuingCustomerCardSettlementsNumbersTotalProvider,
    );
    final receivingCustomerCardSettlementsNumbersTotal = ref.watch(
      transfersBetweenCustomersAccountReceivingCustomerCardSettlementsNumbersTotalProvider,
    );

    // listen to issuing customer dropdown provider
    ref.listen(
      transfersBetweenCustomersAccountsCustomerAccountDropdownProvider(
          'transfer-between-customers-accounts-issuing-customer-account'),
      (previous, next) {
        Future.delayed(
          const Duration(
            milliseconds: 100,
          ),
          () {
            ref
                .read(
                  transfersBetweenCustomersAccountsSelectedIssuingCustomerAccountProvider
                      .notifier,
                )
                .state = next;
          },
        );
      },
    );

    // listen to receiving customer dropdown provider
    ref.listen(
      transfersBetweenCustomersAccountsCustomerAccountDropdownProvider(
          'transfer-between-customers-accounts-receiving-customer-account'),
      (previous, next) {
        Future.delayed(
          const Duration(
            milliseconds: 100,
          ),
          () {
            ref
                .read(
                  transfersBetweenCustomersAccountsSelectedReceivingCustomerAccountProvider
                      .notifier,
                )
                .state = next;
          },
        );
      },
    );

    // issuing customer account listener
    ref.listen(
      transfersBetweenCustomersAccountsSelectedIssuingCustomerAccountProvider,
      (previous, next) {
        Future.delayed(
          const Duration(
            milliseconds: 100,
          ),
          () {
            // reset providers for avoiding showing previous customer cards data
            ref.invalidate(
              transfersTypeDropdownProvider(
                'transfers-between-customers-accounts-issuing-card-type',
              ),
            );
            ref.invalidate(
              transfersBetweenCustomersAccountsSelectedIssuingCustomerCardProvider,
            );
            ref.invalidate(
              transfersBetweenCustomersAccountsSelectedIssuingCustomerCardTypeProvider,
            );

            ref.invalidate(
              transfersBetweenCustomersAccountIssuingCustomerCardSettlementsNumbersTotalProvider,
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
                      transfersBetweenCustomersAccountsSelectedIssuingCustomerCardsProvider
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

// receiving customer account listener
    ref.listen(
      transfersBetweenCustomersAccountsSelectedReceivingCustomerAccountProvider,
      (previous, next) {
        Future.delayed(
          const Duration(
            milliseconds: 100,
          ),
          () {
            // reset providers for avoiding showing previous customer cards data
            ref.invalidate(
              transfersTypeDropdownProvider(
                'transfers-between-customers-accounts-receiving-card-type',
              ),
            );

            ref.invalidate(
              transfersBetweenCustomersAccountsSelectedReceivingCustomerCardProvider,
            );
            ref.invalidate(
              transfersBetweenCustomersAccountsSelectedReceivingCustomerCardTypeProvider,
            );
            ref.invalidate(
              transfersBetweenCustomersAccountReceivingCustomerCardSettlementsNumbersTotalProvider,
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
                      transfersBetweenCustomersAccountsSelectedReceivingCustomerCardsProvider
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
        'transfers-between-customers-accounts-issuing-card-type',
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
                  transfersBetweenCustomersAccountsSelectedIssuingCustomerCardTypeProvider
                      .notifier,
                )
                .state = next;

            final issuingCustomerCard =
                transfersBetweenCustomersAccountsSelectedIssuingCustomerCards
                    .firstWhere(
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
                  transfersBetweenCustomersAccountsSelectedIssuingCustomerCardProvider
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
        'transfers-between-customers-accounts-receiving-card-type',
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
                  transfersBetweenCustomersAccountsSelectedReceivingCustomerCardTypeProvider
                      .notifier,
                )
                .state = next;

            final receivingCustomerCard =
                transfersBetweenCustomersAccountsSelectedReceivingCustomerCards
                    .firstWhere(
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
                  transfersBetweenCustomersAccountsSelectedReceivingCustomerCardProvider
                      .notifier,
                )
                .state = receivingCustomerCard;
          },
        );
      },
    );

// listening to issuing customer card
    ref.listen(
        transfersBetweenCustomersAccountsSelectedIssuingCustomerCardProvider,
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
                transfersBetweenCustomersAccountIssuingCustomerCardSettlementsNumbersTotalProvider
                    .notifier,
              )
              .state = settlementsNumbersTotal;
        }
      });
    });

// listening to receiving customer card
    ref.listen(
        transfersBetweenCustomersAccountsSelectedReceivingCustomerCardProvider,
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
                  transfersBetweenCustomersAccountReceivingCustomerCardSettlementsNumbersTotalProvider
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
      if (transfersBetweenCustomersAccountsSelectedIssuingCustomerCard !=
              null &&
          transfersBetweenCustomersAccountsSelectedIssuingCustomerCard.id !=
              null) {
        Future.delayed(
            const Duration(
              milliseconds: 100,
            ), () async {
          final issuingCustomerCardSettlements =
              await SettlementsController.getAll(
            customerCardId:
                transfersBetweenCustomersAccountsSelectedIssuingCustomerCard.id,
          ).first;

          int settlementsNumbersTotal = 0;
          for (Settlement settlement in issuingCustomerCardSettlements) {
            settlementsNumbersTotal += settlement.number;
          }
          ref
              .read(
                transfersBetweenCustomersAccountIssuingCustomerCardSettlementsNumbersTotalProvider
                    .notifier,
              )
              .state = settlementsNumbersTotal;
        });
      }

// receiving customer card settlements
      if (transfersBetweenCustomersAccountsSelectedReceivingCustomerCard !=
              null &&
          transfersBetweenCustomersAccountsSelectedReceivingCustomerCard.id !=
              null) {
        Future.delayed(
            const Duration(
              milliseconds: 100,
            ), () async {
          final receivingCustomerCardSettlements =
              await SettlementsController.getAll(
            customerCardId:
                transfersBetweenCustomersAccountsSelectedReceivingCustomerCard
                    .id,
          ).first;

          int settlementsNumbersTotal = 0;
          for (Settlement settlement in receivingCustomerCardSettlements) {
            settlementsNumbersTotal += settlement.number;
          }
          ref
              .read(
                transfersBetweenCustomersAccountReceivingCustomerCardSettlementsNumbersTotalProvider
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
                                'transfers-between-customers-accounts-issuing-card-type',
                              ),
                            );

                            final issuingCustomerCard =
                                transfersBetweenCustomersAccountsSelectedIssuingCustomerCards
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
                              'transfers-between-customers-accounts-issuing-card-type',
                          dropdownMenuEntriesLabels: typeListStream.when(
                            data: (data) => data
                                .where(
                                  (type) =>
                                      transfersBetweenCustomersAccountsSelectedIssuingCustomerCards
                                          .any(
                                    (customerCard) =>
                                        customerCard.satisfiedAt == null &&
                                        customerCard.repaidAt == null &&
                                        customerCard.transferredAt == null &&
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
                                      transfersBetweenCustomersAccountsSelectedIssuingCustomerCards
                                          .any(
                                    (customerCard) =>
                                        customerCard.satisfiedAt == null &&
                                        customerCard.repaidAt == null &&
                                        customerCard.transferredAt == null &&
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
                            value: transfersBetweenCustomersAccountsSelectedIssuingCustomerCard !=
                                        null &&
                                    transfersBetweenCustomersAccountsSelectedIssuingCustomerCard
                                            .id !=
                                        null
                                ? transfersBetweenCustomersAccountsSelectedIssuingCustomerCard
                                    .typeNumber
                                    .toString()
                                : '',
                          ),
                          OtherInfos(
                            label: 'Mise Type',
                            value: transfersBetweenCustomersAccountsSelectedIssuingCustomerCardType !=
                                        null &&
                                    transfersBetweenCustomersAccountsSelectedIssuingCustomerCardType
                                            .id !=
                                        null
                                ? '${transfersBetweenCustomersAccountsSelectedIssuingCustomerCardType.stake.toInt()}'
                                : '',
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              return OtherInfos(
                                label: 'Total Règlements',
                                value: transfersBetweenCustomersAccountsSelectedIssuingCustomerCardType !=
                                        null
                                    ? issuingCustomerCardSettlementsNumbersTotal
                                        .toString()
                                    : '',
                              );
                            },
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              final amount = transfersBetweenCustomersAccountsSelectedIssuingCustomerCard !=
                                          null &&
                                      transfersBetweenCustomersAccountsSelectedIssuingCustomerCardType !=
                                          null
                                  ? (transfersBetweenCustomersAccountsSelectedIssuingCustomerCard
                                              .typeNumber *
                                          transfersBetweenCustomersAccountsSelectedIssuingCustomerCardType
                                              .stake *
                                          issuingCustomerCardSettlementsNumbersTotal)
                                      .round()
                                  : 0;
                              return OtherInfos(
                                label: 'Montant Réglé',
                                value: transfersBetweenCustomersAccountsSelectedIssuingCustomerCard !=
                                            null &&
                                        transfersBetweenCustomersAccountsSelectedIssuingCustomerCardType !=
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
                            final amount = transfersBetweenCustomersAccountsSelectedIssuingCustomerCard != null &&
                                    transfersBetweenCustomersAccountsSelectedIssuingCustomerCard
                                            .id !=
                                        null &&
                                    transfersBetweenCustomersAccountsSelectedIssuingCustomerCardType !=
                                        null
                                ? (2 *
                                            (transfersBetweenCustomersAccountsSelectedIssuingCustomerCard
                                                    .typeNumber *
                                                transfersBetweenCustomersAccountsSelectedIssuingCustomerCardType
                                                    .stake *
                                                issuingCustomerCardSettlementsNumbersTotal) /
                                            3 -
                                        300)
                                    .round()
                                : 0;
                            return CBText(
                              text: transfersBetweenCustomersAccountsSelectedIssuingCustomerCard !=
                                          null &&
                                      transfersBetweenCustomersAccountsSelectedIssuingCustomerCardType !=
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
                                'transfers-between-customers-accounts-receiving-card-type',
                              ),
                            );
                            final receivingCustomerCard =
                                transfersBetweenCustomersAccountsSelectedReceivingCustomerCards
                                    .firstWhere(
                              (customerCard) =>
                                  customerCard.satisfiedAt == null &&
                                  customerCard.repaidAt == null &&
                                  customerCard.transferredAt == null &&
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
                              'transfers-between-customers-accounts-receiving-card-type',
                          dropdownMenuEntriesLabels: typeListStream.when(
                            data: (data) => data
                                .where(
                                  (type) =>
                                      transfersBetweenCustomersAccountsSelectedReceivingCustomerCards
                                          .any(
                                    (customerCard) =>
                                        customerCard.satisfiedAt == null &&
                                        customerCard.repaidAt == null &&
                                        customerCard.transferredAt == null &&
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
                                      transfersBetweenCustomersAccountsSelectedReceivingCustomerCards
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
                            value: transfersBetweenCustomersAccountsSelectedReceivingCustomerCard !=
                                        null &&
                                    transfersBetweenCustomersAccountsSelectedReceivingCustomerCard
                                            .id !=
                                        null
                                ? transfersBetweenCustomersAccountsSelectedReceivingCustomerCard
                                    .typeNumber
                                    .toString()
                                : '',
                          ),
                          OtherInfos(
                            label: 'Mise Type',
                            value: transfersBetweenCustomersAccountsSelectedReceivingCustomerCardType !=
                                        null &&
                                    transfersBetweenCustomersAccountsSelectedReceivingCustomerCardType
                                            .id !=
                                        null
                                ? '${transfersBetweenCustomersAccountsSelectedReceivingCustomerCardType.stake.ceil()}'
                                : '',
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              return OtherInfos(
                                label: 'Total Règlements',
                                value: transfersBetweenCustomersAccountsSelectedReceivingCustomerCardType !=
                                        null
                                    ? receivingCustomerCardSettlementsNumbersTotal
                                        .toString()
                                    : '',
                              );
                            },
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              final amount = transfersBetweenCustomersAccountsSelectedReceivingCustomerCard !=
                                          null &&
                                      transfersBetweenCustomersAccountsSelectedReceivingCustomerCardType !=
                                          null
                                  ? (transfersBetweenCustomersAccountsSelectedReceivingCustomerCard
                                              .typeNumber *
                                          transfersBetweenCustomersAccountsSelectedReceivingCustomerCardType
                                              .stake *
                                          receivingCustomerCardSettlementsNumbersTotal)
                                      .ceil()
                                  : 0;
                              return OtherInfos(
                                label: 'Montant Réglé',
                                value: transfersBetweenCustomersAccountsSelectedReceivingCustomerCard !=
                                            null &&
                                        transfersBetweenCustomersAccountsSelectedReceivingCustomerCardType !=
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
                            final settlementNumber = transfersBetweenCustomersAccountsSelectedIssuingCustomerCard != null &&
                                    transfersBetweenCustomersAccountsSelectedIssuingCustomerCard
                                            .id !=
                                        null &&
                                    transfersBetweenCustomersAccountsSelectedIssuingCustomerCardType !=
                                        null &&
                                    transfersBetweenCustomersAccountsSelectedReceivingCustomerCard !=
                                        null &&
                                    transfersBetweenCustomersAccountsSelectedReceivingCustomerCard
                                            .id !=
                                        null &&
                                    transfersBetweenCustomersAccountsSelectedReceivingCustomerCardType !=
                                        null
                                ? ((2 *
                                                (transfersBetweenCustomersAccountsSelectedIssuingCustomerCard
                                                        .typeNumber *
                                                    transfersBetweenCustomersAccountsSelectedIssuingCustomerCardType
                                                        .stake *
                                                    issuingCustomerCardSettlementsNumbersTotal) /
                                                3 -
                                            300) /
                                        transfersBetweenCustomersAccountsSelectedReceivingCustomerCardType
                                            .stake)
                                    .round()
                                : 0;
                            return CBText(
                              text: transfersBetweenCustomersAccountsSelectedIssuingCustomerCard != null &&
                                      transfersBetweenCustomersAccountsSelectedIssuingCustomerCardType !=
                                          null &&
                                      transfersBetweenCustomersAccountsSelectedReceivingCustomerCard !=
                                          null &&
                                      transfersBetweenCustomersAccountsSelectedReceivingCustomerCardType !=
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
                  ? await TransferCRUDFunctions.createBetweenCustomersAccounts(
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
