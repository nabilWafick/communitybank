import 'package:communitybank/controllers/forms/validators/customer_account/customer_account.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/views/widgets/definitions/collectors/collectors_list/collectors_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers/customers_list/customers_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_accounts/customers_accounts.widgets.dart';
import 'package:communitybank/views/widgets/forms/adding/customer_account/customer_account_adding_form.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/collector/collector_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer/customer_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomersAccountsSortOptions extends ConsumerWidget {
  const CustomersAccountsSortOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customersListStream = ref.watch(customersListStreamProvider);
    final collectorsListStream = ref.watch(collectorsListStreamProvider);
    return Container(
      margin: const EdgeInsets.only(
        bottom: 40.0,
      ),
      width: double.maxFinite,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CBIconButton(
                icon: Icons.refresh,
                text: 'Rafraichir',
                onTap: () {
                  ref.invalidate(customersAccountsListStreamProvider);
                },
              ),
              CBAddButton(
                onTap: () {
                  ref.read(customerAccountAddedInputsProvider.notifier).state =
                      {};
                  ref
                      .read(customerAccountOwnerSelectedCardsTypesProvider
                          .notifier)
                      .state = {};
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const CustomerAccountAddingForm(),
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 10.0,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10.0,
                  ),
                  const CBText(text: 'Trier par'),
                  const SizedBox(
                    width: 15.0,
                  ),
                  CBListCustomerDropdown(
                    width: 200.0,
                    label: 'Clients',
                    providerName: 'customers-accounts-list-sort-owner',
                    dropdownMenuEntriesLabels: customersListStream.when(
                      data: (data) {
                        return [
                          Customer(
                            id: 0,
                            name: 'Tous',
                            firstnames: 'Tous',
                            phoneNumber: '',
                            profession: '',
                            nicNumber: 1234567890,
                            address: '',
                            categoryId: 0,
                            economicalActivityId: 0,
                            personalStatusId: 0,
                            localityId: 0,
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                          ...data
                        ];
                      },
                      error: (error, stackTrace) => [],
                      loading: () => [],
                    ),
                    dropdownMenuEntriesValues: customersListStream.when(
                      data: (data) {
                        return [
                          Customer(
                            id: 0,
                            name: 'Tous',
                            firstnames: 'Tous',
                            phoneNumber: '',
                            profession: '',
                            nicNumber: 1234567890,
                            address: '',
                            categoryId: 0,
                            economicalActivityId: 0,
                            personalStatusId: 0,
                            localityId: 0,
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                          ...data
                        ];
                      },
                      error: (error, stackTrace) => [],
                      loading: () => [],
                    ),
                  ),
                  CBListCollectorDropdown(
                    width: 200.0,
                    label: 'Chargés de comptes',
                    providerName: 'customers-accounts-list-sort-collector',
                    dropdownMenuEntriesLabels: collectorsListStream.when(
                      data: (data) {
                        return [
                          Collector(
                            id: 0,
                            name: 'Tous',
                            firstnames: 'Tous',
                            phoneNumber: '',
                            address: '',
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                          ...data
                        ];
                      },
                      error: (error, stackTrace) => [],
                      loading: () => [],
                    ),
                    dropdownMenuEntriesValues: collectorsListStream.when(
                      data: (data) {
                        return [
                          Collector(
                            id: 0,
                            name: 'Tous',
                            firstnames: 'Tous',
                            phoneNumber: '',
                            address: '',
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                          ...data
                        ];
                      },
                      error: (error, stackTrace) => [],
                      loading: () => [],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
