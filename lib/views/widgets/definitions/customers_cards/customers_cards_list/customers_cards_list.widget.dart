import 'package:communitybank/controllers/customer_card/customer_card.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/customer_card/customer_card_crud.fuction.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/definitions/types/types_list/types_list.widget.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/customer_card/customers_cards_deletion_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/update/customer_card/customer_card_update_form.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchedCustomersCardsListProvider =
    StreamProvider<List<CustomerCard>>((ref) async* {
  String searchedCard = ref.watch(searchProvider('customers-cards'));
  ref.listen(searchProvider('customers-cards'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('cards').notifier).state = true;
    } else {
      ref.read(isSearchingProvider('customers-cards').notifier).state = false;
    }
  });
  yield* CustomersCardsController.searchCustomerCard(label: searchedCard)
      .asStream();
});

final customersCardsListStreamProvider =
    StreamProvider<List<CustomerCard>>((ref) async* {
  yield* CustomersCardsController.getAll();
});

class CustomersCardsList extends ConsumerWidget {
  const CustomersCardsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearching = ref.watch(isSearchingProvider('cards'));
    final searchedCustomersCardsList =
        ref.watch(searchedCustomersCardsListProvider);
    final customersCardsListStream =
        ref.watch(customersCardsListStreamProvider);
    final typesListStream = ref.watch(typesListStreamProvider);
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
                  text: 'Libellé',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Type',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Remboursé',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Satisfait',
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
                ? searchedCustomersCardsList.when(
                    data: (data) {
                      //  debugPrint('card Stream Data: $data');
                      return data
                          .map(
                            (customerCard) => DataRow(
                              cells: [
                                DataCell(
                                  CBText(
                                    text: customerCard.id!.toString(),
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: customerCard.label,
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: typesListStream.when(
                                        data: (data) => data
                                            .firstWhere((type) =>
                                                type.id == customerCard.typeId)
                                            .name,
                                        error: (error, stackTrace) => '',
                                        loading: () => ''),
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: customerCard.repaidAt != null
                                        ? customerCard.repaidAt!
                                            .toIso8601String()
                                        : '',
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: customerCard.satisfiedAt != null
                                        ? customerCard.satisfiedAt!
                                            .toIso8601String()
                                        : '',
                                  ),
                                ),
                                DataCell(
                                  onTap: () {
                                    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog: CustomerCardUpdateForm(
                                        customerCard: customerCard,
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
                                          CustomerCardDeletionConfirmationDialog(
                                        customerCard: customerCard,
                                        confirmToDelete:
                                            CustomerCardCRUDFunctions.delete,
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
                      //  debugPrint('cards Stream Error');
                      return [];
                    },
                    loading: () {
                      //  debugPrint('cards Stream Loading');
                      return [];
                    },
                  )
                : customersCardsListStream.when(
                    data: (data) {
                      //  debugPrint('card Stream Data: $data');
                      return data
                          .map(
                            (customerCard) => DataRow(
                              cells: [
                                DataCell(
                                  CBText(
                                    text: customerCard.id!.toString(),
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: customerCard.label,
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: typesListStream.when(
                                        data: (data) => data
                                            .firstWhere((type) =>
                                                type.id == customerCard.typeId)
                                            .name,
                                        error: (error, stackTrace) => '',
                                        loading: () => ''),
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: customerCard.repaidAt != null
                                        ? customerCard.repaidAt!
                                            .toIso8601String()
                                        : '',
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: customerCard.satisfiedAt != null
                                        ? customerCard.satisfiedAt!
                                            .toIso8601String()
                                        : '',
                                  ),
                                ),
                                DataCell(
                                  onTap: () {
                                    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog: CustomerCardUpdateForm(
                                        customerCard: customerCard,
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
                                          CustomerCardDeletionConfirmationDialog(
                                        customerCard: customerCard,
                                        confirmToDelete:
                                            CustomerCardCRUDFunctions.delete,
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
                      //  debugPrint('cards Stream Error');
                      return [];
                    },
                    loading: () {
                      //  debugPrint('cards Stream Loading');
                      return [];
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
