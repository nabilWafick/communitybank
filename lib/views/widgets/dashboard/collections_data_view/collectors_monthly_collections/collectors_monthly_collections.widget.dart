// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:communitybank/models/data/collectors_monthly_collections/collectors_monthly_collections.model.dart';
import 'package:communitybank/views/pages/home/dashboard/dashboard.page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CollectorsMonthlyCollectionsDataView extends StatefulHookConsumerWidget {
  const CollectorsMonthlyCollectionsDataView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CollectorsMonthlyCollectionsDataViewState();
}

class _CollectorsMonthlyCollectionsDataViewState
    extends ConsumerState<CollectorsMonthlyCollectionsDataView> {
  @override
  Widget build(BuildContext context) {
    final collectorsMonthlyCollections =
        ref.watch(collectorsMonthlyCollectionsProvider);
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: const ChartTitle(text: 'Collecte Mensuelle - Collecteur'),
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
      series: collectorsMonthlyCollections.when(
        data: (data) {
          return data.first.collectors
              .map(
                (collector) =>
                    LineSeries<CollectorsMonthlyCollections, dynamic>(
                  dataSource: data,
                  xValueMapper:
                      (CollectorsMonthlyCollections collectorsCollections, _) =>
                          collectorsCollections.collectionDate.day,
                  yValueMapper:
                      (CollectorsMonthlyCollections collectorsCollections, _) =>
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
            <LineSeries<CollectorsMonthlyCollections, dynamic>>[],
        loading: () => <LineSeries<CollectorsMonthlyCollections, dynamic>>[],
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }
}
