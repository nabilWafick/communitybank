import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/dashboard/products_forecasts_data_view/customers_per_product/customers_per_product.widget.dart';
import 'package:communitybank/views/widgets/dashboard/products_forecasts_data_view/forecasts_amounts/forecasts_amounts.widget.dart';
import 'package:communitybank/views/widgets/dashboard/products_forecasts_data_view/forecasts_numbers/forecasts_numbers.widget.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardProductsForecastsDataView extends ConsumerStatefulWidget {
  const DashboardProductsForecastsDataView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardProductsForecastsDataViewState();
}

class _DashboardProductsForecastsDataViewState
    extends ConsumerState<DashboardProductsForecastsDataView> {
  @override
  Widget build(BuildContext context) {
    final productsForecastsDashboardDataStream =
        ref.watch(productsForecastsDashboardDataProvider);
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Prévision Nombre',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: CBText(
                  text: productsForecastsDashboardDataStream.when(
                    data: (data) {
                      num productsForecastsNumber = 0;
                      for (var productForecast in data) {
                        productsForecastsNumber +=
                            productForecast.forecastNumber;
                      }
                      return productsForecastsNumber.ceil().toString();
                    },
                    error: (error, stackTrace) => '0',
                    loading: () => '0',
                  ),
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Prévision Montant',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: CBText(
                  text: productsForecastsDashboardDataStream.when(
                    data: (data) {
                      num productsForecastsAmount = 0;
                      for (var productForecast in data) {
                        productsForecastsAmount +=
                            productForecast.forecastAmount;
                      }
                      return productsForecastsAmount.ceil().toString();
                    },
                    error: (error, stackTrace) => '0',
                    loading: () => '0',
                  ),
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Container(
            height: .5,
            width: double.infinity,
            color: CBColors.sidebarTextColor,
            margin: const EdgeInsets.only(
              top: 10.0,
              bottom: 17.0,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(
              top: 20.0,
            ),
            width: 200,
            height: 70.0,
            child: TextFormField(
              initialValue: '186',
              cursorHeight: 20.0,
              style: const TextStyle(
                fontSize: 12.0,
              ),
              decoration: const InputDecoration(
                label: CBText(
                  text: 'Nombre Règlement',
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                hintText: 'Nombre Règlement',
              ),
              onChanged: (value) {
                ref
                    .read(searchProvider(
                      'products-forecasts-dashboard-settlements-number',
                    ).notifier)
                    .state = value;
              },
            ),
          ),
          Container(
            //  color: CBColors.primaryColor.withOpacity(.7),
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30.0,
            ),
            height: 700.0,
            //  width: MediaQuery.of(context).size.width * .8,
            child: const ProductsForecastsNumbersDataView(),
          ),
          Container(
            //  color: CBColors.primaryColor.withOpacity(.7),
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30.0,
            ),
            height: 700.0,
            //  width: MediaQuery.of(context).size.width * .8,
            child: const ProductsForecastsAmountsDataView(),
          ),
          Container(
            //  color: CBColors.primaryColor.withOpacity(.7),
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30.0,
            ),
            height: 700.0,
            //  width: MediaQuery.of(context).size.width * .8,
            child: const ProductsForecastsCustomersDataView(),
          ),
        ],
      ),
    );
  }
}
