import 'package:communitybank/controllers/collectors/collectors.controller.dart';
import 'package:communitybank/controllers/forms/validators/collector/collector.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/collectors/collectors_crud.function.dart';
import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/images_shower/single/single_image_shower.widget.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/collectors/collectors_deletion_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/update/collectors/collectors_update_form.widget.dart';
import 'package:communitybank/views/widgets/globals/search_input/search_input.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchedCollectorsListProvider =
    StreamProvider<List<Collector>>((ref) async* {
// collector name
  String searchedCollectorName = ref.watch(searchProvider('collectors-name'));
  ref.listen(searchProvider('collectors-name'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('collectors-name').notifier).state = true;
    } else {
      ref.read(isSearchingProvider('collectors-name').notifier).state = false;
    }
  });

  // collector firstnames
  String searchedCollectorFirstnames =
      ref.watch(searchProvider('collectors-firstnames'));
  ref.listen(searchProvider('collectors-firstnames'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('collectors-firstnames').notifier).state =
          true;
    } else {
      ref.read(isSearchingProvider('collectors-firstnames').notifier).state =
          false;
    }
  });

  // collector phoneNumber
  String searchedCollectorPhoneNumber =
      ref.watch(searchProvider('collectors-phoneNumber'));
  ref.listen(searchProvider('collectors-phoneNumber'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('collectors-phoneNumber').notifier).state =
          true;
    } else {
      ref.read(isSearchingProvider('collectors-phoneNumber').notifier).state =
          false;
    }
  });

  // collector address
  String searchedCollectorAddress =
      ref.watch(searchProvider('collectors-address'));
  ref.listen(searchProvider('collectors-address'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('collectors-address').notifier).state = true;
    } else {
      ref.read(isSearchingProvider('collectors-address').notifier).state =
          false;
    }
  });

  yield* CollectorsController.searchCollector(
    searchedCollectorName: searchedCollectorName,
    searchedCollectorAddress: searchedCollectorAddress,
    searchedCollectorFirstnames: searchedCollectorFirstnames,
    searchedCollectorPhoneNumber: searchedCollectorPhoneNumber,
  ).asStream();
});

final collectorsListStreamProvider =
    StreamProvider<List<Collector>>((ref) async* {
  yield* CollectorsController.getAll();
});

class CollectorsList extends StatefulHookConsumerWidget {
  const CollectorsList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CollectorsListState();
}

class _CollectorsListState extends ConsumerState<CollectorsList> {
  final ScrollController horizontalsScrollController = ScrollController();
  final ScrollController verticalScrollController = ScrollController();
  @override
  Widget build(BuildContext buildContext) {
    final isSearching = ref.watch(isSearchingProvider('collectors-name')) ||
        ref.watch(isSearchingProvider('collectors-firstnames')) ||
        ref.watch(isSearchingProvider('collectors-phoneNumber')) ||
        ref.watch(isSearchingProvider('collectors-address'));
    final searchedCollectorsList = ref.watch(searchedCollectorsListProvider);
    final collectorsListStream = ref.watch(collectorsListStreamProvider);
    return SizedBox(
      height: 600.0,
      child: Scrollbar(
        controller: horizontalsScrollController,
        child: SingleChildScrollView(
          controller: horizontalsScrollController,
          scrollDirection: Axis.horizontal,
          child: Scrollbar(
            controller: verticalScrollController,
            child: SingleChildScrollView(
              controller: verticalScrollController,
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
                  const DataColumn(
                    label: CBText(
                      text: 'Photo',
                      textAlign: TextAlign.start,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  DataColumn(
                    label: CBSearchInput(
                      hintText: 'Nom',
                      familyName: 'collectors-name',
                      searchProvider: searchProvider('collectors-name'),
                    ),
                    /*CBText(
                      text: 'Nom',
                      textAlign: TextAlign.start,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),*/
                  ),
                  DataColumn(
                    label: CBSearchInput(
                      hintText: 'Prénoms',
                      familyName: 'collectors-firstnames',
                      searchProvider: searchProvider('collectors-firstnames'),
                    ),
                    /*CBText(
                      text: 'Prénoms',
                      textAlign: TextAlign.start,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),*/
                  ),
                  DataColumn(
                    label: CBSearchInput(
                      hintText: 'Téléphone',
                      familyName: 'collectors-phoneNumber',
                      searchProvider: searchProvider('collectors-phoneNumber'),
                    ),
                    /*CBText(
                      text: 'Téléphone',
                      textAlign: TextAlign.start,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),*/
                  ),
                  DataColumn(
                      label: CBSearchInput(
                    hintText: 'Adresse',
                    familyName: 'collectors-address',
                    searchProvider: searchProvider('collectors-address'),
                  )
                      /* CBText(
                      text: 'Adresse',
                      textAlign: TextAlign.start,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),*/
                      ),
                  const DataColumn(
                    label: SizedBox(),
                  ),
                  const DataColumn(
                    label: SizedBox(),
                  ),
                ],
                rows: isSearching
                    ? searchedCollectorsList.when(
                        data: (data) {
                          //  debugPrint('collector Stream Data: $data');
                          return data
                              .map(
                                (collector) => DataRow(
                                  cells: [
                                    DataCell(
                                      CBText(
                                        text: '${data.indexOf(collector) + 1}',
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    DataCell(
                                      onTap: () {
                                        collector.profile != null
                                            ? FunctionsController
                                                .showAlertDialog(
                                                context: context,
                                                alertDialog: SingleImageShower(
                                                  imageSource:
                                                      collector.profile!,
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
                                        text: collector.name,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    DataCell(
                                      CBText(
                                        text: collector.firstnames,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    DataCell(
                                      CBText(
                                        text: collector.phoneNumber,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    DataCell(
                                      CBText(
                                        text: collector.address,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    DataCell(
                                      onTap: () {
                                        ref
                                            .read(collectorPictureProvider
                                                .notifier)
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
                    : collectorsListStream.when(
                        data: (data) {
                          //  debugPrint('collector Stream Data: $data');
                          return data
                              .map(
                                (collector) => DataRow(
                                  cells: [
                                    DataCell(
                                      CBText(
                                        text: '${data.indexOf(collector) + 1}',
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    DataCell(
                                      onTap: () {
                                        collector.profile != null
                                            ? FunctionsController
                                                .showAlertDialog(
                                                context: context,
                                                alertDialog: SingleImageShower(
                                                  imageSource:
                                                      collector.profile!,
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
                                        text: collector.name,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    DataCell(
                                      CBText(
                                        text: collector.firstnames,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    DataCell(
                                      CBText(
                                        text: collector.phoneNumber,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    DataCell(
                                      CBText(
                                        text: collector.address,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    DataCell(
                                      onTap: () {
                                        ref
                                            .read(collectorPictureProvider
                                                .notifier)
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
