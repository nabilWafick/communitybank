import 'package:communitybank/controllers/settlement/settlement.controller.dart';
import 'package:communitybank/models/data/settlement/settlement.model.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchedSettlementsListProvider =
    StreamProvider<List<Settlement>>((ref) async* {
  // String searchedcollector = ref.watch(searchProvider('settlements'));
  ref.listen(searchProvider('settlements'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('settlements').notifier).state = true;
    } else {
      ref.read(isSearchingProvider('settlements').notifier).state = false;
    }
  });
  yield* SettlementsController.getAll();
  // searchCollector(name: searchedcollector).asStream();
});

final settlementsListStreamProvider =
    StreamProvider<List<Settlement>>((ref) async* {
  yield* SettlementsController.getAll();
});

class SettlementsList extends ConsumerWidget {
  const SettlementsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  final isSearching = ref.watch(isSearchingProvider('settlements'));
    //  final searchedSettlementsList = ref.watch(searchedSettlementsListProvider);
    //  final settlementsListStream = ref.watch(settlementsListStreamProvider);
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
                  text: 'Photo',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Nom & Prénoms',
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
            ],
            rows: const [],
            /*
             isSearching
                ? searchedSettlementsList.when(
                    data: (data) {
                      //  debugPrint('collector Stream Data: $data');
                      return data
                          .map(
                            (collector) => DataRow(
                              cells: [
                                DataCell(
                                  CBText(
                                    text: collector.id!.toString(),
                                  ),
                                ),
                                DataCell(
                                  onTap: () {
                                    collector.profile != null
                                        ? FunctionsController.showAlertDialog(
                                            context: context,
                                            alertDialog: SingleImageShower(
                                              imageSource: collector.profile!,
                                            ),
                                          )
                                        : () {};
                                  },
                                  Container(
                                    alignment: Alignment.center,
                                    child: collector.profile != null
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
                                          '${collector.name} ${collector.firstnames}'),
                                ),
                                DataCell(
                                  CBText(text: collector.phoneNumber),
                                ),
                                DataCell(
                                  CBText(text: collector.address),
                                ),
                                DataCell(
                                  onTap: () {
                                    ref
                                        .read(collectorPictureProvider.notifier)
                                        .state = null;
                                    ref
                                        .read(collectorPictureProvider.notifier)
                                        .state = null;
                                    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog: CollectorUpdateForm(
                                        collector: collector,
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
                                          CollectorDeletionConfirmationDialog(
                                        collector: collector,
                                        confirmToDelete:
                                            CollectorCRUDFunctions.delete,
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
                  )
                : settlementsListStream.when(
                    data: (data) {
                      //  debugPrint('collector Stream Data: $data');
                      return data
                          .map(
                            (collector) => DataRow(
                              cells: [
                                DataCell(
                                  CBText(
                                    text: collector.id!.toString(),
                                  ),
                                ),
                                DataCell(
                                  onTap: () {
                                    collector.profile != null
                                        ? FunctionsController.showAlertDialog(
                                            context: context,
                                            alertDialog: SingleImageShower(
                                              imageSource: collector.profile!,
                                            ),
                                          )
                                        : () {};
                                  },
                                  Container(
                                    alignment: Alignment.center,
                                    child: collector.profile != null
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
                                          '${collector.name} ${collector.firstnames}'),
                                ),
                                DataCell(
                                  CBText(text: collector.phoneNumber),
                                ),
                                DataCell(
                                  CBText(text: collector.address),
                                ),
                                DataCell(
                                  onTap: () {
                                    ref
                                        .read(collectorPictureProvider.notifier)
                                        .state = null;
                                    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog: CollectorUpdateForm(
                                        collector: collector,
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
                                          CollectorDeletionConfirmationDialog(
                                        collector: collector,
                                        confirmToDelete:
                                            CollectorCRUDFunctions.delete,
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
         */
          ),
        ),
      ),
    );
  }
}
