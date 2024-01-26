import 'package:communitybank/controllers/customer_card/customer_card.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/customer_card/customer_card_crud.fuction.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/definitions/types/types_list/types_list.widget.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/customer_cards/customers_cards_deletion_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/update/customer_card/customer_card_update_form.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:communitybank/models/data/type/type.model.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

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

final customersCardsWithOwnerListStreamProvider =
    StreamProvider<List<CustomerCard>>((ref) async* {
  yield* CustomersCardsController.getAllWithOwner();
});

final customersCardsWithoutOwnerListStreamProvider =
    StreamProvider<List<CustomerCard>>((ref) async* {
  yield* CustomersCardsController.getAllWithoutOwner();
});

class CustomersCardsList extends ConsumerStatefulWidget {
  const CustomersCardsList({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomersCardsListState();
}

class _CustomersCardsListState extends ConsumerState<CustomersCardsList> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final isSearching = ref.watch(isSearchingProvider('cards'));
    final searchedCustomersCardsList =
        ref.watch(searchedCustomersCardsListProvider);
    final customersCardsListStream =
        ref.watch(customersCardsListStreamProvider);
    // final typesListStream = ref.watch(typesListStreamProvider);

    final format = DateFormat.yMMMMEEEEd('fr');

    debugPrint('Building');
/*
    final typeListStreamData = typesListStream.when(
      data: (data) => data,
      error: (error, stackTrace) => <Type>[],
      loading: () => <Type>[],
    );
    */

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
                                const DataCell(
                                  CBText(
                                    text: 'Searched Customer Card Type',
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: customerCard.repaidAt != null
                                        ? '${format.format(customerCard.repaidAt)}  ${customerCard.repaidAt.hour}:${customerCard.repaidAt.minute}'
                                        : '',
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: customerCard.satisfiedAt != null
                                        ? '${format.format(customerCard.satisfiedAt)}  ${customerCard.satisfiedAt.hour}:${customerCard.satisfiedAt.minute}'
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
                      debugPrint('In List');
                      debugPrint('data length: ${data.length}');
                      return data.map(
                        (customerCard) {
                          debugPrint(customerCard.toString());
                          return DataRow(
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
                              DataCell(Consumer(
                                builder: (context, ref, child) {
                                  final typesListStream =
                                      ref.watch(typesListStreamProvider);

                                  return typesListStream.when(
                                    data: (data) {
                                      final customerCardType = data.firstWhere(
                                        (type) =>
                                            customerCard.typeId == type.id,
                                      );
                                      customerCard.type == customerCardType;

                                      return CBText(
                                        text: customerCardType.name,
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
                              )

                                  /*  CBText(
                                  text:
                                      /*
                                   typesListStream.when(
                                      data: (data) {
                                       
                                        String typeName = 'Default';

                                        for (Type type in data) {
                                          if (type.id == customerCard.typeId) {
                                            typeName = type.name;
                                            customerCard.type = type;
                                          }
                                        }

                                        final customerCardType =
                                            data.firstWhere(
                                          (type) => type.id == customerCard.id,
                                        );

                                        customerCard.type = customerCardType;

                                        typeName = customerCardType.name;

                                        return typeName;
                                      },
                                      error: (error, stackTrace) => '',
                                      loading: () => ''),
                                      */
                                      typeListStreamData.firstWhere(
                                    (type) {
                                      if (type.id == customerCard.typeId) {
                                        customerCard.type = type;
                                      }
                                      return type.id == customerCard.typeId;
                                    },
                                  ).name,
                                ),*/
                                  ),
                              DataCell(
                                CBText(
                                  text: customerCard.repaidAt != null
                                      ? '${format.format(customerCard.repaidAt)}  ${customerCard.repaidAt.hour}:${customerCard.repaidAt.minute}'
                                      : '',
                                ),
                              ),
                              DataCell(
                                CBText(
                                  text: customerCard.satisfiedAt != null
                                      ? '${format.format(customerCard.satisfiedAt)}  ${customerCard.satisfiedAt.hour}:${customerCard.satisfiedAt.minute}'
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
                          );
                        },
                      ).toList();
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
