import 'package:communitybank/controllers/localities/localities.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/localities/localities_crud.function.dart';
import 'package:communitybank/models/data/locality/locality.model.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/localities/localities_deletion_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/update/localities/localities_update_form.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchedLocalitiesListProvider =
    StreamProvider<List<Locality>>((ref) async* {
  String searchedLocality = ref.watch(searchProvider('localities'));
  ref.listen(searchProvider('localities'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('localities').notifier).state = true;
    } else {
      ref.read(isSearchingProvider('localities').notifier).state = false;
    }
  });
  yield* LocalitiesController.searchLocality(name: searchedLocality).asStream();
});

final localityListStreamProvider = StreamProvider<List<Locality>>((ref) async* {
  yield* LocalitiesController.getAll();
});

class LocalitiesList extends ConsumerWidget {
  const LocalitiesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearching = ref.watch(isSearchingProvider('localities'));
    final localitiesListStream = ref.watch(localityListStreamProvider);
    final searchedLocalitiesList = ref.watch(searchedLocalitiesListProvider);

    return SizedBox(
      height: 600.0,
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
                  text: 'Nom',
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
                ? searchedLocalitiesList.when(
                    data: (data) {
                      //  debugPrint('Locality Stream Data: $data');
                      return data
                          .map(
                            (locality) => DataRow(
                              cells: [
                                DataCell(
                                  CBText(
                                    text: '${data.indexOf(locality) + 1}',
                                  ),
                                ),
                                DataCell(
                                  CBText(text: locality.name),
                                ),
                                DataCell(
                                  onTap: () {
                                    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog: LocalityUpdateForm(
                                          locality: locality),
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
                                          LocalityDeletionConfirmationDialog(
                                        locality: locality,
                                        confirmToDelete:
                                            LocalityCRUDFunctions.delete,
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
                      //  debugPrint('Localitys Stream Error');
                      return [];
                    },
                    loading: () {
                      //  debugPrint('Localitys Stream Loading');
                      return [];
                    },
                  )
                : localitiesListStream.when(
                    data: (data) {
                      //  debugPrint('Locality Stream Data: $data');
                      return data
                          .map(
                            (locality) => DataRow(
                              cells: [
                                DataCell(
                                  CBText(
                                    text: '${data.indexOf(locality) + 1}',
                                  ),
                                ),
                                DataCell(
                                  CBText(text: locality.name),
                                ),
                                DataCell(
                                  onTap: () {
                                    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog: LocalityUpdateForm(
                                          locality: locality),
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
                                          LocalityDeletionConfirmationDialog(
                                        locality: locality,
                                        confirmToDelete:
                                            LocalityCRUDFunctions.delete,
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
                      //  debugPrint('Localitys Stream Error');
                      return [];
                    },
                    loading: () {
                      //  debugPrint('Localitys Stream Loading');
                      return [];
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
