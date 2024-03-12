// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:communitybank/models/data/collectors_yearly_collections/collectors_yearly_collections.model.dart';
import 'package:communitybank/views/pages/home/dashboard/dashboard.page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CollectorsYearlyCollectionsDataView extends StatefulHookConsumerWidget {
  const CollectorsYearlyCollectionsDataView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CollectorsYearlyCollectionsDataViewState();
}

class _CollectorsYearlyCollectionsDataViewState
    extends ConsumerState<CollectorsYearlyCollectionsDataView> {
  @override
  Widget build(BuildContext context) {
    final collectorsYearlyCollections =
        ref.watch(collectorsYearlyCollectionsProvider);
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: const ChartTitle(text: 'Collectes Annuelle - Collecteur'),
      legend: const Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
      ),
      primaryXAxis: const NumericAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        interval: 2,
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: const NumericAxis(
        labelFormat: '{value}',
        axisLine: AxisLine(width: 0),
        majorTickLines: MajorTickLines(color: Colors.transparent),
      ),
      series: collectorsYearlyCollections.when(
        data: (data) {
          return data.first.collectors
              .map(
                (collector) => LineSeries<CollectorsYearlyCollections, dynamic>(
                  dataSource: data,
                  xValueMapper:
                      (CollectorsYearlyCollections collectorsCollections, _) =>
                          getMonthNumberFromFrench(
                    month: collectorsCollections.month,
                  ),
                  yValueMapper:
                      (CollectorsYearlyCollections collectorsCollections, _) =>
                          collectorsCollections.collectionsAmounts[
                              data.first.collectors.indexOf(collector)],
                  name: collector,
                  width: 3,
                  markerSettings: const MarkerSettings(
                    isVisible: false,
                  ),
                ),
              )
              .toList();
        },
        error: (error, stackTrace) =>
            <LineSeries<CollectorsYearlyCollections, dynamic>>[],
        loading: () => <LineSeries<CollectorsYearlyCollections, dynamic>>[],
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }
}

int getMonthNumberFromFrench({
  required String month,
}) {
  final monthMap = {
    'Janvier': 1,
    'Février': 2,
    'Mars': 3,
    'Avril': 4,
    'Mai': 5,
    'Juin': 6,
    'Juillet': 7,
    'Août': 8,
    'Septembre': 9,
    'Octobre': 10,
    'Novembre': 11,
    'Décembre': 12,
  };

  // Capitalize the first letter
  month = month[0].toUpperCase() + month.substring(1).toLowerCase();

  final monthNumber = monthMap[month];
  if (monthNumber == null) {
    throw Exception('Invalid French month name: $month');
  }
  return monthNumber;
}
