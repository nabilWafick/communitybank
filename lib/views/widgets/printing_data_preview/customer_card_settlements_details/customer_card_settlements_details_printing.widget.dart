// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/customer_card_settlement_detail/customer_card_settlement_detail.controller.dart';
import 'package:communitybank/models/data/customer_card_settlement_detail/customer_card_settlement_detail.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/cash/cash_operations/cash_operations_search_options/cash_operations_search_options.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:communitybank/views/widgets/printing_data_preview/customer_card_settlements_details/generate_and_print_customer_card_settlements_details_pdf.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

final customerCardSettlementsDetailsProvider =
    FutureProvider.family<List<CustomerCardSettlementDetail>, int>(
        (ref, customerCardId) async {
  return await CustomerCardSettlementsDetailsController
      .getCustomerCardSettlementsDetails(
    customerCardId: customerCardId,
  );
});

class CustomerCardSettlementsDetailsPrintingPreview
    extends StatefulHookConsumerWidget {
  const CustomerCardSettlementsDetailsPrintingPreview({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomerCardSettlementsDetailsPrintingPreviewState();
}

class _CustomerCardSettlementsDetailsPrintingPreviewState
    extends ConsumerState<CustomerCardSettlementsDetailsPrintingPreview> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    const formCardWidth = 1500.0;
    final cashOperationsSelectedCustomerAccountOwner =
        ref.watch(cashOperationsSelectedCustomerAccountOwnerProvider);
    final cashOperationsSelectedCustomerAccountOwnerSelectedCard = ref
        .watch(cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider);
    final cashOperationsSelectedCustomerAccountOwnerSelectedCardType =
        ref.watch(
            cashOperationsSelectedCustomerAccountOwnerSelectedCardTypeProvider);
    final customerCardSettlementsDetailsList = ref.watch(
      customerCardSettlementsDetailsProvider(
        cashOperationsSelectedCustomerAccountOwnerSelectedCard!.id!,
      ),
    );

    final format = DateFormat.yMMMMEEEEd('fr');
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      content: Container(
        padding: const EdgeInsets.all(20.0),
        width: formCardWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CBText(
                  text: 'Situation du client',
                  fontSize: 17.0,
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
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              child: OtherInfos(
                  label: 'Client',
                  value:
                      '${cashOperationsSelectedCustomerAccountOwner!.name} ${cashOperationsSelectedCustomerAccountOwner.firstnames}'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OtherInfos(
                  label: 'Carte',
                  value: cashOperationsSelectedCustomerAccountOwnerSelectedCard
                      .label,
                ),
                OtherInfos(
                  label: 'Nombre Type',
                  value: cashOperationsSelectedCustomerAccountOwnerSelectedCard
                      .typeNumber
                      .toString(),
                )
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OtherInfos(
                  label: 'Type',
                  value:
                      cashOperationsSelectedCustomerAccountOwnerSelectedCardType!
                          .name,
                ),
                OtherInfos(
                  label: 'Mise',
                  value:
                      '${cashOperationsSelectedCustomerAccountOwnerSelectedCardType.stake.ceil()}f',
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              alignment: Alignment.center,
              child: CBIconButton(
                icon: Icons.refresh,
                text: 'Rafraichir',
                onTap: () {
                  ref.invalidate(customerCardSettlementsDetailsProvider);
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: 460.0,
              margin: const EdgeInsets.only(
                top: 10.0,
                bottom: 20.0,
              ),
              //  color: Colors.blueGrey,
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
            Consumer(
              builder: (context, ref, child) {
                double settlementAmountsTotal = 0;

                return customerCardSettlementsDetailsList.when(
                    data: (data) {
                      for (CustomerCardSettlementDetail customerCardSettlementDetail
                          in data) {
                        settlementAmountsTotal +=
                            customerCardSettlementDetail.settlementAmount;
                      }
                      return Container(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const CBText(
                              text: 'Total: ',
                              fontSize: 12.0,
                            ),
                            CBText(
                              text: '${settlementAmountsTotal.ceil()} f',
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      );
                    },
                    error: (error, stackTrace) => Container(
                          alignment: Alignment.centerRight,
                          child: const CBText(
                            text: 'Total: ',
                            fontSize: 12.0,
                          ),
                        ),
                    loading: () => Container(
                          alignment: Alignment.centerRight,
                          child: const CBText(
                            text: 'Total: ',
                            fontSize: 12.0,
                          ),
                        ));
              },
            ),
            const SizedBox(
              height: 30.0,
            ),
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
                SizedBox(
                  width: 170.0,
                  child: CBElevatedButton(
                    text: 'Imprimer',
                    onPressed: () async {
                      final customerCardSettlementsDetails =
                          await CustomerCardSettlementsDetailsController
                              .getCustomerCardSettlementsDetails(
                        customerCardId:
                            cashOperationsSelectedCustomerAccountOwnerSelectedCard
                                .id!,
                      );
                      // generate pdf file and print it

                      await generateAndPrintCustomerCardSettlementsDetailsPdf(
                        context: context,
                        format: format,
                        customer: cashOperationsSelectedCustomerAccountOwner,
                        customerCard:
                            cashOperationsSelectedCustomerAccountOwnerSelectedCard,
                        customerCardType:
                            cashOperationsSelectedCustomerAccountOwnerSelectedCardType,
                        customerCardSettlementsDetails:
                            customerCardSettlementsDetails,
                      );
                    },
                  ),
                )
              ],
            ),
          ],
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
