import 'package:communitybank/controllers/personal_status/personal_status.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/personal_status/personal_status_crud.function.dart';
import 'package:communitybank/models/data/personal_status/personal_status.model.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/personal_status/personal_status_deletion_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/update/personal_status/personal_status_update_form.widget.dart';
import 'package:communitybank/views/widgets/globals/search_input/search_input.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchedPersonalStatusListProvider =
    StreamProvider<List<PersonalStatus>>((ref) async* {
  String searchedPersonalStatus = ref.watch(searchProvider('personal-status'));
  ref.listen(searchProvider('personal-status'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('personal-status').notifier).state = true;
    } else {
      ref.read(isSearchingProvider('personal-status').notifier).state = false;
    }
  });
  yield* PersonalStatusController.searchPersonalStatus(
          name: searchedPersonalStatus)
      .asStream();
});

final personalStatusListStreamProvider =
    StreamProvider<List<PersonalStatus>>((ref) async* {
  yield* PersonalStatusController.getAll();
});

class PersonalStatusList extends ConsumerWidget {
  const PersonalStatusList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearching = ref.watch(isSearchingProvider('personal-status'));
    final personalStatusListStream =
        ref.watch(personalStatusListStreamProvider);
    final searchedPersonalStatusList =
        ref.watch(searchedPersonalStatusListProvider);

    return SizedBox(
      height: 600.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
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
                  hintText: 'Nom',
                  familyName: 'personal-status',
                  searchProvider: searchProvider('personal-status'),
                ),
                /*CBText(
                  text: 'Nom',
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
                ? searchedPersonalStatusList.when(
                    data: (data) {
                      //  debugPrint('PersonalStatus Stream Data: $data');
                      return data
                          .map(
                            (personalStatus) => DataRow(
                              cells: [
                                DataCell(
                                  CBText(
                                    text: '${data.indexOf(personalStatus) + 1}',
                                    fontSize: 12.0,
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: personalStatus.name,
                                    fontSize: 12.0,
                                  ),
                                ),
                                DataCell(
                                  onTap: () {
                                    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog: PersonalStatusUpdateForm(
                                          personalStatus: personalStatus),
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
                                          PersonalStatusDeletionConfirmationDialog(
                                        personalStatus: personalStatus,
                                        confirmToDelete:
                                            PersonalStatusCRUDFunctions.delete,
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
                      //  debugPrint('PersonalStatuss Stream Error');
                      return [];
                    },
                    loading: () {
                      //  debugPrint('PersonalStatuss Stream Loading');
                      return [];
                    },
                  )
                : personalStatusListStream.when(
                    data: (data) {
                      //  debugPrint('PersonalStatus Stream Data: $data');
                      return data
                          .map(
                            (personalStatus) => DataRow(
                              cells: [
                                DataCell(
                                  CBText(
                                    text: '${data.indexOf(personalStatus) + 1}',
                                    fontSize: 12.0,
                                  ),
                                ),
                                DataCell(
                                  CBText(
                                    text: personalStatus.name,
                                    fontSize: 12.0,
                                  ),
                                ),
                                DataCell(
                                  onTap: () {
                                    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog: PersonalStatusUpdateForm(
                                          personalStatus: personalStatus),
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
                                          PersonalStatusDeletionConfirmationDialog(
                                        personalStatus: personalStatus,
                                        confirmToDelete:
                                            PersonalStatusCRUDFunctions.delete,
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
                      //  debugPrint('PersonalStatuss Stream Error');
                      return [];
                    },
                    loading: () {
                      //  debugPrint('PersonalStatuss Stream Loading');
                      return [];
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
