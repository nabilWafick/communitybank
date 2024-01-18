import 'package:communitybank/controllers/forms/validators/collector/collector.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/views/widgets/definitions/customers_accounts/customers_accounts_list/customers_accounts_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/forms/adding/agent/agent_adding_form.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/customer_account/customer_account_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CashOperationsSearchOptions extends ConsumerWidget {
  const CashOperationsSearchOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final custumersAccountsOwners =
        ref.watch(customersAccountsListStreamProvider);
    return Container(
      margin: const EdgeInsets.only(
        top: 20.0,
        bottom: 40.0,
      ),
      width: double.maxFinite,
      child: Row(
        children: [
          CBFormCustomerAccountDropdown(
            width: 400.0,
            label: 'Compte Client',
            providerName: 'cash-operations-clients',
            dropdownMenuEntriesLabels: custumersAccountsOwners.when(
              data: (data) => data,
              error: (error, stackTrace) => [],
              loading: () => [],
            ),
            dropdownMenuEntriesValues: custumersAccountsOwners.when(
              data: (data) => data,
              error: (error, stackTrace) => [],
              loading: () => [],
            ),
          ),
          CBFormCustomerAccountDropdown(
            width: 400.0,
            label: 'Compte Client',
            providerName: 'cash-operations-clients',
            dropdownMenuEntriesLabels: custumersAccountsOwners.when(
              data: (data) => data,
              error: (error, stackTrace) => [],
              loading: () => [],
            ),
            dropdownMenuEntriesValues: custumersAccountsOwners.when(
              data: (data) => data,
              error: (error, stackTrace) => [],
              loading: () => [],
            ),
          )
        ],
      ),
    );
  }
}
