import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/views/widgets/definitions/customers_accounts/customers_accounts_list/customers_accounts_list.widget.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:communitybank/views/widgets/transferts/between_customers_accounts/customer_account_dropdown/customer_account_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
//import 'package:intl/intl.dart';

class TransfersBetweenCustomersAccountsSortOptions
    extends StatefulHookConsumerWidget {
  const TransfersBetweenCustomersAccountsSortOptions({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransfersBetweenCustomersAccountsSortOptionsState();
}

class _TransfersBetweenCustomersAccountsSortOptionsState
    extends ConsumerState<TransfersBetweenCustomersAccountsSortOptions> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final customersAccountsListStream =
        ref.watch(customersAccountsListStreamProvider);

    return Container(
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: CBIconButton(
                  icon: Icons.refresh,
                  text: 'Rafraichir',
                  onTap: () {},
                ),
              ),
              /*   Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: CBIconButton(
                  icon: Icons.print,
                  text: 'Imprimer',
                  onTap: () {
                    //  ref.invalidate(customerPeriodicActivityDataProvider);
                  },
                ),
              ),
          */
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CBTransfersBetweenCustomersAccountsCustomerAccountDropdown(
                width: 400.0,
                menuHeigth: 500.0,
                label: 'Client Émetteur',
                providerName:
                    'transfer-between-customers-accounts-issuing-customer-account',
                dropdownMenuEntriesLabels: customersAccountsListStream.when(
                  data: (data) => [
                    CustomerAccount(
                      customerId: 0,
                      collectorId: 0,
                      customerCardsIds: [],
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data.where(
                      (customerAccount) =>
                          customerAccount.customerCardsIds.length > 1,
                    ),
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
                    ...data.where(
                      (customerAccount) =>
                          customerAccount.customerCardsIds.length > 1,
                    ),
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
              ),
              const SizedBox(
                width: 5.0,
              ),
              CBTransfersBetweenCustomersAccountsCustomerAccountDropdown(
                width: 400.0,
                menuHeigth: 500.0,
                label: 'Client Récepteur',
                providerName:
                    'transfer-between-customers-accounts-receiving-customer-account',
                dropdownMenuEntriesLabels: customersAccountsListStream.when(
                  data: (data) => [
                    CustomerAccount(
                      customerId: 0,
                      collectorId: 0,
                      customerCardsIds: [],
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    ...data.where(
                      (customerAccount) =>
                          customerAccount.customerCardsIds.length > 1,
                    ),
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
                    ...data.where(
                      (customerAccount) =>
                          customerAccount.customerCardsIds.length > 1,
                    ),
                  ],
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
