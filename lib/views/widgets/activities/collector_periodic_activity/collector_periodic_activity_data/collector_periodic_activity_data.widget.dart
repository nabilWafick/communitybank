import 'package:communitybank/controllers/collector_periodic_activity/collector_periodic_activity.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/collector_periodic_activity/collector_periodic_activity.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/activities/collector_periodic_activity/collector_periodic_activity_sort_options/collector_periodic_activity_sort_options.widget.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/collector/collector_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_account/customer_account_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

final collectorPeriodicActivityDataProvider =
    StreamProvider<List<CollectorPeriodicActivity>>((ref) async* {
  final collectionBeginDate =
      ref.watch(collectorPeriodicActivityCollectionBeginDateProvider);
  final collectionEndDate =
      ref.watch(collectorPeriodicActivityCollectionEndDateProvider);
  final collector = ref.watch(
    listCollectorDropdownProvider('collector-periodic-activity-collector'),
  );
  final customerAccount = ref.watch(
    listCustomerAccountDropdownProvider(
        'collector-periodic-activity-customer-account'),
  );
  final settelementsTotal = int.tryParse(
    ref.watch(searchProvider('collector-periodic-activity-settlements-number')),
  );

  yield* CollectorPeriodicActivityController.getCollectorPeriodicActivity(
    collectionBeginDate: collectionBeginDate,
    collectionEndDate: collectionEndDate,
    collectorId: collector.id == 0 ? 0 : collector.id!,
    customerAccountId: customerAccount.id == 0 ? null : customerAccount.id,
    settlementsTotal: settelementsTotal,
  ).asStream();
});

double settlementsAmountsTotals = 0;
final settlementsAmountsTotalsProvider = StateProvider<double>((ref) {
  return 0;
});

class CollectorPeriodicActivityData extends ConsumerStatefulWidget {
  const CollectorPeriodicActivityData({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CollectorPeriodicActivityDataState();
}

class _CollectorPeriodicActivityDataState
    extends ConsumerState<CollectorPeriodicActivityData> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final collectorPeriodicActivityDataStream =
        ref.watch(collectorPeriodicActivityDataProvider);

    final format = DateFormat.yMMMMEEEEd('fr');

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: collectorPeriodicActivityDataStream.when(
          data: (data) {
            return HorizontalDataTable(
              leftHandSideColumnWidth: 100,
              rightHandSideColumnWidth: MediaQuery.of(context).size.width + 300,
              itemCount: data.length,
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
                    text: 'Date de Collecte',
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
                    text: 'Client',
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
                    text: 'Chargé de compte',
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
                    text: 'Cartes',
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
                    text: 'Types',
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
                    text: 'Total Réglé',
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
                final collectorPeriodicActivity = data[index];
                return Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 300.0,
                      height: 30.0,
                      child: CBText(
                        text: format
                            .format(collectorPeriodicActivity.collectionDate),
                        fontSize: 12.0,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 300.0,
                      height: 30.0,
                      child: CBText(
                        text: FunctionsController.truncateText(
                          text: collectorPeriodicActivity.customer,
                          maxLength: 20,
                        ),
                        fontSize: 12.0,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 300.0,
                      height: 30.0,
                      child: CBText(
                        text: collectorPeriodicActivity.collector,
                        fontSize: 12.0,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 300.0,
                      height: 30.0,
                      child: Consumer(
                        builder: (context, ref, child) {
                          String customerCards = '';

                          for (String customerCardsLabel
                              in collectorPeriodicActivity
                                  .customersCardsLabels) {
                            if (customerCards.isEmpty) {
                              customerCards = customerCardsLabel;
                            } else {
                              customerCards =
                                  '$customerCards $customerCardsLabel';
                            }
                          }

                          return CBText(
                            text: FunctionsController.truncateText(
                              text: customerCards,
                              maxLength: 30,
                            ),
                            fontSize: 12.0,
                          );
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 300.0,
                      height: 30.0,
                      child: Consumer(
                        builder: (context, ref, child) {
                          final typesNames =
                              collectorPeriodicActivity.typesNames;
                          final settlementsTotals = collectorPeriodicActivity
                              .customerCardSettlementsTotals;
                          String types = '';

                          for (int i = 0; i < typesNames.length; ++i) {
                            if (types.isEmpty) {
                              types =
                                  '${settlementsTotals[i]} * ${typesNames[i]}';
                            } else {
                              types =
                                  '$types, ${settlementsTotals[i]} * ${typesNames[i]}';
                            }
                          }

                          return CBText(
                            text: types,
                            textAlign: TextAlign.start,
                            fontSize: 12.0,
                          );
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 200.0,
                      height: 30.0,
                      child: Consumer(
                        builder: (context, ref, child) {
                          final customerCardSettlementsAmounts =
                              collectorPeriodicActivity
                                  .customerCardSettlementsAmounts;
                          dynamic settlementsAmountsTotal = 0;
                          for (dynamic customerSettlementAmount
                              in customerCardSettlementsAmounts) {
                            settlementsAmountsTotal += customerSettlementAmount;
                          }

                          return CBText(
                            text: settlementsAmountsTotal.ceil().toString(),
                            fontSize: 12.0,
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
              footerWidgets: [
                Container(
                  width: 200.0,
                  height: 50.0,
                  alignment: Alignment.center,
                  child: CBText(
                    text: data.length.toString(),
                    textAlign: TextAlign.center,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: 300.0,
                  height: 30.0,
                  child: const SizedBox(),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: 300.0,
                  height: 30.0,
                  child: const SizedBox(),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: 300.0,
                  height: 30.0,
                  child: data.isNotEmpty
                      ? CBText(
                          text: data[0].collector,
                          fontSize: 12.0,
                          textAlign: TextAlign.center,
                        )
                      : const SizedBox(),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: 300.0,
                  height: 30.0,
                  child: const SizedBox(),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: 300.0,
                  height: 30.0,
                  child: const SizedBox(),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: 200.0,
                  height: 30.0,
                  child: const CBText(
                    text: 'Footer',
                    //settlementsAmountsTotals.ceil().toString(),
                    fontSize: 12.0,
                  ),
                ),
              ],
              rowSeparatorWidget: const Divider(),
              scrollPhysics: const BouncingScrollPhysics(),
              horizontalScrollPhysics: const BouncingScrollPhysics(),
            );
          },
          error: (error, stackTrace) => HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: 1450,
            itemCount: 0,
            isFixedHeader: true,
            leftHandSideColBackgroundColor: CBColors.backgroundColor,
            rightHandSideColBackgroundColor: CBColors.backgroundColor,
            headerWidgets: [
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Date de Collecte',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Nom Client',
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
                  text: 'Prénom Chargé',
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
                  text: 'Prénom Chargé',
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
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Date de Collecte',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Nom Client',
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
                  text: 'Prénom Chargé',
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
                  text: 'Prénom Chargé',
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
    );
  }
}
