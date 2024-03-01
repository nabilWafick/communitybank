import 'package:communitybank/controllers/customers_products/customers_products.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/customers_products/customers_products.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_account/customer_account_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/product/product_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:communitybank/views/widgets/statistics/customers_products/customers_products_details_shower/customers_products_details_shower.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/date_symbol_data_local.dart';
//import 'package:intl/intl.dart';

final customersProductsStatisticsDataStreamProvider =
    StreamProvider<List<CustomersProducts>>((ref) async* {
  final selectedCustomerAccount = ref.watch(
    listCustomerAccountDropdownProvider(
        'customers-Products-statistics-customer-account'),
  );
  final selectedProduct = ref.watch(
    listProductDropdownProvider('customers-Products-statistics-product'),
  );

  yield* CustomersProductsController.getCustomersProducts(
    customerAccountId: selectedCustomerAccount.id,
    productId: selectedProduct.id == 0 ? null : selectedProduct.id,
  ).asStream();
});

class CustomersProductsStatisticsData extends ConsumerStatefulWidget {
  const CustomersProductsStatisticsData({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomersProductsStatisticsDataState();
}

class _CustomersProductsStatisticsDataState
    extends ConsumerState<CustomersProductsStatisticsData> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final customersProductsStatisticsDataStream =
        ref.watch(customersProductsStatisticsDataStreamProvider);

    //  final format = DateFormat.yMMMMEEEEd('fr');

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: customersProductsStatisticsDataStream.when(
          data: (data) => HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: MediaQuery.of(context).size.width,
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
                width: 100.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const SizedBox(),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Produits',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 1000.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Clients',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
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
              final customersProducts = data[index];
              return Row(
                children: [
                  InkWell(
                    onTap: () {
                      FunctionsController.showAlertDialog(
                        context: context,
                        alertDialog: CustomersProductsDetailsShower(
                          customersProducts: customersProducts,
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 100.0,
                      height: 30.0,
                      child: const Icon(
                        Icons.aspect_ratio,
                        color: CBColors.primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: CBText(
                      text: customersProducts.productName,
                      fontSize: 12.0,
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final customers = customersProducts.customers;
                      String customerss = '';

                      for (int i = 0; i < customers.length; ++i) {
                        if (customerss.isEmpty && customers[i] != null) {
                          customerss = customers[i];
                        } else if (customers[i] != null) {
                          customerss = '$customerss, ${customers[i]}';
                        }
                      }
                      return Container(
                        alignment: Alignment.centerLeft,
                        width: 1000.0,
                        height: 30.0,
                        child: CBText(
                          text: FunctionsController.truncateText(
                            text: customerss,
                            maxLength: 110,
                          ),
                          fontSize: 12.0,
                        ),
                      );
                    },
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
                width: 100.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const SizedBox(),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Products',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 1000.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Clients',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
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
                width: 100.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const SizedBox(),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Products',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 1000.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Clients',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
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
