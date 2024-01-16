import 'package:communitybank/controllers/collectors/collectors.controller.dart';
import 'package:communitybank/controllers/forms/validators/collector/collector.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/collectors/collectors_crud.function.dart';
import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/images_shower/single/single_image_shower.widget.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/collectors/collectors_deletion_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/update/collectors/collectors_update_form.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchedcollectorsListProvider =
    StreamProvider<List<Collector>>((ref) async* {
  String searchedcollector = ref.watch(searchProvider('collectors'));
  ref.listen(searchProvider('collectors'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('collectors').notifier).state = true;
    } else {
      ref.read(isSearchingProvider('collectors').notifier).state = false;
    }
  });
  yield* CollectorsController.searchCollector(name: searchedcollector)
      .asStream();
});

final collectorsListStreamProvider =
    StreamProvider<List<Collector>>((ref) async* {
  yield* CollectorsController.getAll();
});

class CollectorsList extends ConsumerWidget {
  const CollectorsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearching = ref.watch(isSearchingProvider('collectors'));
    final searchedCollectorsList = ref.watch(searchedcollectorsListProvider);
    final collectorsListStream = ref.watch(collectorsListStreamProvider);
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
                : collectorsListStream.when(
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
          ),
        ),
      ),
    );
  }
}
