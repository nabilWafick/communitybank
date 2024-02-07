import 'package:communitybank/controllers/forms/validators/type/type.validator.dart';
import 'package:communitybank/controllers/types/types.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/types/types_crud.function.dart';
import 'package:communitybank/models/data/product/product.model.dart';
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
import 'package:communitybank/models/data/type/type.model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

class TypesList extends StatefulHookConsumerWidget {
  const TypesList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TypesListState();
}

class _TypesListState extends ConsumerState<TypesList> {
  final ScrollController horizontallScrollController = ScrollController();
  final ScrollController verticalScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final isSearching = ref.watch(isSearchingProvider('types'));
    final typesListStream = ref.watch(typesListStreamProvider);
    final searchedTypesList = ref.watch(searchedTypesListProvider);
    return SizedBox(
      height: 600.0,
      // width: MediaQuery.of(context).size.width,
      child: Scrollbar(
        controller: horizontallScrollController,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: horizontallScrollController,
          child: Scrollbar(
            controller: verticalScrollController,
            child: SingleChildScrollView(
              controller: verticalScrollController,
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
                          return data.map(
                            (type) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    CBText(
                                      text: '${data.indexOf(type) + 1}',
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
                                      ),
                                    ),
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
                                            for (var productId
                                                in type.productsIds) {
                                              if (product.id! == productId) {
                                                final typeProductNumber =
                                                    type.productsNumber[type
                                                        .productsIds
                                                        .indexOf(productId)];

                                                if (typeProducts.isEmpty) {
                                                  typeProducts =
                                                      '$typeProductNumber * ${product.name}';
                                                } else {
                                                  typeProducts =
                                                      '$typeProducts, $typeProductNumber * ${product.name}';
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
                                                    '$typeProductNumber * ${product.name}';
                                              } else {
                                                typeProducts =
                                                    '$typeProducts, $typeProductNumber * ${product.name}';
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
                                      ref
                                          .read(
                                              typeAddedInputsProvider.notifier)
                                          .state = {};
                                      // refresh typSelectedProducts provider
                                      ref
                                          .read(typeSelectedProductsProvider
                                              .notifier)
                                          .state = {};

                                      // automatically add the type products input  s after rendering
                                      for (dynamic productId
                                          in type.productsIds) {
                                        ref
                                            .read(typeAddedInputsProvider
                                                .notifier)
                                            .update((state) {
                                          state[productId!] = true;
                                          return state;
                                        });
                                      }
                                      await FunctionsController.showAlertDialog(
                                        context: context,
                                        alertDialog:
                                            TypesUpdateForm(type: type),
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
                                            TypeDeletionConfirmationDialog(
                                          type: type,
                                          confirmToDelete:
                                              TypeCRUDFunctions.delete,
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
                          return data.map(
                            (type) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    CBText(
                                      text: '${data.indexOf(type) + 1}',
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
                                      ),
                                    ),
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
                                            for (var productId
                                                in type.productsIds) {
                                              if (product.id! == productId) {
                                                final typeProductNumber =
                                                    type.productsNumber[type
                                                        .productsIds
                                                        .indexOf(productId)];

                                                if (typeProducts.isEmpty) {
                                                  typeProducts =
                                                      '$typeProductNumber * ${product.name}';
                                                } else {
                                                  typeProducts =
                                                      '$typeProducts, $typeProductNumber * ${product.name}';
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
                                    }),
                                  ),
                                  DataCell(
                                    onTap: () async {
                                      ref
                                          .read(
                                              typeAddedInputsProvider.notifier)
                                          .state = {};
                                      // refresh typSelectedProducts provider
                                      ref
                                          .read(typeSelectedProductsProvider
                                              .notifier)
                                          .state = {};

                                      // automatically add the type products input  s after rendering
                                      for (dynamic productId
                                          in type.productsIds) {
                                        ref
                                            .read(typeAddedInputsProvider
                                                .notifier)
                                            .update((state) {
                                          state[productId!] = true;
                                          return state;
                                        });
                                      }
                                      await FunctionsController.showAlertDialog(
                                        context: context,
                                        alertDialog:
                                            TypesUpdateForm(type: type),
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
                                            TypeDeletionConfirmationDialog(
                                          type: type,
                                          confirmToDelete:
                                              TypeCRUDFunctions.delete,
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
        ),
      ),
    );
  }
}
