import 'package:communitybank/controllers/settlement/settlement.controller.dart';
import 'package:communitybank/models/data/settlement/settlement.model.dart';
import 'package:communitybank/views/widgets/definitions/agents/agents.widgets.dart';
import 'package:communitybank/views/widgets/definitions/customers_cards/customers_cards_list/customers_cards_list.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_card/customer_card_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

/*final searchedSettlementsListProvider =
    StreamProvider<List<Settlement>>((ref) async* {
   String searchedCustumerollector = ref.watch(searchProvider('settlements'));
  ref.listen(searchProvider('settlements'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('settlements').notifier).state = true;
    } else {
      ref.read(isSearchingProvider('settlements').notifier).state = false;
    }
  });
  yield* SettlementsController.getAll(customerCardId: null);
  // searchCollector(name: searchedcollector).asStream();
});

*/
final settlementsListStreamProvider =
    StreamProvider<List<Settlement>>((ref) async* {
  final selectedCustomerCard = ref.watch(
    listCustomerCardDropdownProvider('settlements-card'),
  );
  yield* SettlementsController.getAll(
    customerCardId: selectedCustomerCard.id,
  );
});

class SettlementsList extends ConsumerStatefulWidget {
  const SettlementsList({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SettlementsListState();
}

class _SettlementsListState extends ConsumerState<SettlementsList> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  final ScrollController verticalScrollController = ScrollController();
  final ScrollController horizontalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    //  final isSearching = ref.watch(isSearchingProvider('settlements'));
    final settlementsListStream = ref.watch(settlementsListStreamProvider);
    final customersCardsListStream =
        ref.watch(customersCardsListStreamProvider);
    final agentsListStream = ref.watch(agentsListStreamProvider);

    final format = DateFormat.yMMMMEEEEd('fr');
    return Container(
      // alignment: Alignment.center,
      height: 620.0,
      color: Colors.blueGrey,
      // width: double.infinity,
      child: Scrollbar(
        controller: horizontalScrollController,
        child: SingleChildScrollView(
          controller: horizontalScrollController,
          scrollDirection: Axis.horizontal,
          child: Scrollbar(
            controller: verticalScrollController,
            child: SingleChildScrollView(
              controller: verticalScrollController,
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
                      text: 'Carte',
                      textAlign: TextAlign.start,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  DataColumn(
                    label: CBText(
                      text: 'Nombre',
                      textAlign: TextAlign.start,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  DataColumn(
                    label: CBText(
                      text: 'Date de règlement',
                      textAlign: TextAlign.start,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  DataColumn(
                    label: CBText(
                      text: 'Date de saisie',
                      textAlign: TextAlign.start,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  DataColumn(
                    label: CBText(
                      text: 'Agent',
                      textAlign: TextAlign.start,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                rows: settlementsListStream.when(
                  data: (data) {
                    //  debugPrint('collector Stream Data: $data');
                    return data
                        .map(
                          (settlement) => DataRow(
                            cells: [
                              DataCell(
                                CBText(
                                  text: '${data.indexOf(settlement) + 1}',
                                ),
                              ),
                              DataCell(
                                CBText(
                                  text: customersCardsListStream.when(
                                      data: (data) => data
                                          .firstWhere((customerCard) =>
                                              customerCard.id ==
                                              settlement.cardId)
                                          .label,
                                      error: ((error, stackTrace) => ''),
                                      loading: () => ''),
                                ),
                              ),
                              DataCell(
                                CBText(
                                  text: settlement.number.toString(),
                                ),
                              ),
                              DataCell(
                                CBText(
                                  text:
                                      '${format.format(settlement.collectedAt)}  ${settlement.collectedAt.hour}:${settlement.collectedAt.minute}',
                                ),
                              ),
                              DataCell(
                                CBText(
                                  text:
                                      '${format.format(settlement.createdAt)}  ${settlement.createdAt.hour}:${settlement.createdAt.minute}',
                                ),
                              ),
                              DataCell(
                                CBText(
                                  text: agentsListStream.when(
                                    data: (data) {
                                      final agent = data.firstWhere((agent) =>
                                          agent.id == settlement.agentId);

                                      return '${agent.firstnames} ${agent.name}';
                                    },
                                    error: (error, stackTrace) => '',
                                    loading: () => '',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList();
                  },
                  error: (error, stack) {
                    //  debugPrint('collectors Stream Error');
                    return [];
                  },
                  loading: () {
                    //  debugPrint('collectors Stream Loading');
                    return [];
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
