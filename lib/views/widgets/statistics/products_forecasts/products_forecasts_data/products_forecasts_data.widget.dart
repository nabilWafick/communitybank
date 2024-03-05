import 'package:communitybank/controllers/products_forecasts/products_forecasts.controller.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/product_forecast/product_forecast.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/collector/collector_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/customer_account/customer_account_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/lists_dropdowns/product/product_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:communitybank/views/widgets/statistics/products_forecasts/products_forecasts_details_shower/products_forecasts_details_shower.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/date_symbol_data_local.dart';
//import 'package:intl/intl.dart';

final productsForecastsStatisticsDataStreamProvider =
    StreamProvider<List<ProductForecast>>((ref) async* {
  final selectedProduct = ref.watch(
    listProductDropdownProvider('products-forecasts-statistics-product'),
  );
  final selectedCustomerAccount = ref.watch(
    listCustomerAccountDropdownProvider(
        'products-forecasts-statistics-customer-account'),
  );
  final selectedCollector = ref.watch(
    listCollectorDropdownProvider('products-forecasts-statistics-collector'),
  );
  final settlementsTotal = int.tryParse(
        ref.watch(
          searchProvider('products-forecasts-statistics-settlements-number'),
        ),
      ) ??
      186;

  yield* ProductsForecastsController.getProductsForecasts(
    productId: selectedProduct.id == 0 ? null : selectedProduct.id,
    settlementsTotal: settlementsTotal,
    collectorId: selectedCollector.id == 0 ? null : selectedCollector.id,
    customerAccountId:
        selectedCustomerAccount.id == 0 ? null : selectedCustomerAccount.id,
  ).asStream();
});

class ProductsForecastsStatisticsData extends ConsumerStatefulWidget {
  const ProductsForecastsStatisticsData({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductsForecastsStatisticsDataState();
}

class _ProductsForecastsStatisticsDataState
    extends ConsumerState<ProductsForecastsStatisticsData> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final productsForecastsStatisticsDataStream =
        ref.watch(productsForecastsStatisticsDataStreamProvider);

    //  final format = DateFormat.yMMMMEEEEd('fr');

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: productsForecastsStatisticsDataStream.when(
          data: (data) => HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: MediaQuery.of(context).size.width + 300,
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
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Nombre',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Montant',
                  textAlign: TextAlign.center,
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
              final productForecast = data[index];
              return Row(
                children: [
                  InkWell(
                    onTap: () {
                      FunctionsController.showAlertDialog(
                        context: context,
                        alertDialog: ProductForecastDetailsShower(
                          productForecast: productForecast,
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
                      text: FunctionsController.truncateText(
                        text: productForecast.productName,
                        maxLength: 40,
                      ),
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 200.0,
                    height: 30.0,
                    child: CBText(
                      text: productForecast.customersIds.isEmpty ||
                              productForecast.customersIds.first == null
                          ? '0'
                          : productForecast.customersIds.length.toString(),
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 300.0,
                    height: 30.0,
                    child: CBText(
                      text: FunctionsController.truncateText(
                        text: productForecast.forecastAmount.ceil().toString(),
                        maxLength: 40,
                      ),
                      fontSize: 12.0,
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final customers = productForecast.customers;

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
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Produits',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Nombre',
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
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Produits',
                  textAlign: TextAlign.start,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const CBText(
                  text: 'Nombre',
                  textAlign: TextAlign.center,
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
