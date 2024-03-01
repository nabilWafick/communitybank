import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/models/data/type/type.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/activities/customer_periodic_activity/customer_periodic_activity_data/customer_card_card/customer_card_card.widget.dart';
import 'package:communitybank/views/widgets/activities/customer_periodic_activity/customer_periodic_activity_data/customer_cards_horizontal_scroller/customer_cards_horizontal_scroller.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards_list/customers_cards_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/types/types_list/types_list.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:communitybank/views/widgets/printing_data_preview/customer_card_settlements_details/customer_card_settlements_details_printing.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

final customerPeriodicActivitySelectedCustomerAccountProvider =
    StateProvider<CustomerAccount?>((ref) {
  return;
});

final customerPeriodicActivitySelectedCustomerCardProvider =
    StateProvider<CustomerCard?>((ref) {
  return;
});

final customerPeriodicActivitySelectedCustomerCardTypeProvider =
    StateProvider<Type?>((ref) {
  return;
});

class CustomerPeriodicActivityData extends ConsumerStatefulWidget {
  const CustomerPeriodicActivityData({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomerPeriodicActivityDataState();
}

class _CustomerPeriodicActivityDataState
    extends ConsumerState<CustomerPeriodicActivityData> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final selectedCustomerAccount = ref.watch(
      customerPeriodicActivitySelectedCustomerAccountProvider,
    );
    final customersCardsListStream =
        ref.watch(customersCardsListStreamProvider);
    final typeListStream = ref.watch(typesListStreamProvider);
    final customerPeriodicActivitySelectedCustomerCard =
        ref.watch(customerPeriodicActivitySelectedCustomerCardProvider);
    final customerPeriodicActivitySelectedCustomerCardType =
        ref.watch(customerPeriodicActivitySelectedCustomerCardTypeProvider);
    final format = DateFormat.yMMMMEEEEd('fr');
    final customerCardSettlementsDetailsList = ref.watch(
      customerCardSettlementsDetailsProvider(
        customerPeriodicActivitySelectedCustomerCard != null &&
                customerPeriodicActivitySelectedCustomerCard.id != null
            ? customerPeriodicActivitySelectedCustomerCard.id!
            : 0,
      ),
    );

    ref.listen(
      customerPeriodicActivitySelectedCustomerAccountProvider,
      (previous, next) {
        Future.delayed(
          const Duration(
            milliseconds: 100,
          ),
          () {
            customersCardsListStream.when(
              data: (data) {
                final selectedCard = data.firstWhere(
                  (customerCard) =>
                      next?.customerCardsIds.contains(customerCard.id) ?? false,
                  orElse: () => CustomerCard(
                    label: '',
                    typeId: 0,
                    typeNumber: 0,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  ),
                );
                ref
                    .read(
                      customerPeriodicActivitySelectedCustomerCardProvider
                          .notifier,
                    )
                    .state = selectedCard;
              },
              error: (error, stackTrace) {},
              loading: () {},
            );
          },
        );
      },
    );

    ref.listen(
      customerPeriodicActivitySelectedCustomerCardProvider,
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
                      customerPeriodicActivitySelectedCustomerCardTypeProvider
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CBText(
              text: 'Cartes: ',
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 20.0,
              ),
              width: MediaQuery.of(context).size.width * .79,
              height: 40.0,
              child: ActivityCustomerCardsHorizontalScroller(
                children: customersCardsListStream.when(
                  data: (data) => data
                      .where((customerCard) =>
                              selectedCustomerAccount?.customerCardsIds
                                  .contains(
                                customerCard.id!,
                              ) ??
                              false /* &&
                            customerCard.satisfiedAt == null &&
                            customerCard.repaidAt == null,*/
                          )
                      .map(
                        (customerCard) => ActivityCustomerCardCard(
                          customerCard: customerCard,
                        ),
                      )
                      .toList(),
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 20.0,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OtherInfos(
                    label: 'Carte',
                    value: customerPeriodicActivitySelectedCustomerCard !=
                                null &&
                            customerPeriodicActivitySelectedCustomerCard.id !=
                                null
                        ? customerPeriodicActivitySelectedCustomerCard.label
                        : '',
                  ),
                  OtherInfos(
                    label: 'Nombre Type',
                    value: customerPeriodicActivitySelectedCustomerCard !=
                                null &&
                            customerPeriodicActivitySelectedCustomerCard.id !=
                                null
                        ? customerPeriodicActivitySelectedCustomerCard
                            .typeNumber
                            .toString()
                        : '',
                  )
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OtherInfos(
                    label: 'Type',
                    value: customerPeriodicActivitySelectedCustomerCardType !=
                                null &&
                            customerPeriodicActivitySelectedCustomerCardType
                                    .id !=
                                null
                        ? customerPeriodicActivitySelectedCustomerCardType.name
                        : '',
                  ),
                  const SizedBox(
                    width: 30.0,
                  ),
                  OtherInfos(
                    label: 'Mise',
                    value: customerPeriodicActivitySelectedCustomerCardType !=
                                null &&
                            customerPeriodicActivitySelectedCustomerCardType
                                    .id !=
                                null
                        ? '${customerPeriodicActivitySelectedCustomerCardType.stake.ceil()}f'
                        : '',
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * .55,
          child: customerCardSettlementsDetailsList.when(
            data: (data) => HorizontalDataTable(
              leftHandSideColumnWidth: 100,
              rightHandSideColumnWidth: MediaQuery.of(context).size.width,
              itemCount: data.length,
              isFixedHeader: true,
              leftHandSideColBackgroundColor: Colors.transparent,
              rightHandSideColBackgroundColor: Colors.transparent,
              headerWidgets: [
                Container(
                  width: 200.0,
                  height: 50.0,
                  alignment: Alignment.center,
                  child: const CBText(
                    text: 'N°',
                    textAlign: TextAlign.center,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 300.0,
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  child: const CBText(
                    text: 'Date de collecte',
                    textAlign: TextAlign.start,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 200.0,
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  child: const CBText(
                    text: 'Nombre Mise',
                    textAlign: TextAlign.start,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 200.0,
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  child: const CBText(
                    text: 'Montant',
                    textAlign: TextAlign.start,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 300.0,
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  child: const CBText(
                    text: 'Date de saisie',
                    textAlign: TextAlign.start,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 400.0,
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  child: const CBText(
                    text: 'Agent',
                    textAlign: TextAlign.start,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              leftSideItemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  width: 200.0,
                  height: 30.0,
                  child: CBText(
                    text: '${index + 1}',
                    fontSize: 12.0,
                  ),
                );
              },
              rightSideItemBuilder: (BuildContext context, int index) {
                final customerCardSettlementDetail = data[index];
                return Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 300.0,
                      height: 30.0,
                      child: CBText(
                        text: format.format(
                            customerCardSettlementDetail.settlementDate),
                        fontSize: 12.0,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 200.0,
                      height: 30.0,
                      child: CBText(
                        text: customerCardSettlementDetail.settlementNumber
                            .toString(),
                        fontSize: 12.0,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 200.0,
                      height: 30.0,
                      child: CBText(
                        text: customerCardSettlementDetail.settlementAmount
                            .ceil()
                            .toString(),
                        fontSize: 12.0,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 300.0,
                      height: 30.0,
                      child: CBText(
                        text: format.format(
                          customerCardSettlementDetail.settlementEntryDate,
                        ),
                        fontSize: 12.0,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 400.0,
                      height: 30.0,
                      child: CBText(
                        text:
                            '${customerCardSettlementDetail.agentName} ${customerCardSettlementDetail.agentFirstnames}',
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                );
              },
              rowSeparatorWidget: const Divider(),
              scrollPhysics: const BouncingScrollPhysics(),
              horizontalScrollPhysics: const BouncingScrollPhysics(),
            ),
            error: (error, stackTrace) => HorizontalDataTable(
              leftHandSideColumnWidth: 100,
              rightHandSideColumnWidth: 1450,
              itemCount: 0,
              isFixedHeader: true,
              leftHandSideColBackgroundColor: CBColors.backgroundColor,
              rightHandSideColBackgroundColor: CBColors.backgroundColor,
              headerWidgets: [
                Container(
                  width: 200.0,
                  height: 50.0,
                  alignment: Alignment.center,
                  child: const CBText(
                    text: 'N°',
                    textAlign: TextAlign.center,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 300.0,
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  child: const CBText(
                    text: 'Date de collecte',
                    textAlign: TextAlign.start,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 200.0,
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  child: const CBText(
                    text: 'Nombre Mise',
                    textAlign: TextAlign.start,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 200.0,
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  child: const CBText(
                    text: 'Montant',
                    textAlign: TextAlign.start,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 300.0,
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  child: const CBText(
                    text: 'Date de saisie',
                    textAlign: TextAlign.start,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 400.0,
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  child: const CBText(
                    text: 'Agent',
                    textAlign: TextAlign.start,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              leftSideItemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  width: 200.0,
                  height: 30.0,
                  child: CBText(
                    text: '${index + 1}',
                    fontSize: 12.0,
                  ),
                );
              },
              rightSideItemBuilder: (BuildContext context, int index) {
                return const Row(
                  children: [],
                );
              },
              rowSeparatorWidget: const Divider(),
              scrollPhysics: const BouncingScrollPhysics(),
              horizontalScrollPhysics: const BouncingScrollPhysics(),
            ),
            loading: () => HorizontalDataTable(
              leftHandSideColumnWidth: 100,
              rightHandSideColumnWidth: 1450,
              itemCount: 0,
              isFixedHeader: true,
              leftHandSideColBackgroundColor: CBColors.backgroundColor,
              rightHandSideColBackgroundColor: CBColors.backgroundColor,
              headerWidgets: [
                Container(
                  width: 200.0,
                  height: 50.0,
                  alignment: Alignment.center,
                  child: const CBText(
                    text: 'N°',
                    textAlign: TextAlign.center,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 300.0,
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  child: const CBText(
                    text: 'Date de collecte',
                    textAlign: TextAlign.start,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 200.0,
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  child: const CBText(
                    text: 'Nombre Mise',
                    textAlign: TextAlign.start,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 200.0,
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  child: const CBText(
                    text: 'Montant',
                    textAlign: TextAlign.start,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 300.0,
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  child: const CBText(
                    text: 'Date de saisie',
                    textAlign: TextAlign.start,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 400.0,
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  child: const CBText(
                    text: 'Agent',
                    textAlign: TextAlign.start,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              leftSideItemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  width: 200.0,
                  height: 30.0,
                  child: CBText(
                    text: '${index + 1}',
                    fontSize: 12.0,
                  ),
                );
              },
              rightSideItemBuilder: (BuildContext context, int index) {
                return const Row(
                  children: [],
                );
              },
              rowSeparatorWidget: const Divider(),
              scrollPhysics: const BouncingScrollPhysics(),
              horizontalScrollPhysics: const BouncingScrollPhysics(),
            ),
          ),
        ),
      ],
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
            fontSize: 11,
            //  fontWeight: FontWeight.w500,
          ),
          CBText(
            text: value,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }
}
