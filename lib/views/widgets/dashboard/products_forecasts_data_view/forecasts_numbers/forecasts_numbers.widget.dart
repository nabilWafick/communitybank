import 'package:communitybank/controllers/products_forecasts/products_forecasts.controller.dart';
import 'package:communitybank/models/data/product_forecast/product_forecast.model.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

final productsForecastsDashboardDataProvider =
    StreamProvider<List<ProductForecast>>((ref) async* {
  final settlementsTotal = int.tryParse(
        ref.watch(
          searchProvider('products-forecasts-dashboard-settlements-number'),
        ),
      ) ??
      186;
  yield* ProductsForecastsController.getProductsForecasts(
    productId: null,
    settlementsTotal: settlementsTotal,
    collectorId: null,
    customerAccountId: null,
  ).asStream();
});

class ProductsForecastsNumbersDataView extends StatefulHookConsumerWidget {
  const ProductsForecastsNumbersDataView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductsForecastsNumbersDataViewState();
}

class _ProductsForecastsNumbersDataViewState
    extends ConsumerState<ProductsForecastsNumbersDataView> {
  @override
  Widget build(BuildContext context) {
    final productsForecasts = ref.watch(productsForecastsDashboardDataProvider);
    return SfCircularChart(
      title: const ChartTitle(
        text: 'Prévison Nombre Produits',
      ),

      series: productsForecasts.when(
        data: (data) {
          data = data
              .where(
                (productForecast) => productForecast.forecastNumber != 0,
              )
              .toList();

          return <DoughnutSeries<ProductForecast, String>>[
            DoughnutSeries<ProductForecast, String>(
              explode: true,
              //  explodeAll: true,
              dataSource: data,
              xValueMapper: (ProductForecast data, _) => data.productName,
              yValueMapper: (ProductForecast data, _) => data.forecastNumber,
              dataLabelMapper: (ProductForecast data, _) =>
                  '${data.productName}: ${data.forecastNumber}',
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelPosition: ChartDataLabelPosition.outside,
              ),
            ),
          ];
        },
        error: (error, stackTrace) => <PieSeries<ProductForecast, String>>[],
        loading: () => <PieSeries<ProductForecast, String>>[],
      ),

      onTooltipRender: (TooltipArgs args) {
        final NumberFormat format = NumberFormat.decimalPattern();
        args.text =
            '${args.dataPoints![args.pointIndex!.toInt()].x} : ${format.format(args.dataPoints![args.pointIndex!.toInt()].y)}';
      },
      tooltipBehavior: TooltipBehavior(enable: true),
      // tooltipBehavior: _tooltip,
    );
  }

  /// Returns the doughnut series which need to be render.
}
