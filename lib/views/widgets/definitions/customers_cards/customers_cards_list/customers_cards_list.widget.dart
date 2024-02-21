import 'package:communitybank/controllers/customer_card/customer_card.controller.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/definitions/types/types_list/types_list.widget.dart';
import 'package:communitybank/views/widgets/globals/search_input/search_input.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

final searchedCustomersCardsListProvider =
    StreamProvider<List<CustomerCard>>((ref) async* {
  String searchedCard = ref.watch(searchProvider('customers-cards'));
  ref.listen(searchProvider('customers-cards'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('customers-cards').notifier).state = true;
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
    final isSearching = ref.watch(isSearchingProvider('customers-cards'));
    final searchedCustomersCardsList =
        ref.watch(searchedCustomersCardsListProvider);
    final customersCardsListStream =
        ref.watch(customersCardsListStreamProvider);

    final customerCardsList =
        isSearching ? searchedCustomersCardsList : customersCardsListStream;

    final format = DateFormat.yMMMMEEEEd('fr');

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: customerCardsList.when(
          data: (data) => HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: MediaQuery.of(context).size.width,
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
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Libellé',
                  familyName: 'customers-cards',
                  searchProvider: searchProvider('customers-cards'),
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Type',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Remboursé',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Satisfait',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              /*    const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
              */
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
              final customerCard = data[index];
              return Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 500.0,
                    height: 30.0,
                    child: CBText(
                      text: customerCard.label,
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 30.0,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final typesListStream =
                            ref.watch(typesListStreamProvider);

                        return typesListStream.when(
                          data: (data) {
                            final customerCardType = data.firstWhere(
                              (type) => customerCard.typeId == type.id,
                            );

                            return CBText(
                              text: customerCardType.name,
                              fontSize: 12.0,
                            );
                          },
                          error: (error, stackTrace) => const CBText(
                            text: '',
                          ),
                          loading: () => const CBText(
                            text: '',
                            fontSize: 12.0,
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 30.0,
                    child: CBText(
                      text: customerCard.repaidAt != null
                          ? '${format.format(customerCard.repaidAt!)}  ${customerCard.repaidAt!.hour}:${customerCard.repaidAt!.minute}'
                          : '',
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 30.0,
                    child: CBText(
                      text: customerCard.satisfiedAt != null
                          ? '${format.format(customerCard.satisfiedAt!)}  ${customerCard.satisfiedAt!.hour}:${customerCard.satisfiedAt!.minute}'
                          : '',
                      fontSize: 12.0,
                    ),
                  ),
                  /*    InkWell(
                    onTap: () async {
                     
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
              */
                ],
              );
            },
            rowSeparatorWidget: const Divider(),
            scrollPhysics: const BouncingScrollPhysics(),
            horizontalScrollPhysics: const BouncingScrollPhysics(),
          ),
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
                child: CBSearchInput(
                  hintText: 'Libellé',
                  familyName: 'customers-cards',
                  searchProvider: searchProvider('customers-cards'),
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Type',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Remboursé',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Satisfait',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              /*    const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
              */
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
                child: CBSearchInput(
                  hintText: 'Libellé',
                  familyName: 'customers-cards',
                  searchProvider: searchProvider('customers-cards'),
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Type',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Remboursé',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Satisfait',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              /*    const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
              */
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
