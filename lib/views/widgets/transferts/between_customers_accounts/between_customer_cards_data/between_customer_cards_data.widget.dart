import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/models/data/type/type.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards_list/customers_cards_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/types/types_list/types_list.widget.dart';
import 'package:communitybank/views/widgets/globals/elevated_button/elevated_button.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/type/type_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
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

class TransfersBetweenCustomerCardsData extends StatefulHookConsumerWidget {
  const TransfersBetweenCustomerCardsData({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransfersBetweenCustomerCardsDataState();
}

class _TransfersBetweenCustomerCardsDataState
    extends ConsumerState<TransfersBetweenCustomerCardsData> {
  @override
  Widget build(BuildContext context) {
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

    ref.listen(
      transfersBetweenCustomerCardsSelectedCustomerAccountProvider,
      (previous, next) {
        Future.delayed(
          const Duration(
            milliseconds: 100,
          ),
          () {
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

                // update issuing customer card
                // take the first customer card by default
                // as the issuingCustomerCard
                ref
                    .read(
                        transfersBetweenCustomerCardSelectedIssuingCustomerCardProvider
                            .notifier)
                    .state = customerCards[0];

                // update issuing customer card
                // take the first customer card by default
                // as the receivingCustomerCard
                ref
                    .read(
                        transfersBetweenCustomerCardSelectedReceivingCustomerCardProvider
                            .notifier)
                    .state = customerCards[1];
              },
              error: (error, stackTrace) {},
              loading: () {},
            );
          },
        );
      },
    );

    ref.listen(
      transfersBetweenCustomerCardSelectedIssuingCustomerCardProvider,
      (previous, next) {
        Future.delayed(
          const Duration(
            milliseconds: 100,
          ),
          () {
            typeListStream.when(
              data: (data) {
                final selectedType = data.firstWhere(
                  (type) => next?.typeId == type.id,
                  orElse: () => Type(
                    name: '',
                    stake: 0,
                    productsIds: [],
                    productsNumber: [],
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  ),
                );
                ref
                    .read(
                      transfersBetweenCustomerCardSelectedIssuingCustomerCardTypeProvider
                          .notifier,
                    )
                    .state = selectedType;
              },
              error: (error, stackTrace) {},
              loading: () {},
            );
          },
        );
      },
    );

    ref.listen(
      transfersBetweenCustomerCardSelectedReceivingCustomerCardProvider,
      (previous, next) {
        Future.delayed(
          const Duration(
            milliseconds: 100,
          ),
          () {
            typeListStream.when(
              data: (data) {
                final selectedType = data.firstWhere(
                  (type) => next?.typeId == type.id,
                  orElse: () => Type(
                    name: '',
                    stake: 0,
                    productsIds: [],
                    productsNumber: [],
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  ),
                );
                ref
                    .read(
                      transfersBetweenCustomerCardSelectedReceivingCustomerCardTypeProvider
                          .notifier,
                    )
                    .state = selectedType;
              },
              error: (error, stackTrace) {},
              loading: () {},
            );
          },
        );
      },
    );

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
                      text: 'Carte Émettrice',
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
                              formTypeDropdownProvider(
                                  'transfers-between-customer-cards-issuing-card-type'),
                            );
                            return CustomerCardWidget(
                              customerCard:
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
                              ),
                            );
                          },
                        ),
                        CBFormTypeDropdown(
                          label: 'Type',
                          width: 150,
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
                            value:
                                transfersBetweenCustomerCardSelectedIssuingCustomerCard
                                        ?.typeNumber
                                        .toString() ??
                                    '',
                          ),
                          OtherInfos(
                            label: 'Mise Type',
                            value:
                                '${transfersBetweenCustomerCardSelectedIssuingCustomerCardType?.stake.ceil() ?? ''}',
                          ),
                          const OtherInfos(
                            label: 'Total Règlements',
                            value: '20',
                          ),
                          const OtherInfos(
                            label: 'Montant Réglé',
                            value: '2000f',
                          )
                        ],
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CBText(
                          text: 'Montant à transférer: ',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        CBText(
                          text: '1700f',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
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
                      text: 'Carte Réceptrice',
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
                              formTypeDropdownProvider(
                                  'transfers-between-customer-cards-receving-card-type'),
                            );
                            return CustomerCardWidget(
                              customerCard:
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
                              ),
                            );
                          },
                        ),
                        CBFormTypeDropdown(
                          label: 'Type',
                          width: 150,
                          providerName:
                              'transfers-between-customer-cards-receving-card-type',
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
                            value:
                                transfersBetweenCustomerCardSelectedReceivingCustomerCard
                                        ?.typeNumber
                                        .toString() ??
                                    '',
                          ),
                          OtherInfos(
                            label: 'Mise Type',
                            value:
                                '${transfersBetweenCustomerCardSelectedReceivingCustomerCardType?.stake.ceil() ?? ''}',
                          ),
                          const OtherInfos(
                            label: 'Total Règlements',
                            value: '50',
                          ),
                          const OtherInfos(
                            label: 'Montant Réglé',
                            value: '2500f',
                          )
                        ],
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CBText(
                          text: 'Règlements à recevoir: ',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        CBText(
                          text: '34',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
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
          child: CBElevatedButton(text: "Transférer", onPressed: () {}),
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
