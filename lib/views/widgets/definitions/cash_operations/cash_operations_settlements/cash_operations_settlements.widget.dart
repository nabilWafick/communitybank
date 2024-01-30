import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/settlements/settlements_crud.function.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/agents/agents.widgets.dart';
import 'package:communitybank/views/widgets/definitions/cash_operations/cash_operations_search_options/cash_operations_search_options.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards_list/customers_cards_list.widget.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/settlements/settlements_deletion_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/update/settlement/settlement_update_form.widget.dart';
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

  @override
  Widget build(BuildContext context) {
    final cashOperationsSelectedCustomerAccountOwnerSelectedCard = ref
        .watch(cashOperationsSelectedCustomerAccountOwnerSelectedCardProvider);
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
      height: 370.0,
      width: double.infinity,
      child: SingleChildScrollView(
        child: DataTable(
            columns: const [
              DataColumn(
                label: CBText(
                  text: 'Code',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Carte',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Nombre de Mise',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Montant',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Date Collecte',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Date Saisie',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Agent',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
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
                            text: settlement.id!.toString(),
                          ),
                        ),
                        DataCell(Consumer(
                          builder: (context, ref, child) {
                            final customersCardsListStream =
                                ref.watch(customersCardsListStreamProvider);

                            return customersCardsListStream.when(
                              data: (data) {
                                final realTimeCustomerCardData =
                                    data.firstWhere(
                                  (customerCard) =>
                                      customerCard.id == settlement.cardId,
                                );
                                return CBText(
                                  text: realTimeCustomerCardData.label,
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
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataCell(
                          Center(
                            child: CBText(
                              text:
                                  '${settlement.number * cashOperationsSelectedCustomerAccountOwnerSelectedCardType!.stake.ceil()}',
                            ),
                          ),
                        ),
                        DataCell(
                          CBText(
                            text:
                                '${format.format(settlement.collectedAt)} ${settlement.collectedAt.hour}:${settlement.collectedAt.minute}',
                          ),
                        ),
                        DataCell(
                          CBText(
                            text:
                                '${format.format(settlement.createdAt)} ${settlement.createdAt.hour}:${settlement.createdAt.minute}',
                          ),
                        ),
                        DataCell(Consumer(
                          builder: (context, ref, child) {
                            final agentListStream =
                                ref.watch(agentsListStreamProvider);

                            return agentListStream.when(
                              data: (data) {
                                final realTimeAgentData = data.firstWhere(
                                  (agent) => agent.id == settlement.agentId,
                                );
                                return CBText(
                                  text:
                                      '${realTimeAgentData.firstnames} ${realTimeAgentData.name}',
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
                          onTap: () async {
                            await FunctionsController.showAlertDialog(
                              context: context,
                              alertDialog:
                                  SettlementUpdateForm(settlement: settlement),
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
                              alertDialog: SettlementDeletionConfirmationDialog(
                                settlement: settlement,
                                confirmToDelete: SettlementCRUDFunctions.delete,
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
    );
  }
}
