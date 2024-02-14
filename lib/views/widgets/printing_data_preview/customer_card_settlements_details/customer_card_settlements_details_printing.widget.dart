import 'package:communitybank/controllers/customer_card_settlement_detail/customer_card_settlement_detail.controller.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/models/data/type/type.model.dart';
import 'package:communitybank/models/data/customer_card_settlement_detail/customer_card_settlement_detail.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
  final CustomerCard customerCard;
  final Type type;

  const CustomerCardSettlementsDetailsPrintingPreview({
    super.key,
    required this.customerCard,
    required this.type,
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
    const formCardWidth = 1000.0;
    final customerCardSettlementsDetailsList = ref.watch(
      customerCardSettlementsDetailsProvider(
        widget.customerCard.id!,
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
            const SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OtherInfos(
                  label: 'Carte',
                  value: widget.customerCard.label,
                ),
                OtherInfos(
                  label: 'Nombre Type',
                  value: widget.customerCard.typeNumber.toString(),
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
                  value: widget.type.name,
                ),
                OtherInfos(
                  label: 'Mise',
                  value: '${widget.type.stake.ceil()}f',
                ),
              ],
            ),
            const SizedBox(
              height: 25.0,
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
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 500.0,
              child: SingleChildScrollView(
                child: DataTable(
                  columns: const [
                    DataColumn(
                      label: CBText(
                        text: 'Date de Collecte',
                        textAlign: TextAlign.start,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    DataColumn(
                      label: CBText(
                        text: 'Nombre Mise',
                        textAlign: TextAlign.start,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    DataColumn(
                      label: CBText(
                        text: 'Montant',
                        textAlign: TextAlign.start,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    DataColumn(
                      label: CBText(
                        text: 'Date Saisie',
                        textAlign: TextAlign.start,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    DataColumn(
                      label: CBText(
                        text: 'Agent',
                        textAlign: TextAlign.start,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  rows: customerCardSettlementsDetailsList.when(
                    data: (data) => data
                        .map(
                          (customerCardSettlementDetail) => DataRow(
                            cells: [
                              DataCell(
                                CBText(
                                  text: format.format(
                                      customerCardSettlementDetail
                                          .settlementDate),
                                  fontSize: 12.0,
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: CBText(
                                    text: customerCardSettlementDetail
                                        .settlementNumber
                                        .toString(),
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              DataCell(
                                CBText(
                                  text: customerCardSettlementDetail
                                      .settlementAmount
                                      .ceil()
                                      .toString(),
                                  fontSize: 12.0,
                                ),
                              ),
                              DataCell(
                                CBText(
                                  text: format.format(
                                      customerCardSettlementDetail
                                          .settlementDate),
                                  fontSize: 12.0,
                                ),
                              ),
                              DataCell(
                                CBText(
                                  text:
                                      '${customerCardSettlementDetail.agentName} ${customerCardSettlementDetail.agentFirstname}',
                                  fontSize: 12.0,
                                ),
                              )
                            ],
                          ),
                        )
                        .toList(),
                    error: (error, stackTrace) => [],
                    loading: () => [],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 35.0,
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
                    onPressed: () {},
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
