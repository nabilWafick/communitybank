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
import 'package:communitybank/views/widgets/globals/search_input/search_input.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:communitybank/models/data/type/type.model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

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
  @override
  Widget build(BuildContext context) {
    final isSearching = ref.watch(isSearchingProvider('types'));
    final typesListStream = ref.watch(typesListStreamProvider);
    final searchedTypesList = ref.watch(searchedTypesListProvider);
    final typesList = isSearching ? searchedTypesList : typesListStream;

    ref.listen(typesListStreamProvider, (previous, next) {
      if (isSearching) {
        ref.invalidate(searchedTypesListProvider);
      }
    });

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: typesList.when(
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
                  familyName: 'types',
                  searchProvider: searchProvider('types'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 250.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Mise',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 900.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Produits',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
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
              final type = data[index];
              return Row(
                children: [
                  InkWell(
                    onTap: () {
                      FunctionsController.showAlertDialog(
                        context: context,
                        alertDialog: const MultipleImageShower(
                          products: [],
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 200.0,
                      height: 30.0,
                      child: const Icon(
                        Icons.photo,
                        color: CBColors.primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: CBText(
                      text: type.name,
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 250.0,
                    height: 30.0,
                    child: CBText(
                      text: '${type.stake.ceil()} f',
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 900.0,
                    height: 30.0,
                    child: Consumer(builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      final productsListStream =
                          ref.watch(productsListStreamProvider);
                      return productsListStream.when(
                        data: (data) {
                          String typeProducts = '';
                          //  type.products.clear();
                          for (Product product in data) {
                            for (var productId in type.productsIds) {
                              if (product.id! == productId) {
                                final typeProductNumber = type.productsNumber[
                                    type.productsIds.indexOf(productId)];

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
                          return CBText(
                            text: typeProducts,
                            fontSize: 12.0,
                          );
                        },
                        error: (error, stackTrace) => const CBText(text: ''),
                        loading: () => const CBText(text: ''),
                      );
                    }),
                  ),
                  InkWell(
                    onTap: () async {
                      ref.read(typeAddedInputsProvider.notifier).state = {};
                      // refresh typSelectedProducts provider
                      ref.read(typeSelectedProductsProvider.notifier).state =
                          {};

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
                    child: Container(
                      width: 150.0,
                      height: 30.0,
                      alignment: Alignment.centerRight,
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
                        alertDialog: TypeDeletionConfirmationDialog(
                          type: type,
                          confirmToDelete: TypeCRUDFunctions.delete,
                        ),
                      );
                    },
                    child: Container(
                      width: 150.0,
                      height: 30.0,
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
                  familyName: 'types',
                  searchProvider: searchProvider('types'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 250.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Mise',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 900.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Produits',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
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
                  familyName: 'types',
                  searchProvider: searchProvider('types'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 250.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Mise',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 900.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Produits',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
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
