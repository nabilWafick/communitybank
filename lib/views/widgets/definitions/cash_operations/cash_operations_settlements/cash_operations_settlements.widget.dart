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
import 'package:horizontal_data_table/horizontal_data_table.dart';
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

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 30.0),
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
        child: cashOperationsSelectedCustomerAccountOwnerSelectedCardSettlements
            .when(
          data: (data) => HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: MediaQuery.of(context).size.width + 850,
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
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Carte',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Mise',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
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
                  text: 'Date de collecte',
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
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
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
              final settlement = data[index];
              return Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 200.0,
                    height: 30.0,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final customersCardsListStream =
                            ref.watch(customersCardsListStreamProvider);

                        return customersCardsListStream.when(
                          data: (data) {
                            final realTimeCustomerCardData = data.firstWhere(
                              (customerCard) =>
                                  customerCard.id == settlement.cardId,
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
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 200.0,
                    height: 30.0,
                    child: CBText(
                      text: settlement.number.toString(),
                      fontSize: 12.0,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 200.0,
                    height: 30.0,
                    child: CBText(
                      text:
                          '${settlement.number * cashOperationsSelectedCustomerAccountOwnerSelectedCardType!.stake.ceil()}',
                      fontSize: 12.0,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 30.0,
                    child: CBText(
                      text:
                          '${format.format(settlement.collectedAt)} ${settlement.collectedAt.hour}:${settlement.collectedAt.minute}',
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 30.0,
                    child: CBText(
                      text:
                          '${format.format(settlement.createdAt)} ${settlement.createdAt.hour}:${settlement.createdAt.minute}',
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: Consumer(
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
                                  ' ${realTimeAgentData.name} ${realTimeAgentData.firstnames}',
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
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      FunctionsController.showAlertDialog(
                        context: context,
                        alertDialog:
                            SettlementValidationStatusUpdateConfirmationDialog(
                          settlement: settlement,
                          confirmToDelete:
                              SettlementCRUDFunctions.updateValidationStatus,
                        ),
                      );
                    },
                    child: Container(
                      width: 150.0,
                      height: 30.0,
                      alignment: Alignment.center,
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
                  InkWell(
                    onTap: () async {
                      await FunctionsController.showAlertDialog(
                        context: context,
                        alertDialog:
                            SettlementUpdateForm(settlement: settlement),
                      );
                    },
                    child: Container(
                      width: 150.0,
                      height: 30.0,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.edit,
                        color: Colors.green[500],
                      ),
                    ),
                    // showEditIcon: true,
                  ),
                  InkWell(
                    onTap: () async {
                      await FunctionsController.showAlertDialog(
                        context: context,
                        alertDialog: SettlementDeletionConfirmationDialog(
                          settlement: settlement,
                          confirmToDelete: SettlementCRUDFunctions.delete,
                        ),
                      );
                    },
                    child: Container(
                      width: 150.0,
                      height: 30.0,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.delete_sharp,
                        color: Colors.red,
                      ),
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
                child: const CBText(
                  text: 'Carte',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Mise',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
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
                  text: 'Date de collecte',
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
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
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
                child: const CBText(
                  text: 'Carte',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Mise',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
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
                  text: 'Date de collecte',
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
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
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
