import 'package:communitybank/controllers/economical_activities/economical_activities.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/economical_activities/economical_activities_crud.function.dart';
import 'package:communitybank/models/data/economical_activity/economical_activity.model.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/economical_activities/economical_activities_deletion_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/update/economical_activities/economical_activities_update_form.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchedEconomicalActivitiesListProvider =
    StreamProvider<List<EconomicalActivity>>((ref) async* {
  String searchedEconomicalActivity =
      ref.watch(searchProvider('economical-actvities'));
  ref.listen(searchProvider('economical-actvities'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('economical-actvities').notifier).state =
          true;
    } else {
      ref.read(isSearchingProvider('economical-actvities').notifier).state =
          false;
    }
  });
  yield* EconomicalActivitiesController.searchEconomicalActivity(
          name: searchedEconomicalActivity)
      .asStream();
});

final economicalActivityListStreamProvider =
    StreamProvider<List<EconomicalActivity>>((ref) async* {
  yield* EconomicalActivitiesController.getAll();
});

class EconomicalActivitiesList extends ConsumerWidget {
  const EconomicalActivitiesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearching = ref.watch(isSearchingProvider('economical-actvities'));
    final economicalActivitiesListStream =
        ref.watch(economicalActivityListStreamProvider);
    final searchedEconomicalActivitiesList =
        ref.watch(searchedEconomicalActivitiesListProvider);

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
                ? searchedEconomicalActivitiesList.when(
                    data: (data) {
                      //  debugPrint('EconomicalActivity Stream Data: $data');
                      return data
                          .map(
                            (economicalActivity) => DataRow(
                              cells: [
                                DataCell(
                                  CBText(
                                    text:
                                        '${data.indexOf(economicalActivity) + 1}',
                                  ),
                                ),
                                DataCell(
                                  CBText(text: economicalActivity.name),
                                ),
                                DataCell(
                                  onTap: () {
                                    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog: EconomicalActivityUpdateForm(
                                          economicalActivity:
                                              economicalActivity),
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
                                          EconomicalActivityDeletionConfirmationDialog(
                                        economicalActivity: economicalActivity,
                                        confirmToDelete:
                                            EconomicalActivityCRUDFunctions
                                                .delete,
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
                      //  debugPrint('EconomicalActivitys Stream Error');
                      return [];
                    },
                    loading: () {
                      //  debugPrint('EconomicalActivitys Stream Loading');
                      return [];
                    },
                  )
                : economicalActivitiesListStream.when(
                    data: (data) {
                      //  debugPrint('EconomicalActivity Stream Data: $data');
                      return data
                          .map(
                            (economicalActivity) => DataRow(
                              cells: [
                                DataCell(
                                  CBText(
                                    text:
                                        '${data.indexOf(economicalActivity) + 1}',
                                  ),
                                ),
                                DataCell(
                                  CBText(text: economicalActivity.name),
                                ),
                                DataCell(
                                  onTap: () {
                                    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog: EconomicalActivityUpdateForm(
                                          economicalActivity:
                                              economicalActivity),
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
                                          EconomicalActivityDeletionConfirmationDialog(
                                        economicalActivity: economicalActivity,
                                        confirmToDelete:
                                            EconomicalActivityCRUDFunctions
                                                .delete,
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
                      //  debugPrint('EconomicalActivitys Stream Error');
                      return [];
                    },
                    loading: () {
                      //  debugPrint('EconomicalActivitys Stream Loading');
                      return [];
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
