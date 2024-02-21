import 'package:communitybank/controllers/economical_activities/economical_activities.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/economical_activities/economical_activities_crud.function.dart';
import 'package:communitybank/models/data/economical_activity/economical_activity.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/economical_activities/economical_activities_deletion_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/update/economical_activities/economical_activities_update_form.widget.dart';
import 'package:communitybank/views/widgets/globals/search_input/search_input.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

final searchedEconomicalActivitiesListProvider =
    StreamProvider<List<EconomicalActivity>>((ref) async* {
  String searchedEconomicalActivity =
      ref.watch(searchProvider('economical-activities'));
  ref.listen(searchProvider('economical-activities'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('economical-activities').notifier).state =
          true;
    } else {
      ref.read(isSearchingProvider('economical-activities').notifier).state =
          false;
    }
  });
  yield* EconomicalActivitiesController.searchEconomicalActivity(
          name: searchedEconomicalActivity)
      .asStream();
});

final economicalActivitiesListStreamProvider =
    StreamProvider<List<EconomicalActivity>>((ref) async* {
  yield* EconomicalActivitiesController.getAll();
});

class EconomicalActivitiesList extends ConsumerWidget {
  const EconomicalActivitiesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearching = ref.watch(isSearchingProvider('economical-activities'));
    final economicalActivitiesListStream =
        ref.watch(economicalActivitiesListStreamProvider);
    final searchedEconomicalActivitiesList =
        ref.watch(searchedEconomicalActivitiesListProvider);
    final economicalActivitiesList = isSearching
        ? searchedEconomicalActivitiesList
        : economicalActivitiesListStream;

    ref.listen(economicalActivitiesListStreamProvider, (previous, next) {
      if (isSearching) {
        ref.invalidate(searchedEconomicalActivitiesListProvider);
      }
    });

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        width: 800.0,
        child: economicalActivitiesList.when(
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
                  familyName: 'economical-activities',
                  searchProvider: searchProvider('economical-activities'),
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
              final economicalActivity = data[index];
              return Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: CBText(
                      text: economicalActivity.name,
                      fontSize: 12.0,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      FunctionsController.showAlertDialog(
                        context: context,
                        alertDialog: EconomicalActivityUpdateForm(
                          economicalActivity: economicalActivity,
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
                        alertDialog:
                            EconomicalActivityDeletionConfirmationDialog(
                          economicalActivity: economicalActivity,
                          confirmToDelete:
                              EconomicalActivityCRUDFunctions.delete,
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
                  familyName: 'economical-activities',
                  searchProvider: searchProvider('economical-activities'),
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
                  familyName: 'economical-activities',
                  searchProvider: searchProvider('economical-activities'),
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
