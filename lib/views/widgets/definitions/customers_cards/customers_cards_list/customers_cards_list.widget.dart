import 'package:communitybank/controllers/customer_card/customer_card.controller.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchedCardsListProvider =
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

final cardsListStreamProvider =
    StreamProvider<List<CustomerCard>>((ref) async* {
  yield* CustomersCardsController.getAll();
});

class CustomersCardsList extends ConsumerWidget {
  const CustomersCardsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  final isSearching = ref.watch(isSearchingProvider('cards'));
    //  final searchedCardsList = ref.watch(searchedCardsListProvider);
    //  final cardsListStream = ref.watch(cardsListStreamProvider);
    return SizedBox(
      height: 640.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(showCheckboxColumn: true, columns: const [
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
                text: 'Téléphone',
                textAlign: TextAlign.start,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            DataColumn(
              label: CBText(
                text: 'Adresse',
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
          ], rows: const [] /*
            isSearching
                ? searchedCardsList.when(
                    data: (data) {
                      //  debugPrint('card Stream Data: $data');
                      return data
                          .map(
                            (card) => DataRow(
                              cells: [
                                DataCell(
                                  CBText(
                                    text: card.id!.toString(),
                                  ),
                                ),
                                DataCell(
                                  onTap: () {
                                    card.profile != null
                                        ? FunctionsController.showAlertDialog(
                                            context: context,
                                            alertDialog: SingleImageShower(
                                              imageSource: card.profile!,
                                            ),
                                          )
                                        : () {};
                                  },
                                  Container(
                                    alignment: Alignment.center,
                                    child: card.profile != null
                                        ? const Icon(
                                            Icons.photo,
                                            color: CBColors.primaryColor,
                                          )
                                        : const SizedBox(),
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                      text:
                                          '${card.name} ${card.firstnames}'),
                                ),
                                DataCell(
                                  CBText(text: card.phoneNumber),
                                ),
                                DataCell(
                                  CBText(text: card.address),
                                ),
                                DataCell(
                                  onTap: () {
                                    ref
                                        .read(cardPictureProvider.notifier)
                                        .state = null;
                                    ref
                                        .read(cardPictureProvider.notifier)
                                        .state = null;
                                    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog: CardUpdateForm(
                                        card: card,
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
                                          CardDeletionConfirmationDialog(
                                        card: card,
                                        confirmToDelete:
                                            CardCRUDFunctions.delete,
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
                : cardsListStream.when(
                    data: (data) {
                      //  debugPrint('card Stream Data: $data');
                      return data
                          .map(
                            (card) => DataRow(
                              cells: [
                                DataCell(
                                  CBText(
                                    text: card.id!.toString(),
                                  ),
                                ),
                                DataCell(
                                  onTap: () {
                                    card.profile != null
                                        ? FunctionsController.showAlertDialog(
                                            context: context,
                                            alertDialog: SingleImageShower(
                                              imageSource: card.profile!,
                                            ),
                                          )
                                        : () {};
                                  },
                                  Container(
                                    alignment: Alignment.center,
                                    child: card.profile != null
                                        ? const Icon(
                                            Icons.photo,
                                            color: CBColors.primaryColor,
                                          )
                                        : const SizedBox(),
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                      text:
                                          '${card.name} ${card.firstnames}'),
                                ),
                                DataCell(
                                  CBText(text: card.phoneNumber),
                                ),
                                DataCell(
                                  CBText(text: card.address),
                                ),
                                DataCell(
                                  onTap: () {
                                    ref
                                        .read(cardPictureProvider.notifier)
                                        .state = null;
                                    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog: CardUpdateForm(
                                        card: card,
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
                                          CardDeletionConfirmationDialog(
                                        card: card,
                                        confirmToDelete:
                                            CardCRUDFunctions.delete,
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
         */
              ),
        ),
      ),
    );
  }
}
