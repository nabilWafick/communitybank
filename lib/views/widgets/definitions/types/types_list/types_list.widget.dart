import 'package:communitybank/controllers/forms/validators/type/type.validator.dart';
import 'package:communitybank/controllers/types/types.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/types/types_crud.function.dart';
import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/services/types/types.service.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/images_shower/multiple/multiple_image_shower.dart';
import 'package:communitybank/views/widgets/definitions/products/products_list/products_list.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/types/types_deletion_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/update/types/types_update_form.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/product/product_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/string_dropdown/string_dropdown.widget.dart';
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
  final selectedTypePrice = ref.watch(
    listStringDropdownProvider('types-stackes'),
  );
  final selectedTypeProduct = ref.watch(
    listProductDropdownProvider('types-products'),
  );
  yield* TypesController.getAll(
    // ref: ref,
    selectedTypeStake: selectedTypePrice,
    selectedProductId: selectedTypeProduct.id,
  );
});

final typesListMapStreamProvider = StreamProvider<List<Map>>((ref) async* {
  final selectedTypePrice =
      ref.watch(listStringDropdownProvider('types-stackes'));
  // final selectedTypeProduct =
  //     ref.watch(listProductDropdownProvider('type-products'));
  yield* TypesService.getAll(
    // ref: ref,
    selectedTypeStake: selectedTypePrice,
    //  selectedProductId: selectedTypeProduct.id,
  );
});

class TypesList extends ConsumerWidget {
  const TypesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  final isSearching = ref.watch(isSearchingProvider('types'));

    final typesListStream = ref.watch(typesListStreamProvider);
    // final typesListMapStream = ref.watch(typesListMapStreamProvider);
    //  final searchedTypesList = ref.watch(searchedTypesListProvider);
    return SizedBox(
      height: 640.0,
      // width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: /* CBText(
          text: typesListStream.when(
            data: (data) => 'data.length.toString()',
            error: (error, stackTrace) => '',
            loading: () => '',
          ),
        )*/

              DataTable(
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
            rows:
                /*
            isSearching
                ? searchedTypesList.when(
                    data: (data) {
                      return data.map(
                        (type) {
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
                                    // reset type products list for avoiding mutilple product adding which will be caused by stream
                                    type.products = [];
                                    String typeProducts = '';
                                    //  type.products.clear();
                                    for (Product product in data) {
                                      for (var productId in type.productsIds!) {
                                        if (product.id! == productId) {
                                          // get product number in type.productsNumber
                                          // by using the index of product id in type.productsIds
                                          final typeProductNumber =
                                              type.productsNumber![type
                                                  .productsIds!
                                                  .indexOf(productId)]; 
                                          type.products.add(
                                            product.copyWith(
                                                number: typeProductNumber),
                                          );
                                          if (typeProducts.isEmpty) {
                                            typeProducts =
                                                '$typeProductNumber ${product.name}';
                                          } else {
                                            typeProducts =
                                                '$typeProducts, $typeProductNumber ${product.name}';
                                          }
                                        }
                                      }
                                    }
                                    //  debugPrint('type products: ${type.products}');
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
                                  ref
                                      .read(typeAddedInputsProvider.notifier)
                                      .state = {};
                                  // refresh typSelectedProducts provider
                                  ref
                                      .read(
                                          typeSelectedProductsProvider.notifier)
                                      .state = {};

                                  // automatically add the type products inputs after rendering
                                  for (Product product in type.products) {
                                    ref
                                        .read(typeAddedInputsProvider.notifier)
                                        .update((state) {
                                      state[product.id!] = true;
                                      return state;
                                    });
                                  }
                                  FunctionsController.showAlertDialog(
                                    context: context,
                                    alertDialog: TypesUpdateForm(type: type),
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
                :
                */
                typesListStream.when(
              data: (data) {
                return data.map(
                  (type) {
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
                              alertDialog: const MultipleImageShower(
                                products: [],
                              ),
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
                          Consumer(builder: (BuildContext context,
                                  WidgetRef ref, Widget? child) {
                            final productsListStream =
                                ref.watch(productsListStreamProvider);
                            return productsListStream.when(
                              data: (data) {
                                String typeProducts = '';
                                //  type.products.clear();
                                for (Product product in data) {
                                  for (var productId in type.productsIds) {
                                    if (product.id! == productId) {
                                      final typeProductNumber = type
                                              .productsNumber[
                                          type.productsIds.indexOf(productId)];

                                      if (typeProducts.isEmpty) {
                                        typeProducts =
                                            '$typeProductNumber ${product.name}';
                                      } else {
                                        typeProducts =
                                            '$typeProducts, $typeProductNumber ${product.name}';
                                      }
                                    }
                                  }
                                }
                                //  debugPrint('type products: ${type.products}');
                                return CBText(text: typeProducts);
                              },
                              error: (error, stackTrace) =>
                                  const CBText(text: ''),
                              loading: () => const CBText(text: ''),
                            );
                          } // typeProducts,
                              //  type.products.length.toString(),
                              //   )

                              // },))
                              /*
                                CBText(
                                    text: productsListStream.when(
                                  data: (data) {
                                    String typeProducts = '';
                                    //  type.products.clear();
                                    for (Product product in data) {
                                      for (var productId in type.productsIds) {
                                        if (product.id! == productId) {
                                          
                                          final typeProductNumber =
                                              type.productsNumber[type
                                                  .productsIds
                                                  .indexOf(productId)];
                                          
                                          if (typeProducts.isEmpty) {
                                            typeProducts =
                                                '$typeProductNumber ${product.name}';
                                          } else {
                                            typeProducts =
                                                '$typeProducts, $typeProductNumber ${product.name}';
                                          }
                                        }
                                      }
                                    }
                                    //  debugPrint('type products: ${type.products}');
                                    return typeProducts;
                                  },
                                  error: (error, stackTrace) => '',
                                  loading: () => '',
                                )*/
                              // typeProducts,
                              //  type.products.length.toString(),
                              ),
                        ),
                        DataCell(
                          onTap: () async {
                            ref.read(typeAddedInputsProvider.notifier).state =
                                {};
                            // refresh typSelectedProducts provider
                            ref
                                .read(typeSelectedProductsProvider.notifier)
                                .state = {};

                            // automatically add the type products input  s after rendering
                            for (dynamic productId in type.productsIds) {
                              ref
                                  .read(typeAddedInputsProvider.notifier)
                                  .update((state) {
                                state[productId!] = true;
                                return state;
                              });
                            }
                            await FunctionsController.showAlertDialog(
                              context: context,
                              alertDialog: TypesUpdateForm(type: type),
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
