import 'package:communitybank/controllers/transfers_details/transfers_details.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/transfer_detail/transfer_detail.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/agent/agent_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/collector/collector_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_account/customer_account_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_card/customer_card_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/type/type_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:communitybank/views/widgets/globals/tooltip/tooltip.widget.dart';
import 'package:communitybank/views/widgets/transferts/validations/validations_sort_options/validations_sort_options.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

final transfersValidationsListStreamProvider =
    StreamProvider<List<TransferDetail>>((ref) async* {
  final selectedTransferCreationDate =
      ref.watch(selectedTransferCreationDateProvider);

  final selectedTransferValidationDate =
      ref.watch(selectedTransferValidationDateProvider);

  final selectedIssuingCustomerAccount = ref.watch(
    listCustomerAccountDropdownProvider(
      'transfers-validations-issuing-customer-account',
    ),
  );

  final selectedReceivingCustomerAccount = ref.watch(
    listCustomerAccountDropdownProvider(
      'transfers-validations-receiving-customer-account',
    ),
  );

  final selectedIssuingCustomerCard = ref.watch(
    listCustomerCardDropdownProvider(
      'transfers-validations-issuing-card',
    ),
  );
  final selectedReceivingCustomerCard = ref.watch(
    listCustomerCardDropdownProvider(
      'transfers-validations-receiving-card',
    ),
  );

  final selectedIssuingCustomerCardType = ref.watch(
    listTypeDropdownProvider(
      'transfers-validations-issuing-card-type',
    ),
  );
  final selectedReceivingCustomerCardType = ref.watch(
    listTypeDropdownProvider(
      'transfers-validations-receiving-card-type',
    ),
  );
  final selectedIssuingCustomerCollector = ref.watch(
    listCollectorDropdownProvider(
        'transfers-validations-issuing-customer-collector'),
  );

  final selectedReceivingCustomerCollector = ref.watch(
    listCollectorDropdownProvider(
        'transfers-validations-issuing-customer-collector'),
  );

  final selectedAgent = ref.watch(
    listAgentDropdownProvider('transfers-validations-agent'),
  );

  yield* TransfersDetailsController.getTransfersDetails(
    agentId: selectedAgent.id != 0 ? selectedAgent.id : null,
    validationDate: selectedTransferCreationDate != null
        ? FunctionsController.getFormatedTime(
            dateTime: selectedTransferCreationDate)
        : null,
    creationDate: selectedTransferValidationDate != null
        ? FunctionsController.getFormatedTime(
            dateTime: selectedTransferValidationDate)
        : null,
    issuingCustomerCardId: selectedIssuingCustomerCard.id != 0
        ? selectedIssuingCustomerCard.id
        : null,
    issuingCustomerCardTypeId: selectedIssuingCustomerCardType.id != 0
        ? selectedIssuingCustomerCardType.id
        : null,
    issuingCustomerAccountId: selectedIssuingCustomerAccount.id != 0
        ? selectedIssuingCustomerAccount.id
        : null,
    issuingCustomerCollectorId: selectedIssuingCustomerCollector.id != 0
        ? selectedIssuingCustomerCollector.id
        : null,
    receivingCustomerCardId: selectedReceivingCustomerCard.id != 0
        ? selectedReceivingCustomerCard.id
        : null,
    receivingCustomerCardTypeId: selectedReceivingCustomerCardType.id != 0
        ? selectedReceivingCustomerCardType.id
        : null,
    receivingCustomerAccountId: selectedReceivingCustomerAccount.id != 0
        ? selectedReceivingCustomerAccount.id
        : null,
    receivingCustomerCollectorId: selectedReceivingCustomerCollector.id != 0
        ? selectedReceivingCustomerCollector.id
        : null,
  ).asStream();
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

    final format = DateFormat.yMMMMEEEEd('fr');

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: transfersValidationsListStream.when(
          data: (data) => HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: MediaQuery.of(context).size.width + 1950,
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
                  text: 'Chargé de Compte Émetteur',
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
                  text: 'Client Émetteur',
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
                  text: 'Type Émetteur',
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
                  text: 'Chargé de Compte Récepteur',
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
                  text: 'Client Récepteur',
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
                  text: 'Type Récepteur',
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
                  text: 'Date de transfert',
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
                  text: 'Date de validation',
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
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Statut',
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
                height: 40.0,
                child: CBText(
                  text: '${index + 1}',
                  fontSize: 12.0,
                ),
              );
            },
            rightSideItemBuilder: (BuildContext context, int index) {
              final transferDetail = data[index];
              return Row(
                children: [
                  // customer collector
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 40.0,
                    child: CBText(
                      text: FunctionsController.truncateText(
                        text: transferDetail.issuingCustomerCollector,
                        maxLength: 20,
                      ),
                      fontSize: 12.0,
                    ),
                  ),
                  // customer
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 40.0,
                    child: CBText(
                      text: FunctionsController.truncateText(
                        text: transferDetail.issuingCustomer,
                        maxLength: 20,
                      ),
                      fontSize: 12.0,
                    ),
                  ),

                  // issuing customer card
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 40.0,
                    child: CBText(
                      text: transferDetail.issuingCustomerCardLabel,
                      fontSize: 12.0,
                    ),
                  ),

                  // issuing card type
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 40.0,
                    child: CBText(
                      text: transferDetail.issuingCustomerCardTypeName,
                      fontSize: 12.0,
                    ),
                  ),

                  // receiving customer collector
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 40.0,
                    child: CBText(
                      text: FunctionsController.truncateText(
                        text: transferDetail.receivingCustomerCollector,
                        maxLength: 20,
                      ),
                      fontSize: 12.0,
                    ),
                  ),

                  // receiving customer
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 40.0,
                    child: CBText(
                      text: FunctionsController.truncateText(
                        text: transferDetail.receivingCustomer,
                        maxLength: 20,
                      ),
                      fontSize: 12.0,
                    ),
                  ),
                  // receiving customer card
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 40.0,
                    child: CBText(
                      text: transferDetail.receivingCustomerCardLabel,
                      fontSize: 12.0,
                    ),
                  ),

                  // receiving card type
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 40.0,
                    child: CBText(
                      text: transferDetail.receivingCustomerCardTypeName,
                      fontSize: 12.0,
                    ),
                  ),

                  Consumer(
                    builder: (context, ref, child) {
                      final formatedTime = FunctionsController.getFormatedTime(
                        dateTime: transferDetail.createdAt,
                      );
                      return Container(
                        alignment: Alignment.centerLeft,
                        width: 300.0,
                        height: 40.0,
                        child: CBText(
                          text:
                              '${format.format(transferDetail.createdAt)} $formatedTime',
                          fontSize: 12.0,
                        ),
                      );
                    },
                  ),

                  Consumer(
                    builder: (context, ref, child) {
                      final formatedTime = transferDetail.validatedAt != null
                          ? FunctionsController.getFormatedTime(
                              dateTime: transferDetail.validatedAt!,
                            )
                          : '';
                      return Container(
                        alignment: Alignment.centerLeft,
                        width: 300.0,
                        height: 40.0,
                        child: CBText(
                          text: transferDetail.validatedAt != null
                              ? '${format.format(transferDetail.validatedAt!)} $formatedTime'
                              : '',
                          fontSize: 12.0,
                        ),
                      );
                    },
                  ),
                  // agent
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 40.0,
                    child: CBText(
                      text: transferDetail.agent,
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 200.0,
                    height: 40.0,
                    child: Card(
                      color: transferDetail.validatedAt == null
                          ? Colors.orange.shade700 //.withOpacity(.8)
                          : transferDetail.validatedAt!.year != 1970
                              ? Colors.green.shade700
                              : Colors.red.shade700,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                        child: CBText(
                          text: transferDetail.validatedAt == null
                              ? 'En attente'
                              : transferDetail.validatedAt!.year != 1970
                                  ? 'Validé'
                                  : 'Rejeté',
                          fontSize: 10.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          /* color: transferDetail.validatedAt == null
                              ? Colors.orange.shade700
                              : transferDetail.validatedAt!.year != 1970
                                  ? Colors.green.shade700
                                  : Colors.red.shade700,*/
                        ),
                      ),
                    ),
                  ),
                  /*  InkWell(
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
                      height: 40.0,
                      alignment: Alignment.center,
                      child: transferDetail.validatedAt != null
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
                */

                  Container(
                    width: 150.0,
                    height: 40.0,
                    alignment: Alignment.center,
                    child: transferDetail.validatedAt == null
                        ? CBToolTip(
                            options: [
                              CBToolTipOption(
                                icon: Icons.check,
                                iconColor: Colors.green.shade700,
                                name: 'Validé',
                                onTap: () {},
                              ),
                              CBToolTipOption(
                                icon: Icons.close,
                                iconColor: Colors.red.shade700,
                                name: 'Rejeté',
                                onTap: () {},
                              )
                            ],
                          )
                        : const SizedBox(),
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
                      height: 40.0,
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
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Client Émetteur',
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
                  text: 'Type Émetteur',
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
                  text: 'Client Récepteur',
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
                  text: 'Type Récepteur',
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
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Statut',
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
                height: 40.0,
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
                  text: 'Client Émetteur',
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
                  text: 'Type Émetteur',
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
                  text: 'Client Récepteur',
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
                  text: 'Type Récepteur',
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
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Statut',
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
                height: 40.0,
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
