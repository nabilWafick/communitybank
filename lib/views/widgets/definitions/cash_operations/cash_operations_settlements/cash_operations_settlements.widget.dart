import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/settlements/settlements_crud.function.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/agents/agents.widgets.dart';
import 'package:communitybank/views/widgets/definitions/cash_operations/cash_operations_search_options/cash_operations_search_options.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards_list/customers_cards_list.widget.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/settlements/settlements_deletion_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/update/settlement/settlement_update_form.widget.dart';
import 'package:communitybank/views/widgets/forms/update_confirmation_dialog/settlement/settlement_validation_status_update_confirmation_dialog.widegt.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class CashOperationsSettlements extends StatefulHookConsumerWidget {
  const CashOperationsSettlements({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CashOperationsSettlementsState();
}

class _CashOperationsSettlementsState
    extends ConsumerState<CashOperationsSettlements> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  final ScrollController verticalScrollController = ScrollController();
  final ScrollController horizontalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final cashOperationsSelectedCustomerAccountOwnerSelectedCardSettlements =
        ref.watch(
      cashOperationsSelectedCustomerAccountOwnerSelectedCardSettlementsProvider,
    );
    final cashOperationsSelectedCustomerAccountOwnerSelectedCardType =
        ref.watch(
            cashOperationsSelectedCustomerAccountOwnerSelectedCardTypeProvider);

    final format = DateFormat.yMMMMEEEEd('fr');

    return Container(
      decoration: BoxDecoration(
        //  color: Colors.blueAccent,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(
            15.0,
          ),
          topRight: Radius.circular(
            15.0,
          ),
        ),
        border: Border.all(
          color: CBColors.sidebarTextColor.withOpacity(.5),
          width: 1.5,
        ),
      ),
      height: 350.0,
      width: double.infinity,
      child: Scrollbar(
        controller: horizontalScrollController,
        child: SingleChildScrollView(
          controller: horizontalScrollController,
          scrollDirection: Axis.horizontal,
          child: Scrollbar(
            controller: verticalScrollController,
            child: SingleChildScrollView(
              controller: verticalScrollController,
              child: DataTable(
                  columns: const [
                    DataColumn(
                      label: CBText(
                        text: 'Code',
                        textAlign: TextAlign.start,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    DataColumn(
                      label: CBText(
                        text: 'Carte',
                        textAlign: TextAlign.start,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    DataColumn(
                      label: CBText(
                        text: 'Mise',
                        textAlign: TextAlign.start,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    DataColumn(
                      label: CBText(
                        text: 'Montant',
                        textAlign: TextAlign.start,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    DataColumn(
                      label: CBText(
                        text: 'Date Collecte',
                        textAlign: TextAlign.start,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    DataColumn(
                      label: CBText(
                        text: 'Date Saisie',
                        textAlign: TextAlign.start,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    DataColumn(
                      label: CBText(
                        text: 'Agent',
                        textAlign: TextAlign.start,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(),
                    ),
                    DataColumn(
                      label: SizedBox(),
                    ),
                    DataColumn(
                      label: SizedBox(),
                    ),
                  ],
                  rows:
                      cashOperationsSelectedCustomerAccountOwnerSelectedCardSettlements
                          .when(
                    data: (data) => data
                        .map(
                          (settlement) => DataRow(
                            cells: [
                              DataCell(
                                CBText(
                                  text: '${data.indexOf(settlement) + 1}',
                                  fontSize: 12.0,
                                ),
                              ),
                              DataCell(Consumer(
                                builder: (context, ref, child) {
                                  final customersCardsListStream = ref
                                      .watch(customersCardsListStreamProvider);

                                  return customersCardsListStream.when(
                                    data: (data) {
                                      final realTimeCustomerCardData =
                                          data.firstWhere(
                                        (customerCard) =>
                                            customerCard.id ==
                                            settlement.cardId,
                                      );
                                      return CBText(
                                        text: realTimeCustomerCardData.label,
                                        fontSize: 12.0,
                                      );
                                    },
                                    error: (error, stackTrace) => const CBText(
                                      text: '',
                                    ),
                                    loading: () => const CBText(
                                      text: '',
                                    ),
                                  );
                                },
                              )),
                              DataCell(
                                Center(
                                  child: CBText(
                                    text: settlement.number.toString(),
                                    fontSize: 12.0,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: CBText(
                                    text:
                                        '${settlement.number * cashOperationsSelectedCustomerAccountOwnerSelectedCardType!.stake.ceil()}',
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              DataCell(
                                CBText(
                                  text:
                                      '${format.format(settlement.collectedAt)} ${settlement.collectedAt.hour}:${settlement.collectedAt.minute}',
                                  fontSize: 12.0,
                                ),
                              ),
                              DataCell(
                                CBText(
                                  text:
                                      '${format.format(settlement.createdAt)} ${settlement.createdAt.hour}:${settlement.createdAt.minute}',
                                  fontSize: 12.0,
                                ),
                              ),
                              DataCell(
                                Consumer(
                                  builder: (context, ref, child) {
                                    final agentListStream =
                                        ref.watch(agentsListStreamProvider);

                                    return agentListStream.when(
                                      data: (data) {
                                        final realTimeAgentData =
                                            data.firstWhere(
                                          (agent) =>
                                              agent.id == settlement.agentId,
                                        );
                                        return CBText(
                                          text:
                                              ' ${realTimeAgentData.name} ${realTimeAgentData.firstnames}',
                                          fontSize: 12.0,
                                        );
                                      },
                                      error: (error, stackTrace) =>
                                          const CBText(
                                        text: '',
                                      ),
                                      loading: () => const CBText(
                                        text: '',
                                      ),
                                    );
                                  },
                                ),
                              ),
                              DataCell(
                                onTap: () async {
                                  FunctionsController.showAlertDialog(
                                    context: context,
                                    alertDialog:
                                        SettlementValidationStatusUpdateConfirmationDialog(
                                      settlement: settlement,
                                      confirmToDelete: SettlementCRUDFunctions
                                          .updateValidationStatus,
                                    ),
                                  );
                                },
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: settlement.isValiated
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        )
                                      : const Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                ),
                                // showEditIcon: true,
                              ),
                              DataCell(
                                onTap: () async {
                                  await FunctionsController.showAlertDialog(
                                    context: context,
                                    alertDialog: SettlementUpdateForm(
                                        settlement: settlement),
                                  );
                                },
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  ),
                                ),
                                // showEditIcon: true,
                              ),
                              DataCell(
                                onTap: () async {
                                  await FunctionsController.showAlertDialog(
                                    context: context,
                                    alertDialog:
                                        SettlementDeletionConfirmationDialog(
                                      settlement: settlement,
                                      confirmToDelete:
                                          SettlementCRUDFunctions.delete,
                                    ),
                                  );
                                },
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: const Icon(
                                    Icons.delete_sharp,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                    error: (error, stackTrace) => [],
                    loading: () => [],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
