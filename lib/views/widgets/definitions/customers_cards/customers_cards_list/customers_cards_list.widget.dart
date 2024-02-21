import 'package:communitybank/controllers/customer_card/customer_card.controller.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/definitions/types/types_list/types_list.widget.dart';
import 'package:communitybank/views/widgets/globals/search_input/search_input.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final isSearching = ref.watch(isSearchingProvider('cards'));
    final searchedCustomersCardsList =
        ref.watch(searchedCustomersCardsListProvider);
    final customersCardsListStream =
        ref.watch(customersCardsListStreamProvider);
    // final typesListStream = ref.watch(typesListStreamProvider);

    final format = DateFormat.yMMMMEEEEd('fr');

    return SizedBox(
      height: 600.0,
      child: Scrollbar(
        controller: scrollController,
        child: SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //  padding: const EdgeInsets.symmetric(horizontal: 100.0),
          controller: scrollController,
          child: SingleChildScrollView(
            child: DataTable(
              showCheckboxColumn: true,
              columns: [
                const DataColumn(
                  label: CBText(
                    text: 'Code',
                    textAlign: TextAlign.start,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                DataColumn(
                  label: CBSearchInput(
                    hintText: 'Libellé',
                    familyName: 'customers-cards',
                    searchProvider: searchProvider('customers-cards'),
                  ),
                  /*CBText(
                    text: 'Libellé',
                    textAlign: TextAlign.start,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),*/
                ),
                const DataColumn(
                  label: CBText(
                    text: 'Type',
                    textAlign: TextAlign.start,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const DataColumn(
                  label: CBText(
                    text: 'Remboursé',
                    textAlign: TextAlign.start,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const DataColumn(
                  label: CBText(
                    text: 'Satisfait',
                    textAlign: TextAlign.start,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                /*    DataColumn(
                  label: SizedBox(),
                ),
                DataColumn(
                  label: SizedBox(),
                ),*/
              ],
              rows: isSearching
                  ? searchedCustomersCardsList.when(
                      data: (data) {
                        return data.map(
                          (customerCard) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  CBText(
                                    text: '${data.indexOf(customerCard) + 1}',
                                    fontSize: 12.0,
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: customerCard.label,
                                    fontSize: 12.0,
                                  ),
                                ),
                                DataCell(
                                  Consumer(
                                    builder: (context, ref, child) {
                                      final typesListStream =
                                          ref.watch(typesListStreamProvider);

                                      return typesListStream.when(
                                        data: (data) {
                                          final customerCardType =
                                              data.firstWhere(
                                            (type) =>
                                                customerCard.typeId == type.id,
                                          );

                                          return CBText(
                                            text: customerCardType.name,
                                            fontSize: 12.0,
                                          );
                                        },
                                        error: (error, stackTrace) =>
                                            const CBText(
                                          text: '',
                                        ),
                                        loading: () => const CBText(
                                          text: '',
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: customerCard.repaidAt != null
                                        ? '${format.format(customerCard.repaidAt!)}  ${customerCard.repaidAt!.hour}:${customerCard.repaidAt!.minute}'
                                        : '',
                                    fontSize: 12.0,
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: customerCard.satisfiedAt != null
                                        ? '${format.format(customerCard.satisfiedAt!)}  ${customerCard.satisfiedAt!.hour}:${customerCard.satisfiedAt!.minute}'
                                        : '',
                                    fontSize: 12.0,
                                  ),
                                ),
                                /*   DataCell(
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
                              */
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
                    )
                  : customersCardsListStream.when(
                      data: (data) {
                        return data.map(
                          (customerCard) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  CBText(
                                    text: '${data.indexOf(customerCard) + 1}',
                                    fontSize: 12.0,
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: customerCard.label,
                                    fontSize: 12.0,
                                  ),
                                ),
                                DataCell(Consumer(
                                  builder: (context, ref, child) {
                                    final typesListStream =
                                        ref.watch(typesListStreamProvider);

                                    return typesListStream.when(
                                      data: (data) {
                                        final customerCardType =
                                            data.firstWhere(
                                          (type) =>
                                              customerCard.typeId == type.id,
                                        );

                                        return CBText(
                                          text: customerCardType.name,
                                          fontSize: 12.0,
                                        );
                                      },
                                      error: (error, stackTrace) =>
                                          const CBText(
                                        text: '',
                                      ),
                                      loading: () => const CBText(
                                        text: '',
                                        fontSize: 12.0,
                                      ),
                                    );
                                  },
                                )),
                                DataCell(
                                  CBText(
                                    text: customerCard.repaidAt != null
                                        ? '${format.format(customerCard.repaidAt!)}  ${customerCard.repaidAt!.hour}:${customerCard.repaidAt!.minute}'
                                        : '',
                                    fontSize: 12.0,
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: customerCard.satisfiedAt != null
                                        ? '${format.format(customerCard.satisfiedAt!)}  ${customerCard.satisfiedAt!.hour}:${customerCard.satisfiedAt!.minute}'
                                        : '',
                                    fontSize: 12.0,
                                  ),
                                ),
                                /*   DataCell(
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
                              */
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
      ),
    );
  }
}
