import 'package:communitybank/controllers/types/types.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/types/types_crud.function.dart';
import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/images_shower/multiple/multiple_image_shower.dart';
import 'package:communitybank/views/widgets/definitions/products/products_list/products_list.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/types/types_deletion_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/globals/dropdown/dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/product_dropdown/product_dropdown.widget.dart';
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
  final selectedTypePrice = ref.watch(stringDropdownProvider('types-stackes'));
  final selectedTypeProduct =
      ref.watch(productDropdownProvider('type-products'));
  yield* TypesController.getAll(
    selectedTypeStake: selectedTypePrice,
    selectedProductId: selectedTypeProduct.id,
  );
});

class TypesList extends ConsumerWidget {
  const TypesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearching = ref.watch(isSearchingProvider('types'));
    final productsListStream = ref.watch(productsListStreamProvider);
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
                      //   debugPrint('type Stream Data: $data');

                      return data.map(
                        (type) {
                          /* String typeProducts = '';
                          for (int i = 0; i < type.products.length; ++i) {
                            if (i == 0) {
                              typeProducts =
                                  '${type.products[i].number} ${type.products[i].name}';
                            } else {
                              typeProducts =
                                  '$typeProducts, ${type.products[i].number} ${type.products[i].name}';
                            }
                          }*/
                          return DataRow(
                            cells: [
                              DataCell(
                                CBText(
                                  text: type.id!.toString(),
                                ),
                              ),
                              DataCell(
                                onTap: () {
                                  FunctionsController.showAlertDialog(
                                    context: context,
                                    alertDialog: MultipleImageShower(
                                        products: type.products),
                                  );
                                },
                                Container(
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.photo,
                                      color: CBColors.primaryColor,
                                    )),
                              ),
                              DataCell(
                                CBText(text: type.name),
                              ),
                              DataCell(
                                CBText(text: '${type.stake.ceil()} f/Jour'),
                              ),
                              DataCell(
                                CBText(
                                    text: productsListStream.when(
                                  data: (data) {
                                    String typeProducts = '';
                                    for (Product dataProduct in data) {
                                      for (Product product in type.products) {
                                        if (dataProduct.id! == product.id!) {
                                          if (typeProducts.isEmpty) {
                                            typeProducts =
                                                '${product.number} ${dataProduct.name}';
                                          } else {
                                            typeProducts =
                                                '$typeProducts, ${product.number} ${dataProduct.name}';
                                          }
                                        }
                                      }
                                    }
                                    return typeProducts;
                                  },
                                  error: (error, stackTrace) => '',
                                  loading: () => '',
                                )
                                    // typeProducts,
                                    //  type.products.length.toString(),
                                    ),
                              ),
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
                                  FunctionsController.showAlertDialog(
                                    context: context,
                                    alertDialog: TypeDeletionConfirmationDialog(
                                      type: type,
                                      confirmToDelete: TypeCRUDFunctions.delete,
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
                          );
                        },
                      ).toList();
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
                      //   debugPrint('type Stream Data: $data');

                      return data.map(
                        (type) {
                          /* String typeProducts = '';
                          for (int i = 0; i < type.products.length; ++i) {
                            if (i == 0) {
                              typeProducts =
                                  '${type.products[i].number} ${type.products[i].name}';
                            } else {
                              typeProducts =
                                  '$typeProducts, ${type.products[i].number} ${type.products[i].name}';
                            }
                          }*/
                          return DataRow(
                            cells: [
                              DataCell(
                                CBText(
                                  text: type.id!.toString(),
                                ),
                              ),
                              DataCell(
                                onTap: () {
                                  FunctionsController.showAlertDialog(
                                    context: context,
                                    alertDialog: MultipleImageShower(
                                        products: type.products),
                                  );
                                },
                                Container(
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.photo,
                                      color: CBColors.primaryColor,
                                    )),
                              ),
                              DataCell(
                                CBText(text: type.name),
                              ),
                              DataCell(
                                CBText(text: '${type.stake.ceil()} f/Jour'),
                              ),
                              DataCell(
                                CBText(
                                    text: productsListStream.when(
                                  data: (data) {
                                    String typeProducts = '';
                                    for (Product dataProduct in data) {
                                      for (Product product in type.products) {
                                        if (dataProduct.id! == product.id!) {
                                          if (typeProducts.isEmpty) {
                                            typeProducts =
                                                '${product.number} ${dataProduct.name}';
                                          } else {
                                            typeProducts =
                                                '$typeProducts, ${product.number} ${dataProduct.name}';
                                          }
                                        }
                                      }
                                    }
                                    return typeProducts;
                                  },
                                  error: (error, stackTrace) => '',
                                  loading: () => '',
                                )
                                    // typeProducts,
                                    //  type.products.length.toString(),
                                    ),
                              ),
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
                                  FunctionsController.showAlertDialog(
                                    context: context,
                                    alertDialog: TypeDeletionConfirmationDialog(
                                      type: type,
                                      confirmToDelete: TypeCRUDFunctions.delete,
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
                          );
                        },
                      ).toList();
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
