import 'package:communitybank/controllers/forms/validators/product/product.validator.dart';
import 'package:communitybank/controllers/products/products.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/products/products_crud.function.dart';
import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/images_shower/single_image_shower.widget.dart';
import 'package:communitybank/views/widgets/forms/delete_confirmation_dialog/delete_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/forms/update/products/products_update_form.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsListProvider = StreamProvider<List<Product>>((ref) async* {
  yield* ProductsController.getAll();
});

class ProductsList extends ConsumerWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.watch(productsListProvider);
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
                  text: 'Photo',
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
                  text: 'Prix d\'achat',
                  textAlign: TextAlign.start,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DataColumn(label: SizedBox()),
              DataColumn(label: SizedBox()),
            ],
            rows: productList.when(
              data: (data) {
                //  debugPrint('Product Stream Data: $data');
                return data
                    .map(
                      (product) => DataRow(
                        cells: [
                          DataCell(
                            CBText(
                              text: product.id!.toString(),
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
                            CBText(text: product.name),
                          ),
                          DataCell(
                            CBText(text: '${product.purchasePrice.ceil()} f'),
                          ),
                          DataCell(
                            onTap: () {
                              ref.read(productPictureProvider.notifier).state =
                                  null;
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
                                alertDialog: DeleteConfirmationDialog(
                                  productId: product.id!,
                                  confirmToDelete: ProductCRUDFunctions.delete,
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
        ),
      ),
    );
  }
}
