import 'package:communitybank/controllers/collection/collection.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/collections/collections_crud.function.dart';
import 'package:communitybank/models/data/collection/collection.model.dart';
import 'package:communitybank/views/widgets/definitions/agents/agents.widgets.dart';
import 'package:communitybank/views/widgets/definitions/collections/collections_sort_options/collections_sort_options.widget.dart';
import 'package:communitybank/views/widgets/definitions/collectors/collectors.widgets.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/collections/collections_deletion_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/update/collections/collection_amount/collections_amount_update_form.widget.dart';
import 'package:communitybank/views/widgets/forms/update/collections/collections_update_form.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/agent/agent_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/collector/collector_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

final collectionsListStreamProvider =
    StreamProvider<List<Collection>>((ref) async* {
  final selectedCollector = ref.watch(
    listCollectorDropdownProvider('collections-collector'),
  );
  final selectedAgent = ref.watch(
    listAgentDropdownProvider('collections-agent'),
  );
  final selectedCollectionDate =
      ref.watch(collectionsListCollectionDateProvider);

  yield* CollectionsController.getAll(
    collectorId: selectedCollector.id,
    collectedAt: selectedCollectionDate,
    agentId: selectedAgent.id,
  );
});

class CollectionsList extends ConsumerStatefulWidget {
  const CollectionsList({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CollectionsListState();
}

class _CollectionsListState extends ConsumerState<CollectionsList> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  final ScrollController verticalScrollController = ScrollController();
  final ScrollController horizontalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    //  final isSearching = ref.watch(isSearchingProvider('collections'));
    final collectionsListStream = ref.watch(collectionsListStreamProvider);

    final format = DateFormat.yMMMMEEEEd('fr');
    return SizedBox(
      // alignment: Alignment.center,
      height: 600.0,
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
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  DataColumn(
                    label: CBText(
                      text: 'Chargé de compte',
                      textAlign: TextAlign.start,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  DataColumn(
                    label: CBText(
                      text: 'Montant',
                      textAlign: TextAlign.start,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  DataColumn(
                    label: CBText(
                      text: 'Reste',
                      textAlign: TextAlign.start,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  DataColumn(
                    label: CBText(
                      text: 'Date de collecte',
                      textAlign: TextAlign.start,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  DataColumn(
                    label: CBText(
                      text: 'Date de saisie',
                      textAlign: TextAlign.start,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  DataColumn(
                    label: CBText(
                      text: 'Agent',
                      textAlign: TextAlign.start,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(),
                  ),
                  DataColumn(
                    label: SizedBox(),
                  ),
                  DataColumn(
                    label: SizedBox(),
                  ),
                ],
                rows: collectionsListStream.when(
                  data: (data) {
                    //  debugPrint('collector Stream Data: $data');
                    return data
                        .map(
                          (collection) => DataRow(
                            cells: [
                              DataCell(
                                CBText(
                                  text: '${data.indexOf(collection) + 1}',
                                ),
                              ),
                              DataCell(
                                Consumer(
                                  builder: (context, ref, child) {
                                    final collectorsListStream =
                                        ref.watch(collectorsListStreamProvider);
                                    return CBText(
                                      text: collectorsListStream.when(
                                          data: (data) {
                                            final collector = data.firstWhere(
                                              (collector) =>
                                                  collector.id ==
                                                  collection.collectorId,
                                            );

                                            return '${collector.name} ${collector.firstnames}';
                                          },
                                          error: ((error, stackTrace) => ''),
                                          loading: () => ''),
                                      fontSize: 12.0,
                                    );
                                  },
                                ),
                              ),
                              DataCell(
                                CBText(
                                  text: collection.amount.ceil().toString(),
                                  fontSize: 12.0,
                                ),
                              ),
                              DataCell(
                                CBText(
                                  text: collection.rest.ceil().toString(),
                                  fontSize: 12.0,
                                ),
                              ),
                              DataCell(
                                CBText(
                                  text:
                                      '${format.format(collection.collectedAt)}  ${collection.collectedAt.hour}:${collection.collectedAt.minute}',
                                  fontSize: 12.0,
                                ),
                              ),
                              DataCell(
                                CBText(
                                  text:
                                      '${format.format(collection.createdAt)}  ${collection.createdAt.hour}:${collection.createdAt.minute}',
                                  fontSize: 12.0,
                                ),
                              ),
                              DataCell(
                                Consumer(
                                  builder: (context, ref, child) {
                                    final agentsListStream =
                                        ref.watch(agentsListStreamProvider);

                                    return CBText(
                                      text: agentsListStream.when(
                                          data: (data) {
                                            final agent = data.firstWhere(
                                              (agent) =>
                                                  agent.id ==
                                                  collection.agentId,
                                            );

                                            return '${agent.name} ${agent.firstnames}';
                                          },
                                          error: ((error, stackTrace) => ''),
                                          loading: () => ''),
                                      fontSize: 12.0,
                                    );
                                  },
                                ),
                              ),
                              DataCell(
                                onTap: () {
                                  FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog: CollectionAmountUpdateForm(
                                        collection: collection,
                                      ));
                                },
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.green,
                                  ),
                                ),
                                // showEditIcon: true,
                              ),
                              DataCell(
                                onTap: () {
                                  FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog: CollectionUpdateForm(
                                        collection: collection,
                                      ));
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
                                        CollectionDeletionConfirmationDialog(
                                      collection: collection,
                                      confirmToDelete:
                                          CollectionCRUDFunctions.delete,
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
