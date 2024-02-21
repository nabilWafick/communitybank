import 'package:communitybank/controllers/forms/validators/product/product.validator.dart';
import 'package:communitybank/controllers/products/products.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/products/products_crud.function.dart';
import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/images_shower/single/single_image_shower.widget.dart';
import 'package:communitybank/views/widgets/definitions/products/products.widgets.dart';
import 'package:communitybank/views/widgets/forms/deletion_confirmation_dialog/products/products_deletion_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/update/products/products_update_form.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/string_dropdown/string_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/search_input/search_input.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

final searchedProductsListProvider =
    StreamProvider<List<Product>>((ref) async* {
  String searchedProduct = ref.watch(searchProvider('products'));
  ref.listen(searchProvider('products'), (previous, next) {
    if (previous != next && next != '' && next.trim() != '') {
      ref.read(isSearchingProvider('products').notifier).state = true;
    } else {
      ref.read(isSearchingProvider('products').notifier).state = false;
    }
  });
  yield* ProductsController.searchProduct(name: searchedProduct).asStream();
});

final productsListStreamProvider = StreamProvider<List<Product>>((ref) async* {
  final selectedProductPrice =
      ref.watch(listStringDropdownProvider('products-price'));
  yield* ProductsController.getAll(selectedProductPrice: selectedProductPrice);
});

class ProductsList extends StatefulHookConsumerWidget {
  const ProductsList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductsListState();
}

class _ProductsListState extends ConsumerState<ProductsList> {
  @override
  Widget build(BuildContext context) {
    final isSearching = ref.watch(isSearchingProvider('products'));
    final productsListStream = ref.watch(productsListStreamProvider);
    final searchedProductsList = ref.watch(searchedProductsListProvider);
    final productsList =
        isSearching ? searchedProductsList : productsListStream;

    ref.listen(productsListStreamProvider, (previous, next) {
      if (isSearching) {
        ref.invalidate(searchedProductsListProvider);
      }
    });

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: productsList.when(
          data: (data) => HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: MediaQuery.of(context).size.width - 100,
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
                width: 700.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Nom',
                  familyName: 'products',
                  searchProvider: searchProvider('products'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 250.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Prix d\'achat',
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
              final product = data[index];
              return Row(
                children: [
                  InkWell(
                    onTap: () {
                      product.picture != null
                          ? FunctionsController.showAlertDialog(
                              context: context,
                              alertDialog: SingleImageShower(
                                imageSource: product.picture!,
                              ),
                            )
                          : () {};
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 200.0,
                      height: 30.0,
                      child: product.picture != null
                          ? const Icon(
                              Icons.photo,
                              color: CBColors.primaryColor,
                            )
                          : const SizedBox(),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 700.0,
                    height: 30.0,
                    child: CBText(
                      text: product.name,
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 250.0,
                    height: 30.0,
                    child: CBText(
                      text: '${product.purchasePrice.ceil()} f',
                      fontSize: 12.0,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      ref.read(productPictureProvider.notifier).state = null;
                      FunctionsController.showAlertDialog(
                        context: context,
                        alertDialog: ProductUpdateForm(product: product),
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
                        alertDialog: ProductDeletionConfirmationDialog(
                          product: product,
                          confirmToDelete: ProductCRUDFunctions.delete,
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
                width: 700.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Nom',
                  familyName: 'products',
                  searchProvider: searchProvider('products'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 250.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Prix d\'achat',
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
                width: 700.0,
                height: 50.0,
                alignment: Alignment.center,
                child: CBSearchInput(
                  hintText: 'Nom',
                  familyName: 'products',
                  searchProvider: searchProvider('products'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 250.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Prix d\'achat',
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
