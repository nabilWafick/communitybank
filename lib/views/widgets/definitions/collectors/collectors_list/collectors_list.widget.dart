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
import 'package:horizontal_data_table/horizontal_data_table.dart';

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
  @override
  Widget build(BuildContext context) {
    final isSearching = ref.watch(isSearchingProvider('collectors-name')) ||
        ref.watch(isSearchingProvider('collectors-firstnames')) ||
        ref.watch(isSearchingProvider('collectors-phoneNumber')) ||
        ref.watch(isSearchingProvider('collectors-address'));
    final searchedCollectorsList = ref.watch(searchedCollectorsListProvider);
    final collectorsListStream = ref.watch(collectorsListStreamProvider);
    final collectorsList =
        isSearching ? searchedCollectorsList : collectorsListStream;

    ref.listen(collectorsListStreamProvider, (previous, next) {
      if (isSearching) {
        ref.invalidate(searchedCollectorsListProvider);
      }
    });

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: collectorsList.when(
          data: (data) => HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: MediaQuery.of(context).size.width + 400,
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
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Photo',
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
                  familyName: 'collectors',
                  searchProvider: searchProvider('collectors-name'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Prénoms',
                  familyName: 'collectors-firstnames',
                  searchProvider: searchProvider('collectors-firstnames'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Téléphone',
                  familyName: 'collectors-phoneNumber',
                  searchProvider: searchProvider('collectors-phoneNumber'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Adresse',
                  familyName: 'collectors-address',
                  searchProvider: searchProvider('collectors-address'),
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
              final collector = data[index];
              return Row(
                children: [
                  InkWell(
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
                    child: Container(
                      alignment: Alignment.center,
                      width: 200.0,
                      height: 30.0,
                      child: collector.profile != null
                          ? const Icon(
                              Icons.photo,
                              color: CBColors.primaryColor,
                            )
                          : const SizedBox(),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: CBText(
                      text: collector.name,
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: CBText(
                      text: collector.firstnames,
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: CBText(
                      text: collector.phoneNumber,
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: CBText(
                      text: collector.address,
                      fontSize: 12.0,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      ref.read(collectorPictureProvider.notifier).state = null;
                      FunctionsController.showAlertDialog(
                        context: context,
                        alertDialog: CollectorUpdateForm(
                          collector: collector,
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
                        alertDialog: CollectorDeletionConfirmationDialog(
                          collector: collector,
                          confirmToDelete: CollectorCRUDFunctions.delete,
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
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Photo',
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
                  familyName: 'collectors',
                  searchProvider: searchProvider('collectors'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Prénoms',
                  familyName: 'collectors-firstnames',
                  searchProvider: searchProvider('collectors-firstnames'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Téléphone',
                  familyName: 'collectors-phoneNumber',
                  searchProvider: searchProvider('collectors-phoneNumber'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Adresse',
                  familyName: 'collectors-address',
                  searchProvider: searchProvider('collectors-address'),
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
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Photo',
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
                  familyName: 'collectors',
                  searchProvider: searchProvider('collectors'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Prénoms',
                  familyName: 'collectors-firstnames',
                  searchProvider: searchProvider('collectors-firstnames'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Téléphone',
                  familyName: 'collectors-phoneNumber',
                  searchProvider: searchProvider('collectors-phoneNumber'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Adresse',
                  familyName: 'collectors-address',
                  searchProvider: searchProvider('collectors-address'),
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
