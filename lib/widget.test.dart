import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/definitions/products/products_list/products_list.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final settlementsCollectionDateProvider = StateProvider<DateTime?>((ref) {
  return;
});

class WidgetTest extends StatefulHookConsumerWidget {
  const WidgetTest({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WidgetTestState();
}

class _WidgetTestState extends ConsumerState<WidgetTest> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  dynamic data;

  @override
  Widget build(BuildContext context) {
    //  final heigth = MediaQuery.of(context).size.height;
    //  final width = MediaQuery.of(context).size.width;

    return const Scaffold(
      body: SizedBox(
        //width: double.infinity,
        child: ProductsTable(),
      ),
    );
  }
}

class LargeTable extends StatefulWidget {
  const LargeTable({super.key});

  @override
  _LargeTableState createState() => _LargeTableState();
}

class _LargeTableState extends State<LargeTable> {
  // Generate large sample data
  final int numRows = 100; // Adjust this number for desired table size
  final int numColumns = 5;
  final List<String> headerTitles = ['Col1', 'Col2', 'Col3', 'Col4', 'Col5'];
  final List<List<String>> data =
      List.generate(100, (row) => List.generate(5, (col) => "Data $row-$col"));

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 700,
        height: 700,
        child: HorizontalDataTable(
          leftHandSideColumnWidth: 100,
          rightHandSideColumnWidth: 900,
          itemCount: data.length,
          isFixedHeader: true,
          leftHandSideColBackgroundColor: CBColors.backgroundColor,
          rightHandSideColBackgroundColor: CBColors.backgroundColor,
          headerWidgets: headerTitles
              .map(
                (title) => Container(
                  alignment: Alignment.center,
                  //  color: Colors.blueGrey,
                  width: 225.0,
                  height: 50.0,
                  child: Text(title),
                ),
              )
              .toList(),
          leftSideItemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              width: 100.0,
              height: 50.0,
              child: Text('$index'),
            );
          },
          rightSideItemBuilder: (BuildContext context, int index) {
            return Row(
              children: List.generate(
                numColumns - 1,
                (col) => Container(
                  alignment: Alignment.center,
                  width: 225.0,
                  child: Text(
                      data[index][col + 1]), // adjust column width as needed
                ),
              ),
            );
          },
          rowSeparatorWidget: const Divider(),
          scrollPhysics: const BouncingScrollPhysics(),
          horizontalScrollPhysics: const BouncingScrollPhysics(),
        ),
      ),
    );
  }
}

class ProductsTable extends ConsumerStatefulWidget {
  const ProductsTable({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductsTableState();
}

class _ProductsTableState extends ConsumerState<ProductsTable> {
  // Generate large sample data
  final int numRows = 100; // Adjust this number for desired table size
  final int numColumns = 5;
  final List<String> headerTitles = ['Col1', 'Col2', 'Col3', 'Col4', 'Col5'];
  final List<List<String>> data =
      List.generate(100, (row) => List.generate(5, (col) => "Data $row-$col"));

  @override
  Widget build(BuildContext context) {
    final isSearching = ref.watch(isSearchingProvider('products'));
    final productsListStream = ref.watch(productsListStreamProvider);
    final searchedProductsList = ref.watch(searchedProductsListProvider);
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 700,
        height: 700,
        child:
            /*  

        productsListStream.when(data: (data){

        }, error: (error,stackTrace)=>, loading: ()=>),
        
        */

            HorizontalDataTable(
          leftHandSideColumnWidth: 100,
          rightHandSideColumnWidth: 1200,
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
                text: 'Num',
                textAlign: TextAlign.center,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              color: Colors.green,
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
              color: Colors.green,
              width: 400.0,
              height: 50.0,
              alignment: Alignment.center,
              child: CBSearchInput(
                hintText: 'Nom',
                familyName: 'products',
                searchProvider: searchProvider('products'),
              ),
            ),
            Container(
              color: Colors.green,
              width: 200.0,
              height: 50.0,
              alignment: Alignment.center,
              child: const CBText(
                text: 'Prix d\'achat',
                textAlign: TextAlign.center,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              width: 100.0,
              height: 50.0,
            ),
            const SizedBox(
              width: 100.0,
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
            return Row(
              children: [
                InkWell(
                  onTap: () {
                    /*   product.picture != null
                                    ? FunctionsController.showAlertDialog(
                                        context: context,
                                        alertDialog: SingleImageShower(
                                          imageSource: product.picture!,
                                        ),
                                      )
                                    : () {};
                             */
                  },
                  child: Container(
                      alignment: Alignment.center,
                      width: 200.0,
                      height: 30.0,
                      child: const Icon(
                        Icons.photo,
                        color: CBColors.primaryColor,
                      )
                      /* product.picture != null
                                    ? const Icon(
                                        Icons.photo,
                                        color: CBColors.primaryColor,
                                      )
                                    : const SizedBox(),
                                    */
                      ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 400.0,
                  height: 30.0,
                  child: const CBText(
                    text: 'Product Name',
                    //  text: 'product.name',
                    fontSize: 12.0,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 200.0,
                  height: 30.0,
                  child: const CBText(
                    text: 'Purchase Price',
                    //   text: '${product.purchasePrice.ceil()} f',
                    fontSize: 12.0,
                  ),
                ),
                InkWell(
                  onTap: () {
                    /*   ref
                                    .read(productPictureProvider.notifier)
                                    .state = null;
                                FunctionsController.showAlertDialog(
                                  context: context,
                                  alertDialog:
                                      ProductUpdateForm(product: product),
                                );*/
                  },
                  child: Container(
                    width: 100.0,
                    height: 30.0,
                    alignment: Alignment.centerRight,
                    child: const Icon(
                      Icons.edit,
                      color: Colors.green,
                    ),
                  ),
                  // showEditIcon: true,
                ),
                InkWell(
                  onTap: () async {
                    /*
                                FunctionsController.showAlertDialog(
                                  context: context,
                                  alertDialog:
                                      ProductDeletionConfirmationDialog(
                                    product: product,
                                    confirmToDelete:
                                        ProductCRUDFunctions.delete,
                                  ),
                                );
                                */
                  },
                  child: Container(
                    width: 100.0,
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
      ),
    );
  }
}
