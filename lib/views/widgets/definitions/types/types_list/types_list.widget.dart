import 'package:communitybank/controllers/types/types.controller.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/globals/dropdown/dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:communitybank/models/data/type/type.model.dart';

final searchedTypesListProvider = StreamProvider<List<Type>>((ref) async* {
  String searchedType = ref.watch(searchProvider('types'));
  ref.listen(searchProvider('types'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('types').notifier).state = true;
    } else {
      ref.read(isSearchingProvider('types').notifier).state = false;
    }
  });
  yield* TypesController.searchType(name: searchedType).asStream();
});

final typesListStreamProvider = StreamProvider<List<Type>>((ref) async* {
  /* final selectedTypePrice =
      ref.watch(dropdownSelectedItemProvider('types-stackes'));*/
  yield* TypesController.getAll(selectedTypeStake: '*' /*selectedTypePrice*/);
});

class TypesList extends ConsumerWidget {
  const TypesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearching = ref.watch(isSearchingProvider('types'));
    final typesListStream = ref.watch(typesListStreamProvider);
    final searchedTypesList = ref.watch(searchedTypesListProvider);
    return SizedBox(
      height: 640.0,
      // width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
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
                  text: 'Photos',
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
                label: CBText(
                  text: 'Mise',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(
                label: CBText(
                  text: 'Produits',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(label: SizedBox()),
              DataColumn(label: SizedBox()),
            ],
            rows: isSearching
                ? searchedTypesList.when(
                    data: (data) {
                      debugPrint('type Stream Data: $data');
                      return data
                          .map(
                            (type) => DataRow(
                              cells: [
                                DataCell(
                                  CBText(
                                    text: type.id!.toString(),
                                  ),
                                ),
                                DataCell(
                                  onTap: () {
                                    // type.picture != null
                                    //     ? FunctionsController.showAlertDialog(
                                    //         context: context,
                                    //         alertDialog: SingleImageShower(
                                    //           imageSource: type.picture!,
                                    //         ),
                                    //       )
                                    //     : () {};
                                  },
                                  Container(
                                      alignment: Alignment.center,
                                      child: /* type.picture != null
                                        ?*/
                                          const Icon(
                                        Icons.photo,
                                        color: CBColors.primaryColor,
                                      )
                                      //  : const SizedBox(),
                                      ),
                                ),
                                DataCell(
                                  CBText(text: type.name),
                                ),
                                DataCell(
                                  CBText(text: '${type.stake.ceil()} f/Jour'),
                                ),
                                const DataCell(SizedBox()),
                                DataCell(
                                  onTap: () {
                                    // ref
                                    //     .read(typePictureProvider.notifier)
                                    //     .state = null;
                                    // FunctionsController.showAlertDialog(
                                    //   context: context,
                                    //   alertDialog:
                                    //       typeUpdateForm(type: type),
                                    // );
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
                                    // FunctionsController.showAlertDialog(
                                    //   context: context,
                                    //   alertDialog:
                                    //       typeDeletionConfirmationDialog(
                                    //     type: type,
                                    //     confirmToDelete:
                                    //         typeCRUDFunctions.delete,
                                    //   ),
                                    // );
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
                      //  debugPrint('types Stream Error');
                      return [];
                    },
                    loading: () {
                      //  debugPrint('types Stream Loading');
                      return [];
                    },
                  )
                : typesListStream.when(
                    data: (data) {
                      //  debugPrint('type Stream Data: $data');
                      return data
                          .map(
                            (type) => DataRow(
                              cells: [
                                DataCell(
                                  CBText(
                                    text: type.id!.toString(),
                                  ),
                                ),
                                DataCell(
                                  onTap: () {
                                    // type.picture != null
                                    //     ? FunctionsController.showAlertDialog(
                                    //         context: context,
                                    //         alertDialog: SingleImageShower(
                                    //           imageSource: type.picture!,
                                    //         ),
                                    //       )
                                    //     : () {};
                                  },
                                  Container(
                                      alignment: Alignment.center,
                                      child:
                                          /*
                                     type.picture != null
                                        ?
                                        */
                                          const Icon(
                                        Icons.photo,
                                        color: CBColors.primaryColor,
                                      )
                                      //  : const SizedBox(),
                                      ),
                                ),
                                DataCell(
                                  CBText(text: type.name),
                                ),
                                DataCell(
                                  CBText(text: '${type.stake.ceil()} f/Jour'),
                                ),
                                const DataCell(SizedBox()),
                                DataCell(
                                  onTap: () {
                                    // ref
                                    //     .read(typePictureProvider.notifier)
                                    //     .state = null;
                                    // FunctionsController.showAlertDialog(
                                    //   context: context,
                                    //   alertDialog:
                                    //       typeUpdateForm(type: type),
                                    // );
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
                                    // FunctionsController.showAlertDialog(
                                    //   context: context,
                                    //   alertDialog:
                                    //       typeDeletionConfirmationDialog(
                                    //     type: type,
                                    //     confirmToDelete:
                                    //         typeCRUDFunctions.delete,
                                    //   ),
                                    // );
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
                      //  debugPrint('types Stream Error');
                      return [];
                    },
                    loading: () {
                      //  debugPrint('types Stream Loading');
                      return [];
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
