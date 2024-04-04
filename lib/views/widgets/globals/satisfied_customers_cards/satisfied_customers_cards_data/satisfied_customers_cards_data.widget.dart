import 'package:communitybank/controllers/satisfied_customers_cards/satisfied_customers_cards.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/satisfied_customers_cards/satisfied_customers_cards.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/activities/satisfied_customers_cards/satisfied_customers_cards.widgets.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/collector/collector_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_account/customer_account_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/type/type_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/date_symbol_data_local.dart';

final satisfiedCustomersCardsListStreamProvider =
    StreamProvider<List<SatisfiedCustomersCards>>((ref) async* {
  final satisfiedCustomersCardsBeginDate =
      ref.watch(satisfiedCustomersCardsBeginDateProvider);
  final satisfiedCustomersCardsEndDate =
      ref.watch(satisfiedCustomersCardsEndDateProvider);
  final selectedCollector = ref.watch(
    listCollectorDropdownProvider('satisfied-customers-cards-collector'),
  );
  final selectedCustomerAccount = ref.watch(
    listCustomerAccountDropdownProvider(
        'satisfied-customers-cards-customer-account'),
  );
  final selectedCustomerCardType = ref.watch(
    listTypeDropdownProvider('satisfied-customers-cards-type'),
  );
  yield* SatisfiedCustomersCardsController.getSatisfiedCustomersCards(
    beginDate: satisfiedCustomersCardsBeginDate != null
        ? FunctionsController.getSQLFormatDate(
            dateTime: satisfiedCustomersCardsBeginDate,
          )
        : null,
    endDate: satisfiedCustomersCardsEndDate != null
        ? FunctionsController.getSQLFormatDate(
            dateTime: satisfiedCustomersCardsEndDate,
          )
        : null,
    collectorId: selectedCollector.id != 0 ? selectedCollector.id : null,
    customerAccountId:
        selectedCustomerAccount.id != 0 ? selectedCustomerAccount.id : null,
    customerCardId: null,
    typeId:
        selectedCustomerCardType.id != 0 ? selectedCustomerCardType.id : null,
  ).asStream();
});

class SatisfiedCustomersCardsData extends ConsumerStatefulWidget {
  const SatisfiedCustomersCardsData({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SatisfiedCustomersCardsDataState();
}

class _SatisfiedCustomersCardsDataState
    extends ConsumerState<SatisfiedCustomersCardsData> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  final ScrollController verticalScrollController = ScrollController();
  final ScrollController horizontalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final satisfiedCustomersCardsDataStream =
        ref.watch(satisfiedCustomersCardsListStreamProvider);

    // final format = DateFormat.yMMMMEEEEd('fr');

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: satisfiedCustomersCardsDataStream.when(
          data: (data) => HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: MediaQuery.of(context).size.width + 100,
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
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const SizedBox(),
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
                width: 400.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Clients',
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
                  text: 'Cartes',
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
                  text: 'Types',
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
              final satisfiedCustomersCards = data[index];
              return Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 200.0,
                      height: 30.0,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.aspect_ratio,
                        color: CBColors.primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 30.0,
                    child: CBText(
                      text: satisfiedCustomersCards.collector,
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: Consumer(
                      builder: (context, ref, child) {
                        String customers = '';
                        for (int i = 0;
                            i < satisfiedCustomersCards.customers.length;
                            i++) {
                          if (customers.isEmpty) {
                            customers = satisfiedCustomersCards.customers[i];
                          } else {
                            customers =
                                '$customers, ${satisfiedCustomersCards.customers[i]}';
                          }
                        }
                        return CBText(
                          text: FunctionsController.truncateText(
                            text: customers,
                            maxLength: 30,
                          ),
                          fontSize: 12.0,
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: Consumer(
                      builder: (context, ref, child) {
                        String customersCardsLabels = '';
                        for (int i = 0;
                            i <
                                satisfiedCustomersCards
                                    .customersCardsLabels.length;
                            i++) {
                          if (customersCardsLabels.isEmpty) {
                            customersCardsLabels =
                                satisfiedCustomersCards.customersCardsLabels[i];
                          } else {
                            customersCardsLabels =
                                '$customersCardsLabels, ${satisfiedCustomersCards.customersCardsLabels[i]}';
                          }
                        }
                        return CBText(
                          text: FunctionsController.truncateText(
                            text: customersCardsLabels,
                            maxLength: 30,
                          ),
                          fontSize: 12.0,
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: Consumer(
                      builder: (context, ref, child) {
                        String typesNames = '';
                        for (int i = 0;
                            i < satisfiedCustomersCards.typesNames.length;
                            i++) {
                          if (typesNames.isEmpty) {
                            typesNames = satisfiedCustomersCards.typesNames[i];
                          } else {
                            typesNames =
                                '$typesNames, ${satisfiedCustomersCards.typesNames[i]}';
                          }
                        }
                        return CBText(
                          text: FunctionsController.truncateText(
                            text: typesNames,
                            maxLength: 30,
                          ),
                          fontSize: 12.0,
                          textAlign: TextAlign.center,
                        );
                      },
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
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const SizedBox(),
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
                width: 400.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Clients',
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
                  text: 'Cartes',
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
                  text: 'Types',
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
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const SizedBox(),
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
                width: 400.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Clients',
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
                  text: 'Cartes',
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
                  text: 'Types',
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
