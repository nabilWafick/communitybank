import 'package:communitybank/models/data/product_forecast/product_forecast.model.dart';
import 'package:communitybank/views/widgets/dashboard/products_forecasts_data_view/forecasts_numbers/forecasts_numbers.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProductsForecastsCustomersDataView extends StatefulHookConsumerWidget {
  const ProductsForecastsCustomersDataView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductsForecastsCustomersDataViewState();
}

class _ProductsForecastsCustomersDataViewState
    extends ConsumerState<ProductsForecastsCustomersDataView> {
  @override
  Widget build(BuildContext context) {
    final productsForecasts = ref.watch(productsForecastsDashboardDataProvider);
    return SfCircularChart(
      title: const ChartTitle(
        text: 'Prévison Produits - Nombre Clients',
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
              yValueMapper: (ProductForecast data, _) => data.customers.length,
              dataLabelMapper: (ProductForecast data, _) =>
                  '${data.productName}: ${data.customers.length}',
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
