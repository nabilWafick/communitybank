import 'package:communitybank/controllers/personal_status/personal_status.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/personal_status/personal_status_crud.function.dart';
import 'package:communitybank/models/data/personal_status/personal_status.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/personal_status/personal_status_deletion_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/update/personal_status/personal_status_update_form.widget.dart';
import 'package:communitybank/views/widgets/globals/search_input/search_input.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

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
    final personalStatusList =
        isSearching ? searchedPersonalStatusList : personalStatusListStream;

    ref.listen(personalStatusListStreamProvider, (previous, next) {
      if (isSearching) {
        ref.invalidate(searchedPersonalStatusListProvider);
      }
    });

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        width: 800.0,
        child: personalStatusList.when(
          data: (data) => HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: 700,
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
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Nom',
                  familyName: 'personal-status',
                  searchProvider: searchProvider('personal-status'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
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
              final personalStatus = data[index];
              return Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: CBText(
                      text: personalStatus.name,
                      fontSize: 12.0,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      FunctionsController.showAlertDialog(
                        context: context,
                        alertDialog: PersonalStatusUpdateForm(
                          personalStatus: personalStatus,
                        ),
                      );
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
                      FunctionsController.showAlertDialog(
                        context: context,
                        alertDialog: PersonalStatusDeletionConfirmationDialog(
                          personalStatus: personalStatus,
                          confirmToDelete: PersonalStatusCRUDFunctions.delete,
                        ),
                      );
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
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Nom',
                  familyName: 'personal-status',
                  searchProvider: searchProvider('personal-status'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
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
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Nom',
                  familyName: 'personal-status',
                  searchProvider: searchProvider('personal-status'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
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
