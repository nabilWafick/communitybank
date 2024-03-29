import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/agent/agent.model.dart';
import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/models/data/type/type.model.dart';
import 'package:communitybank/views/widgets/definitions/agents/agents_list/agents_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_accounts/customers_accounts_list/customers_accounts_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/products/products.widgets.dart';
import 'package:communitybank/views/widgets/definitions/types/types_list/types_list.widget.dart';
import 'package:communitybank/views/widgets/forms/adding/stocks/input/input_adding_form.widget.dart';
import 'package:communitybank/views/widgets/forms/adding/stocks/output/output_adding_form.widget.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/agent/agent_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_account/customer_account_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/product/product_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/string_dropdown/string_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/type/type_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:communitybank/views/widgets/stocks/stocks_list/stocks_list.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

final stockMovementDateProvider = StateProvider<DateTime?>((ref) {
  return;
});

class StocksSortOptions extends StatefulHookConsumerWidget {
  const StocksSortOptions({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StocksSortOptionsState();
}

class _StocksSortOptionsState extends ConsumerState<StocksSortOptions> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final productListStream = ref.watch(productsListStreamProvider);
    final agentsListStream = ref.watch(agentsListStreamProvider);
    final typesListStream = ref.watch(typesListStreamProvider);
    final customersAccountsListStream =
        ref.watch(customersAccountsListStreamProvider);

    final selectedStockMovementDate = ref.watch(stockMovementDateProvider);

    final format = DateFormat.yMMMMEEEEd('fr');
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20.0,
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
                  ref.invalidate(stocksDetailsListStreamProvider);
                },
              ),
              CBIconButton(
                icon: Icons.transit_enterexit,
                text: 'Entrée',
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const StockInputAddingForm(),
                  );
                },
              ),
              CBIconButton(
                icon: Icons.arrow_outward,
                text: 'Sortie',
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const StockOutputAddingForm(),
                  );
                },
              ),
              const SizedBox(
                width: 10.0,
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 25.0,
            ),
            child: Wrap(
              runSpacing: 10.0,
              spacing: 5.0,
              children: [
                SizedBox(
                  width: 500.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CBIconButton(
                        icon: Icons.date_range,
                        text: 'Date de Mouvement',
                        onTap: () async {
                          await FunctionsController.showDateTime(
                            context: context,
                            ref: ref,
                            stateProvider: stockMovementDateProvider,
                          );
                        },
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Flexible(
                        child: CBText(
                          text: selectedStockMovementDate != null
                              ? format.format(selectedStockMovementDate)
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
                CBListProductDropdown(
                  width: 400.0,
                  menuHeigth: 500.0,
                  label: 'Produit',
                  providerName: 'stocks-product',
                  dropdownMenuEntriesLabels: productListStream.when(
                    data: (data) => data,
                    error: (error, stackTrace) => [],
                    loading: () => [],
                  ),
                  dropdownMenuEntriesValues: productListStream.when(
                    data: (data) => data,
                    error: (error, stackTrace) => [],
                    loading: () => [],
                  ),
                ),
                CBListCustomerAccountDropdown(
                  width: 300.0,
                  menuHeigth: 500.0,
                  label: 'Client',
                  providerName: 'stocks-customer-account',
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
                CBListTypeDropdown(
                  width: 300.0,
                  menuHeigth: 500.0,
                  label: 'Type',
                  providerName: 'stocks-type',
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
                  width: 300.0,
                  menuHeigth: 500.0,
                  label: 'Agent',
                  providerName: 'stocks-agent',
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
                      ...data,
                    ],
                    error: (error, stackTrace) => [],
                    loading: () => [],
                  ),
                ),
                const CBListStringDropdown(
                  width: 300.0,
                  menuHeigth: 500.0,
                  label: 'Type Sortie',
                  providerName: 'stocks-output-type',
                  dropdownMenuEntriesLabels: [
                    'Tous',
                    'Normale',
                    'Manuelle',
                    'Contrainte',
                  ],
                  dropdownMenuEntriesValues: [
                    '*',
                    'Normale',
                    'Manuelle',
                    'Contrainte',
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
