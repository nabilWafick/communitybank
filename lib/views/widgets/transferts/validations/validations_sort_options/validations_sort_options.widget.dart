//import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/agent/agent.model.dart';
import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/models/data/type/type.model.dart';
import 'package:communitybank/views/widgets/definitions/agents/agents.widgets.dart';
import 'package:communitybank/views/widgets/definitions/collectors/collectors_list/collectors_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_accounts/customers_accounts_list/customers_accounts_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/types/types_list/types_list.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/agent/agent_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/collector/collector_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_account/customer_account_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/type/type_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:communitybank/views/widgets/transferts/validations/validations_list/validations_list.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
//import 'package:intl/intl.dart';

final selectedTransferCreationDateProvider = StateProvider<DateTime?>((ref) {
  return;
});
final selectedTransferValidationDateProvider = StateProvider<DateTime?>((ref) {
  return;
});

final selectedTransferDiscardationDateProvider =
    StateProvider<DateTime?>((ref) {
  return;
});

class TransfersValidationsSortOptions extends StatefulHookConsumerWidget {
  const TransfersValidationsSortOptions({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransfersValidationsSortOptionsState();
}

class _TransfersValidationsSortOptionsState
    extends ConsumerState<TransfersValidationsSortOptions> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    //  final customersCardsWithOwnerListStream =
    //      ref.watch(customersCardsWithOwnerListStreamProvider);
    final customersAccountsListStream =
        ref.watch(customersAccountsListStreamProvider);
    final typesListStream = ref.watch(typesListStreamProvider);
    final collectorsListStream = ref.watch(collectorsListStreamProvider);
    final agentsListStream = ref.watch(agentsListStreamProvider);

    final selectedTransferCreationDate =
        ref.watch(selectedTransferCreationDateProvider);

    final selectedTransferValidationDate =
        ref.watch(selectedTransferValidationDateProvider);

    final selectedTransferDiscardationDate =
        ref.watch(selectedTransferDiscardationDateProvider);

    final format = DateFormat.yMMMMEEEEd('fr');
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
      width: double.maxFinite,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: CBIconButton(
                  icon: Icons.refresh,
                  text: 'Rafraichir',
                  onTap: () {
                    ref.invalidate(transfersValidationsListStreamProvider);
                  },
                ),
              ),
            ],
          ),
          Wrap(
            runSpacing: 10.0,
            spacing: 10.0,
            children: [
              SizedBox(
                width: 500.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CBIconButton(
                      icon: Icons.date_range,
                      text: 'Date de Transfert',
                      onTap: () async {
                        await FunctionsController.showDateTime(
                          context: context,
                          ref: ref,
                          stateProvider: selectedTransferCreationDateProvider,
                        );
                      },
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Flexible(
                      child: CBText(
                        text: selectedTransferCreationDate != null
                            ? format.format(selectedTransferCreationDate)
                            : '',
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    //   const SizedBox(),
                  ],
                ),
              ),
              SizedBox(
                width: 500.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CBIconButton(
                      icon: Icons.date_range,
                      text: 'Date de Validation',
                      onTap: () async {
                        await FunctionsController.showDateTime(
                          context: context,
                          ref: ref,
                          stateProvider: selectedTransferValidationDateProvider,
                        );
                      },
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Flexible(
                      child: CBText(
                        text: selectedTransferValidationDate != null
                            ? format.format(selectedTransferValidationDate)
                            : '',
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    //   const SizedBox(),
                  ],
                ),
              ),
              SizedBox(
                width: 500.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CBIconButton(
                      icon: Icons.date_range,
                      text: 'Date de Rejet',
                      onTap: () async {
                        await FunctionsController.showDateTime(
                          context: context,
                          ref: ref,
                          stateProvider:
                              selectedTransferDiscardationDateProvider,
                        );
                      },
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Flexible(
                      child: CBText(
                        text: selectedTransferDiscardationDate != null
                            ? format.format(selectedTransferDiscardationDate)
                            : '',
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    //   const SizedBox(),
                  ],
                ),
              ),
              CBListCustomerAccountDropdown(
                width: 270.0,
                menuHeigth: 500.0,
                label: 'Client Émetteur',
                providerName: 'transfers-validations-issuing-customer-account',
                dropdownMenuEntriesLabels: customersAccountsListStream.when(
                  data: (data) => [
                    CustomerAccount(
                      customerId: 0,
                      collectorId: 0,
                      customerCardsIds: [],
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data,
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
                dropdownMenuEntriesValues: customersAccountsListStream.when(
                  data: (data) => [
                    CustomerAccount(
                      customerId: 0,
                      collectorId: 0,
                      customerCardsIds: [],
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data,
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
              ),
              CBListCustomerAccountDropdown(
                width: 270.0,
                menuHeigth: 500.0,
                label: 'Client Récepteur',
                providerName:
                    'transfers-validations-receiving-customer-account',
                dropdownMenuEntriesLabels: customersAccountsListStream.when(
                  data: (data) => [
                    CustomerAccount(
                      customerId: 0,
                      collectorId: 0,
                      customerCardsIds: [],
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data,
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
                dropdownMenuEntriesValues: customersAccountsListStream.when(
                  data: (data) => [
                    CustomerAccount(
                      customerId: 0,
                      collectorId: 0,
                      customerCardsIds: [],
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data,
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
              ),
              CBListCollectorDropdown(
                width: 270.0,
                menuHeigth: 500.0,
                label: 'Chargé de compte Émetteur',
                providerName:
                    'transfers-validations-issuing-customer-collector',
                dropdownMenuEntriesLabels: collectorsListStream.when(
                  data: (data) => [
                    Collector(
                      name: 'Tous',
                      firstnames: '',
                      phoneNumber: '',
                      address: '',
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data,
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
                dropdownMenuEntriesValues: collectorsListStream.when(
                  data: (data) => [
                    Collector(
                      name: 'Tous',
                      firstnames: '',
                      phoneNumber: '',
                      address: '',
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data,
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
              ),
              CBListCollectorDropdown(
                width: 270.0,
                menuHeigth: 500.0,
                label: 'Chargé de compte Récepteur',
                providerName:
                    'transfers-validations-receiving-customer-collector',
                dropdownMenuEntriesLabels: collectorsListStream.when(
                  data: (data) => [
                    Collector(
                      name: 'Tous',
                      firstnames: '',
                      phoneNumber: '',
                      address: '',
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data,
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
                dropdownMenuEntriesValues: collectorsListStream.when(
                  data: (data) => [
                    Collector(
                      name: 'Tous',
                      firstnames: '',
                      phoneNumber: '',
                      address: '',
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data,
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
              ),
              /*  CBListCustomerCardDropdown(
                width: 270.0,
                menuHeigth: 500.0,
                label: 'Carte Émettrice',
                providerName: 'transfers-validations-issuing-card',
                dropdownMenuEntriesLabels:
                    customersCardsWithOwnerListStream.when(
                  data: (data) => [
                    CustomerCard(
                      label: 'Tous',
                      typeId: 0,
                      typeNumber: 1,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
                dropdownMenuEntriesValues:
                    customersCardsWithOwnerListStream.when(
                  data: (data) => [
                    CustomerCard(
                      label: 'Tous',
                      typeId: 0,
                      typeNumber: 1,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
              ),
           */
              CBListTypeDropdown(
                width: 270.0,
                menuHeigth: 500.0,
                label: 'Type Émetteur',
                providerName: 'transfers-validations-issuing-card-type',
                dropdownMenuEntriesLabels: typesListStream.when(
                  data: (data) => [
                    Type(
                      name: 'Tous',
                      stake: 0,
                      productsIds: [],
                      productsNumber: [],
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data,
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
                dropdownMenuEntriesValues: typesListStream.when(
                  data: (data) => [
                    Type(
                      name: 'Tous',
                      stake: 0,
                      productsIds: [],
                      productsNumber: [],
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data,
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
              ),
              CBListTypeDropdown(
                width: 270.0,
                menuHeigth: 500.0,
                label: 'Type Émetteur',
                providerName: 'transfers-validations-receiving-card-type',
                dropdownMenuEntriesLabels: typesListStream.when(
                  data: (data) => [
                    Type(
                      name: 'Tous',
                      stake: 0,
                      productsIds: [],
                      productsNumber: [],
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data,
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
                dropdownMenuEntriesValues: typesListStream.when(
                  data: (data) => [
                    Type(
                      name: 'Tous',
                      stake: 0,
                      productsIds: [],
                      productsNumber: [],
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data,
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
              ),
              CBListAgentDropdown(
                width: 270.0,
                menuHeigth: 500.0,
                label: 'Agent',
                providerName: 'transfers-validations-agent',
                dropdownMenuEntriesLabels: agentsListStream.when(
                  data: (data) => [
                    Agent(
                      name: 'Tous',
                      firstnames: '',
                      phoneNumber: '',
                      email: '',
                      address: '',
                      role: '',
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data,
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
                dropdownMenuEntriesValues: agentsListStream.when(
                  data: (data) => [
                    Agent(
                      name: 'Tous',
                      firstnames: '',
                      phoneNumber: '',
                      email: '',
                      address: '',
                      role: '',
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
