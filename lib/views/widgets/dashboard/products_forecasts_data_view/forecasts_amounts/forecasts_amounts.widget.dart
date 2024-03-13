// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:communitybank/models/data/product_forecast/product_forecast.model.dart';
import 'package:communitybank/views/widgets/dashboard/products_forecasts_data_view/forecasts_numbers/forecasts_numbers.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProductsForecastsAmountsDataView extends StatefulHookConsumerWidget {
  const ProductsForecastsAmountsDataView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductsForecastsAmountsDataViewState();
}

class _ProductsForecastsAmountsDataViewState
    extends ConsumerState<ProductsForecastsAmountsDataView> {
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true, format: 'point.x : point.y%');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productsForecasts = ref.watch(productsForecastsDashboardDataProvider);
    return SfCircularChart(
      title: const ChartTitle(
        text: 'Prévison Montants Produits',
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
              yValueMapper: (ProductForecast data, _) => data.forecastAmount,
              dataLabelMapper: (ProductForecast data, _) =>
                  '${data.productName}: ${data.forecastAmount.ceil()}',
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
      tooltipBehavior: _tooltip,
    );
  }

  /// Returns the doughnut series which need to be render.
}
