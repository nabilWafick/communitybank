import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/satisfied_customers_cards/satisfied_customers_cards.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:communitybank/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class SatisfiedCustomersCardsDetailsShower extends StatefulHookConsumerWidget {
  final SatisfiedCustomersCards satisfiedCustomersCards;
  const SatisfiedCustomersCardsDetailsShower({
    super.key,
    required this.satisfiedCustomersCards,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SatisfiedCustomersCardsDetailsShowerState();
}

class _SatisfiedCustomersCardsDetailsShowerState
    extends ConsumerState<SatisfiedCustomersCardsDetailsShower> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    const formCardWidth = 1200.0;
    final format = DateFormat.yMMMMEEEEd('fr');
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CBText(
            text: 'Détails',
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
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      content: Container(
        // color: Colors.blueGrey,
        padding: const EdgeInsets.all(20.0),
        width: formCardWidth,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.satisfiedCustomersCards.collector != null
                      ? Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                            vertical: 20.0,
                          ),
                          child: Column(
                            children: [
                              CBText(
                                text: widget.satisfiedCustomersCards.collector,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              SizedBox(
                                height: 300.0,
                                child: HorizontalDataTable(
                                  leftHandSideColumnWidth: 100,
                                  rightHandSideColumnWidth: 1300,
                                  itemCount: widget.satisfiedCustomersCards
                                      .customersAccountsIds.length,
                                  isFixedHeader: true,
                                  leftHandSideColBackgroundColor:
                                      Colors.transparent,
                                  rightHandSideColBackgroundColor:
                                      Colors.transparent,
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
                                        text: 'Client',
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
                                        text: 'Carte',
                                        textAlign: TextAlign.center,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      width: 200.0,
                                      height: 50.0,
                                      alignment: Alignment.center,
                                      child: const CBText(
                                        text: 'Nombre Type',
                                        textAlign: TextAlign.center,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      width: 200.0,
                                      height: 50.0,
                                      alignment: Alignment.center,
                                      child: const CBText(
                                        text: 'Statut',
                                        textAlign: TextAlign.center,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      width: 300.0,
                                      height: 50.0,
                                      alignment: Alignment.center,
                                      child: const CBText(
                                        text: 'Date',
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
                                  rightSideItemBuilder:
                                      (BuildContext context, int index) {
                                    return Row(
                                      children: [
                                        Container(
                                          width: 300.0,
                                          height: 30.0,
                                          alignment: Alignment.centerLeft,
                                          child: CBText(
                                            text: FunctionsController
                                                .truncateText(
                                              text: widget
                                                  .satisfiedCustomersCards
                                                  .customers[index],
                                              maxLength: 30,
                                            ),
                                            textAlign: TextAlign.start,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Container(
                                          width: 300.0,
                                          height: 30.0,
                                          alignment: Alignment.centerLeft,
                                          child: CBText(
                                            text: widget.satisfiedCustomersCards
                                                .customersCardsLabels[index]
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Container(
                                          width: 200.0,
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: CBText(
                                            text: widget
                                                .satisfiedCustomersCards
                                                .customersCardsTypesNumbers[
                                                    index]
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Container(
                                          width: 200.0,
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: Consumer(
                                            builder: (context, ref, child) {
                                              String customerCardStatus = '';

                                              if (widget.satisfiedCustomersCards
                                                      .repaymentsDates[index] !=
                                                  null) {
                                                customerCardStatus =
                                                    'Remboursée';
                                              } else if (widget
                                                          .satisfiedCustomersCards
                                                          .satisfactionsDates[
                                                      index] !=
                                                  null) {
                                                customerCardStatus =
                                                    'Satifaite';
                                              } else if (widget
                                                      .satisfiedCustomersCards
                                                      .transfersDates[index] !=
                                                  null) {
                                                customerCardStatus =
                                                    'Transférée';
                                              }

                                              return CBText(
                                                text: customerCardStatus,
                                                textAlign: TextAlign.center,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w500,
                                              );
                                            },
                                          ),
                                        ),
                                        Container(
                                          width: 300.0,
                                          height: 30.0,
                                          alignment: Alignment.center,
                                          child: Consumer(
                                            builder: (context, ref, child) {
                                              DateTime?
                                                  customerCardStatisfactionDate;

                                              if (widget.satisfiedCustomersCards
                                                      .repaymentsDates[index] !=
                                                  null) {
                                                customerCardStatisfactionDate =
                                                    DateTime.parse(widget
                                                        .satisfiedCustomersCards
                                                        .repaymentsDates[index]);
                                              } else if (widget
                                                          .satisfiedCustomersCards
                                                          .satisfactionsDates[
                                                      index] !=
                                                  null) {
                                                customerCardStatisfactionDate =
                                                    DateTime.parse(widget
                                                        .satisfiedCustomersCards
                                                        .satisfactionsDates[index]);
                                              } else if (widget
                                                      .satisfiedCustomersCards
                                                      .transfersDates[index] !=
                                                  null) {
                                                customerCardStatisfactionDate =
                                                    DateTime.parse(widget
                                                        .satisfiedCustomersCards
                                                        .transfersDates[index]);
                                              }

                                              return CBText(
                                                text: customerCardStatisfactionDate !=
                                                        null
                                                    ? format.format(
                                                        customerCardStatisfactionDate)
                                                    : '',
                                                textAlign: TextAlign.center,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w500,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  rowSeparatorWidget: const Divider(),
                                  scrollPhysics: const BouncingScrollPhysics(),
                                  horizontalScrollPhysics:
                                      const BouncingScrollPhysics(),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
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
            CBIconButton(
              icon: Icons.print,
              text: 'Imprimer',
              onTap: () {},
            ),
          ],
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
