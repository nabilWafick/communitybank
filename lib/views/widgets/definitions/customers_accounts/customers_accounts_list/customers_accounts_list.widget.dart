import 'package:communitybank/controllers/customer_account/customer_account.controller.dart';
import 'package:communitybank/controllers/forms/validators/customer_account/customer_account.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/customers_accounts/customers_accounts_crud.fuction.dart';
import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/collectors/collectors_list/collectors_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers/customers_list/customers_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards_list/customers_cards_list.widget.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/customers_accounts/customers_accounts_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/update/customer_account/customer_account_update_form.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/collector/collector_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer/customer_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

final customersAccountsListStreamProvider =
    StreamProvider<List<CustomerAccount>>((ref) async* {
  final selectedCustomer = ref.watch(
    listCustomerDropdownProvider('customers-accounts-list-sort-owner'),
  );
  final selectedCollector = ref.watch(
    listCollectorDropdownProvider('customers-accounts-list-sort-collector'),
  );

  yield* CustomersAccountsController.getAll(
    selectedCustomerId: selectedCustomer.id!,
    selectedCollectorId: selectedCollector.id!,
  );
});

class CustomersAccountsList extends StatefulHookConsumerWidget {
  const CustomersAccountsList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomersAccountsListState();
}

class _CustomersAccountsListState extends ConsumerState<CustomersAccountsList> {
  @override
  Widget build(BuildContext context) {
    final customersAccountsListStream =
        ref.watch(customersAccountsListStreamProvider);
    final customersListStream = ref.watch(customersListStreamProvider);

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: customersAccountsListStream.when(
          data: (data) {
            return HorizontalDataTable(
              leftHandSideColumnWidth: 100,
              rightHandSideColumnWidth: MediaQuery.of(context).size.width + 800,
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
                  width: 500.0,
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  child: const CBText(
                    text: 'Client',
                    textAlign: TextAlign.center,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 500.0,
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  child: const CBText(
                    text: 'Chargé de compte',
                    textAlign: TextAlign.center,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 1200.0,
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  child: const CBText(
                    text: 'Cartes',
                    textAlign: TextAlign.center,
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
                final customerAccount = data[index];

                return Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 500.0,
                      height: 30.0,
                      child: /* customersListStream.when(
                      data: (data) {
                        final accountOwner = data.firstWhere(
                          (customer) =>
                              customer.id == customerAccount.customerId,
                          orElse: () => Customer(
                            name: 'ID',
                            firstnames: '${customerAccount.customerId}',
                            phoneNumber: '1234567890',
                            address: 'Address',
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                        );
          
                        return CBText(
                          text:
                              '${accountOwner.name} ${accountOwner.firstnames}',
                          fontSize: 12.0,
                        );
                      },
                      error: (error, stackTrace) => const CBText(text: ''),
                      loading: () => const CBText(text: ''),
                    ),*/

                          Consumer(
                        builder: (context, ref, child) {
                          return customersListStream.when(
                            data: (data) {
                              final accountOwner = data.firstWhere(
                                (customer) =>
                                    customer.id == customerAccount.customerId,
                                orElse: () => Customer(
                                  name: 'ID',
                                  firstnames: '${customerAccount.customerId}',
                                  phoneNumber: '1234567890',
                                  address: 'Address',
                                  createdAt: DateTime.now(),
                                  updatedAt: DateTime.now(),
                                ),
                              );

                              return CBText(
                                text:
                                    '${accountOwner.name} ${accountOwner.firstnames}',
                                fontSize: 12.0,
                              );
                            },
                            error: (error, stackTrace) =>
                                const CBText(text: ''),
                            loading: () => const CBText(text: ''),
                          );
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 500.0,
                      height: 30.0,
                      child: Consumer(
                        builder: (context, ref, child) {
                          final collectorsListStream =
                              ref.watch(collectorsListStreamProvider);

                          return collectorsListStream.when(
                            data: (data) {
                              String accountCollector = '';

                              for (Collector collector in data) {
                                if (collector.id ==
                                    customerAccount.collectorId) {
                                  accountCollector =
                                      ' ${collector.name} ${collector.firstnames}';
                                  break;
                                }
                              }

                              return CBText(
                                text: accountCollector,
                                fontSize: 12.0,
                              );
                            },
                            error: (error, stackTrace) =>
                                const CBText(text: ''),
                            loading: () => const CBText(text: ''),
                          );
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 1200.0,
                      height: 30.0,
                      child: Consumer(
                        builder: (context, ref, child) {
                          final customersCardListStream =
                              ref.watch(customersCardsListStreamProvider);

                          return customersCardListStream.when(
                            data: (data) {
                              String accountCustomerCards = '';

                              for (CustomerCard customerCard in data) {
                                if (customerAccount.customerCardsIds
                                        .contains(customerCard.id) &&
                                    customerCard.satisfiedAt == null &&
                                    customerCard.repaidAt == null) {
                                  if (accountCustomerCards.isEmpty) {
                                    accountCustomerCards = customerCard.label;
                                  } else {
                                    accountCustomerCards =
                                        '$accountCustomerCards  ${customerCard.label}';
                                  }
                                }
                              }

                              return CBText(
                                text: accountCustomerCards,
                                fontSize: 12.0,
                              );
                            },
                            error: (error, stackTrace) =>
                                const CBText(text: ''),
                            loading: () => const CBText(text: ''),
                          );
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        ref
                            .read(customerAccountAddedInputsProvider.notifier)
                            .state = {};
                        ref
                            .read(customerAccountOwnerSelectedCardsTypesProvider
                                .notifier)
                            .state = {};
                        // automatically add the type products inputs after rendering
                        for (dynamic customerCardId
                            in customerAccount.customerCardsIds) {
                          ref
                              .read(
                            customerAccountAddedInputsProvider.notifier,
                          )
                              .update((state) {
                            state[customerCardId] = true;
                            return state;
                          });
                        }

                        /*
                                  debugPrint('Milliseconds');
                                  debugPrint(
                                    DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString(),
                                  );
                                  debugPrint('Microseconds');
                                  debugPrint(
                                    DateTime.now()
                                        .microsecondsSinceEpoch
                                        .toString(),
                                  );
                                  */

                        await FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: CustomerAccountUpdateForm(
                            customerAccount: customerAccount,
                          ),
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
            );
          },
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
                width: 500.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Client',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 500.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Chargé de compte',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 1200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Cartes',
                  textAlign: TextAlign.center,
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
                width: 500.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Client',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 500.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Chargé de compte',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 1200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Cartes',
                  textAlign: TextAlign.center,
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
