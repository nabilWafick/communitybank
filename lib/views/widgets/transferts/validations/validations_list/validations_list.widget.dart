import 'package:communitybank/controllers/transfers/transfers.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/transfer/transfer.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/agents/agents.widgets.dart';
import 'package:communitybank/views/widgets/definitions/customers/customers_list/customers_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_accounts/customers_accounts_list/customers_accounts_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards_list/customers_cards_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/types/types_list/types_list.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/agent/agent_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_account/customer_account_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_card/customer_card_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

final transfersValidationsListStreamProvider =
    StreamProvider<List<Transfer>>((ref) async* {
  final selectedIssuingCustomerCard = ref.watch(
    listCustomerCardDropdownProvider(
        'transfer-between-customer-cards-issuing-card'),
  );
  final selectedReceivingCustomerCard = ref.watch(
    listCustomerCardDropdownProvider(
        'transfer-between-customer-cards-receiving-card'),
  );

  /*final selectedCustomerAccount = ref.watch(
    listCustomerAccountDropdownProvider(
        'transfer-between-customer-cards-customer-account'),
  );
*/
  final selectedAgent = ref.watch(
    listAgentDropdownProvider('transfer-between-customer-cards-agent'),
  );

  yield* TransfersController.getAll(
    issuingCustomerCardId: selectedIssuingCustomerCard.id,
    receivingCustomerCardId: selectedReceivingCustomerCard.id,
    agentId: selectedAgent.id,
  );
});

class TransfersValidationsList extends ConsumerStatefulWidget {
  const TransfersValidationsList({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransfersValidationsListState();
}

class _TransfersValidationsListState
    extends ConsumerState<TransfersValidationsList> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  final ScrollController verticalScrollController = ScrollController();
  final ScrollController horizontalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final transfersValidationsListStream =
        ref.watch(transfersValidationsListStreamProvider);
    final customersAccountsListStream =
        ref.watch(customersAccountsListStreamProvider);
    final typesListStream = ref.watch(typesListStreamProvider);
    final customersListStream = ref.watch(customersListStreamProvider);

    final format = DateFormat.yMMMMEEEEd('fr');

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: transfersValidationsListStream.when(
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
                width: 400.0,
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
                  text: 'Carte Émettrice',
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
                  text: 'Type Carte',
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
                  text: 'Carte Réceptrice',
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
                  text: 'Type Carte',
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
                  text: 'Date d\'instance',
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
              final transfer = data[index];
              return Row(
                children: [
                  // customer
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: Consumer(
                      builder: (context, ref, child) {
                        return customersAccountsListStream.when(
                          data: (data) {
                            final realTimeCustomerAccountData = data.firstWhere(
                              (customerAccount) =>
                                  customerAccount.id ==
                                  transfer.issuingCustomerCardId,
                            );

                            final String realTimeCustomer =
                                customersListStream.when(
                              data: (data) {
                                final accountOwner =
                                    data.firstWhere((customer) {
                                  return customer.id ==
                                      realTimeCustomerAccountData.customerId;
                                });

                                return '${accountOwner.name} ${accountOwner.firstnames}';
                              },
                              error: (error, stackTrace) => '',
                              loading: () => '',
                            );

                            return CBText(
                              text: realTimeCustomer,
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

                  // issuing customer card
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 30.0,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final customersCardsListStream =
                            ref.watch(customersCardsListStreamProvider);

                        return customersCardsListStream.when(
                          data: (data) {
                            final realTimeCustomerCardData = data.firstWhere(
                              (customerCard) =>
                                  customerCard.id ==
                                  transfer.issuingCustomerCardId,
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

                  // issuing card type
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 30.0,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final customersCardsListStream =
                            ref.watch(customersCardsListStreamProvider);

                        return customersCardsListStream.when(
                          data: (data) {
                            final realTimeCustomerCardData = data.firstWhere(
                              (customerCard) =>
                                  customerCard.id ==
                                  transfer.issuingCustomerCardId,
                            );

                            final String realTimeType = typesListStream.when(
                              data: (data) {
                                final customerCardType =
                                    data.firstWhere((type) {
                                  return type.id ==
                                      realTimeCustomerCardData.typeId;
                                });

                                return customerCardType.name;
                              },
                              error: (error, stackTrace) => '',
                              loading: () => '',
                            );

                            return CBText(
                              text: realTimeType,
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

                  // receiving customer card
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 30.0,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final customersCardsListStream =
                            ref.watch(customersCardsListStreamProvider);

                        return customersCardsListStream.when(
                          data: (data) {
                            final realTimeCustomerCardData = data.firstWhere(
                              (customerCard) =>
                                  customerCard.id ==
                                  transfer.receivingCustomerCardId,
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

                  // receiving card type
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 30.0,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final customersCardsListStream =
                            ref.watch(customersCardsListStreamProvider);

                        return customersCardsListStream.when(
                          data: (data) {
                            final realTimeCustomerCardData = data.firstWhere(
                              (customerCard) =>
                                  customerCard.id ==
                                  transfer.receivingCustomerCardId,
                            );

                            final String realTimeType = typesListStream.when(
                              data: (data) {
                                final customerCardType =
                                    data.firstWhere((type) {
                                  return type.id ==
                                      realTimeCustomerCardData.typeId;
                                });

                                return customerCardType.name;
                              },
                              error: (error, stackTrace) => '',
                              loading: () => '',
                            );

                            return CBText(
                              text: realTimeType,
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

                  Consumer(
                    builder: (context, ref, child) {
                      final formatedTime = FunctionsController.getFormatedTime(
                        dateTime: transfer.createdAt,
                      );
                      return Container(
                        alignment: Alignment.centerLeft,
                        width: 300.0,
                        height: 30.0,
                        child: CBText(
                          text:
                              '${format.format(transfer.createdAt)} $formatedTime',
                          fontSize: 12.0,
                        ),
                      );
                    },
                  ),

                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 30.0,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final agentListStream =
                            ref.watch(agentsListStreamProvider);

                        return agentListStream.when(
                          data: (data) {
                            final realTimeAgentData = data.firstWhere(
                              (agent) => agent.id == transfer.agentId,
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
                      /*    FunctionsController.showAlertDialog(
                        context: context,
                        alertDialog:
                            SettlementValidationStatusUpdateConfirmationDialog(
                          settlement: settlement,
                          confirmToDelete:
                              SettlementCRUDFunctions.updateValidationStatus,
                        ),
                      );*/
                    },
                    child: Container(
                      width: 150.0,
                      height: 30.0,
                      alignment: Alignment.center,
                      child: transfer.validatedAt != null
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
                      /*   await FunctionsController.showAlertDialog(
                        context: context,
                        alertDialog: SettlementDeletionConfirmationDialog(
                          settlement: settlement,
                          confirmToDelete: SettlementCRUDFunctions.delete,
                        ),
                      );*/
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
            rightHandSideColumnWidth: 1500,
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
                width: 400.0,
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
                  text: 'Carte Émettrice',
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
                  text: 'Type Carte',
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
                  text: 'Carte Réceptrice',
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
                  text: 'Type Carte',
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
                  text: 'Date d\'instance',
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
                width: 400.0,
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
                  text: 'Carte Émettrice',
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
                  text: 'Type Carte',
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
                  text: 'Carte Réceptrice',
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
                  text: 'Type Carte',
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
                  text: 'Date d\'instance',
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
