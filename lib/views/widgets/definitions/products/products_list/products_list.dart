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
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final isSearching = ref.watch(isSearchingProvider('products'));
    final productsListStream = ref.watch(productsListStreamProvider);
    final searchedProductsList = ref.watch(searchedProductsListProvider);
    return SizedBox(
      height: 600.0,
      //  width: 500,
      child: DataTable(
        columns: [
          const DataColumn(
            label: CBText(
              text: 'Code',
              textAlign: TextAlign.start,
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const DataColumn(
            label: CBText(
              text: 'Photo',
              textAlign: TextAlign.start,
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          DataColumn(
            label: CBSearchInput(
              hintText: 'Nom',
              familyName: 'products',
              searchProvider: searchProvider('products'),
            ),
            /*   CBText(
              text: 'Nom',
              textAlign: TextAlign.start,
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
            ),*/
          ),
          const DataColumn(
            label: CBText(
              text: 'Prix d\'achat',
              textAlign: TextAlign.start,
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const DataColumn(label: SizedBox()),
          const DataColumn(label: SizedBox()),
        ],
        rows: isSearching
            ? searchedProductsList.when(
                data: (data) {
                  //  debugPrint('Product Stream Data: $data');
                  return data
                      .map(
                        (product) => DataRow(
                          cells: [
                            DataCell(
                              CBText(
                                text: '${data.indexOf(product) + 1}',
                                fontSize: 12.0,
                              ),
                            ),
                            DataCell(
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
                              Container(
                                alignment: Alignment.center,
                                child: product.picture != null
                                    ? const Icon(
                                        Icons.photo,
                                        color: CBColors.primaryColor,
                                      )
                                    : const SizedBox(),
                              ),
                            ),
                            DataCell(
                              CBText(
                                text: product.name,
                                fontSize: 12.0,
                              ),
                            ),
                            DataCell(
                              CBText(
                                text: '${product.purchasePrice.ceil()} f',
                                fontSize: 12.0,
                              ),
                            ),
                            DataCell(
                              onTap: () {
                                ref
                                    .read(productPictureProvider.notifier)
                                    .state = null;
                                FunctionsController.showAlertDialog(
                                  context: context,
                                  alertDialog:
                                      ProductUpdateForm(product: product),
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
                                      ProductDeletionConfirmationDialog(
                                    product: product,
                                    confirmToDelete:
                                        ProductCRUDFunctions.delete,
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
                  //  debugPrint('Products Stream Error');
                  return [];
                },
                loading: () {
                  //  debugPrint('Products Stream Loading');
                  return [];
                },
              )
            : productsListStream.when(
                data: (data) {
                  //  debugPrint('Product Stream Data: $data');
                  return data
                      .map(
                        (product) => DataRow(
                          cells: [
                            DataCell(
                              CBText(
                                text: '${data.indexOf(product) + 1}',
                                fontSize: 12.0,
                              ),
                            ),
                            DataCell(
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
                              Container(
                                alignment: Alignment.center,
                                child: product.picture != null
                                    ? const Icon(
                                        Icons.photo,
                                        color: CBColors.primaryColor,
                                      )
                                    : const SizedBox(),
                              ),
                            ),
                            DataCell(
                              CBText(
                                text: product.name,
                                fontSize: 12.0,
                              ),
                            ),
                            DataCell(
                              CBText(
                                text: '${product.purchasePrice.ceil()} f',
                                fontSize: 12.0,
                              ),
                            ),
                            DataCell(
                              onTap: () {
                                ref
                                    .read(productPictureProvider.notifier)
                                    .state = null;
                                FunctionsController.showAlertDialog(
                                  context: context,
                                  alertDialog:
                                      ProductUpdateForm(product: product),
                                );
                              },
                              const SizedBox(
                                width: 20.0,
                                child: Icon(
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
                                      ProductDeletionConfirmationDialog(
                                    product: product,
                                    confirmToDelete:
                                        ProductCRUDFunctions.delete,
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
                  //  debugPrint('Products Stream Error');
                  return [];
                },
                loading: () {
                  //  debugPrint('Products Stream Loading');
                  return [];
                },
              ),
      ),
    );
  }
}
