import 'package:communitybank/controllers/customer_account/customer_account.controller.dart';
import 'package:communitybank/controllers/forms/validators/customer_account/customer_account.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/customers_accounts/customers_accounts_crud.fuction.dart';
import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/views/widgets/definitions/collectors/collectors_list/collectors_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers/customers_list/customers_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards_list/customers_cards_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/customer_account/customer_account_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/update/customer_account/customer_account_update_form.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchedCustomersAccountsListProvider =
    StreamProvider<List<CustomerAccount>>((ref) async* {
  // String searchedCustomerAccount =
  //     ref.watch(searchProvider('customers-accounts'));
  ref.listen(searchProvider('customers-accounts'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('customers-accounts').notifier).state = true;
    } else {
      ref.read(isSearchingProvider('customers-accounts').notifier).state =
          false;
    }
  });
  yield* CustomersAccountsController.getAll();

  /* searchcustomersAccount(name: searchedCustomerAccount)
      .asStream(); */
});

final customersAccountsListStreamProvider =
    StreamProvider<List<CustomerAccount>>((ref) async* {
  yield* CustomersAccountsController.getAll();
});

class CustomersAccountsList extends ConsumerWidget {
  const CustomersAccountsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearching = ref.watch(isSearchingProvider('customers-accounts'));
    final searchedCustomersAccountsList =
        ref.watch(searchedCustomersAccountsListProvider);
    final customersAccountsListStream =
        ref.watch(customersAccountsListStreamProvider);
    final customersListStream = ref.watch(customersListStreamProvider);
    final collectorsListStream = ref.watch(collectorsListStreamProvider);
    final customersCardListStream = ref.watch(customersCardsListStreamProvider);
    return SizedBox(
      height: 640.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            showCheckboxColumn: true,
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
                  text: 'Nom & Prénoms Client',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Nom & Prénoms Chargé de compte',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Cartes',
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
            rows: isSearching
                ? searchedCustomersAccountsList.when(
                    data: (data) {
                      //  debugPrint('customersAccount Stream Data: $data');
                      return data
                          .map(
                            (customerAccount) => DataRow(
                              cells: [
                                DataCell(
                                  CBText(
                                    text: customerAccount.id!.toString(),
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: customersListStream.when(
                                      data: (data) {
                                        final accountOwner = data.firstWhere(
                                            (customer) =>
                                                customer.id ==
                                                customerAccount.customerId);
                                        return '${accountOwner.firstnames} ${accountOwner.name}';
                                      },
                                      error: (error, stackTrace) => '',
                                      loading: () => '',
                                    ),
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: collectorsListStream.when(
                                      data: (data) {
                                        final accountCollector =
                                            data.firstWhere((collector) =>
                                                collector.id ==
                                                customerAccount.collectorId);
                                        return '${accountCollector.firstnames} ${accountCollector.name}';
                                      },
                                      error: (error, stackTrace) => '',
                                      loading: () => '',
                                    ),
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                      text: customersCardListStream.when(
                                    data: (data) {
                                      // reset type products list for avoiding mutilple product adding which will be caused by stream
                                      customerAccount.customerCards = [];
                                      String customerAccountOwnerCards = '';
                                      //  type.products.clear();
                                      for (CustomerCard customerCard in data) {
                                        for (var customerCardId
                                            in customerAccount
                                                .customerCardsIds!) {
                                          if (customerCard.id! ==
                                              customerCardId) {
                                            // get product number in type.productsNumber
                                            // by using the index of product id in type.productsIds

                                            customerAccount.customerCards
                                                .add(customerCard);

                                            if (customerAccountOwnerCards
                                                .isEmpty) {
                                              customerAccountOwnerCards =
                                                  customerCard.label;
                                            } else {
                                              customerAccountOwnerCards =
                                                  '$customerAccountOwnerCards  ${customerCard.label}';
                                            }
                                          }
                                        }
                                      }
                                      //  debugPrint('type products: ${type.products}');
                                      return customerAccountOwnerCards;
                                    },
                                    error: (error, stackTrace) => '',
                                    loading: () => '',
                                  )
                                      // typeProducts,
                                      //  type.products.length.toString(),
                                      ),
                                ),
                                DataCell(
                                  onTap: () {
                                    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog: CustomerAccountUpdateForm(
                                        customerAccount: customerAccount,
                                      ),
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
                                    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog:
                                          CustomerAccountDeletionConfirmationDialog(
                                        customerAccount: customerAccount,
                                        confirmToDelete:
                                            CustomerAccountCRUDFunctions.delete,
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
                          .toList();
                    },
                    error: (error, stack) {
                      //  debugPrint('customersAccounts Stream Error');
                      return [];
                    },
                    loading: () {
                      //  debugPrint('customersAccounts Stream Loading');
                      return [];
                    },
                  )
                : customersAccountsListStream.when(
                    data: (data) {
                      //  debugPrint('customersAccount Stream Data');
                      return data.map(
                        (customerAccount) {
                          //      debugPrint(customerAccount.toString());
                          return DataRow(
                            cells: [
                              DataCell(
                                CBText(
                                  text: customerAccount.id!.toString(),
                                ),
                              ),
                              DataCell(
                                CBText(
                                  text: customersListStream.when(
                                    data: (data) {
                                      String accountOwnerName = '';

                                      for (Customer customer in data) {
                                        if (customer.id ==
                                            customerAccount.customerId) {
                                          accountOwnerName =
                                              '${customer.firstnames} ${customer.name}';
                                          customerAccount.customer = customer;
                                        }
                                      }
                                      /*  data.firstWhere((customer) =>
                                            customer.id ==
                                            customerAccount.customerId);
                                            */

                                      return accountOwnerName;
                                    },
                                    error: (error, stackTrace) => '',
                                    loading: () => '',
                                  ),
                                ),
                              ),
                              DataCell(
                                CBText(
                                  text: collectorsListStream.when(
                                    data: (data) {
                                      String accountCollectorName = '';
                                      for (Collector collector in data) {
                                        if (collector.id ==
                                            customerAccount.collectorId) {
                                          accountCollectorName =
                                              '${collector.firstnames} ${collector.name}';
                                          customerAccount.collector = collector;
                                        }
                                      }
                                      // data.firstWhere((collector) =>
                                      //     collector.id ==
                                      //     customerAccount.collectorId);
                                      return accountCollectorName;
                                    },
                                    error: (error, stackTrace) => '',
                                    loading: () => '',
                                  ),
                                ),
                              ),
                              DataCell(
                                CBText(
                                    text: customersCardListStream.when(
                                  data: (data) {
                                    // reset type products list for avoiding mutilple product adding which will be caused by stream
                                    customerAccount.customerCards = [];
                                    String customerAccountOwnerCards = '';
                                    //  type.products.clear();
                                    for (CustomerCard customerCard in data) {
                                      for (dynamic customerCardId
                                          in customerAccount
                                              .customerCardsIds!) {
                                        if (customerCard.id! ==
                                            customerCardId) {
                                          // get product number in type.productsNumber
                                          // by using the index of product id in type.productsIds

                                          customerAccount.customerCards
                                              .add(customerCard);

                                          if (customerAccountOwnerCards
                                              .isEmpty) {
                                            customerAccountOwnerCards =
                                                customerCard.label;
                                          } else {
                                            customerAccountOwnerCards =
                                                '$customerAccountOwnerCards  ${customerCard.label}';
                                          }
                                        }
                                      }
                                    }
                                    //  debugPrint('type products: ${type.products}');
                                    return customerAccountOwnerCards;
                                  },
                                  error: (error, stackTrace) => '',
                                  loading: () => '',
                                )
                                    // typeProducts,
                                    //  type.products.length.toString(),
                                    ),
                              ),
                              DataCell(
                                onTap: () {
                                  ref
                                      .read(customerAccountAddedInputsProvider
                                          .notifier)
                                      .state = {};
                                  ref
                                      .read(
                                          customerAccountSelectedOwnerCardsProvider
                                              .notifier)
                                      .state = {};
                                  // automatically add the type products inputs after rendering
                                  for (CustomerCard customerCard
                                      in customerAccount.customerCards) {
                                    ref
                                        .read(customerAccountAddedInputsProvider
                                            .notifier)
                                        .update((state) {
                                      state[customerCard.id!] = true;
                                      return state;
                                    });
                                  }
                                  // debugPrint(
                                  //     'accouts Cards: ${customerAccount.customerCards.toString()}');
                                  FunctionsController.showAlertDialog(
                                    context: context,
                                    alertDialog: CustomerAccountUpdateForm(
                                      customerAccount: customerAccount,
                                    ),
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
                                  FunctionsController.showAlertDialog(
                                    context: context,
                                    alertDialog:
                                        CustomerAccountDeletionConfirmationDialog(
                                      customerAccount: customerAccount,
                                      confirmToDelete:
                                          CustomerAccountCRUDFunctions.delete,
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
                          );
                        },
                      ).toList();
                    },
                    error: (error, stack) {
                      //  debugPrint('customersAccounts Stream Error');
                      return [];
                    },
                    loading: () {
                      //  debugPrint('customersAccounts Stream Loading');
                      return [];
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
