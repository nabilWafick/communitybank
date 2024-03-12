// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:communitybank/models/data/collectors_weekly_collections/collectors_weekly_collections.model.dart';
import 'package:communitybank/views/pages/home/dashboard/dashboard.page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CollectorsWeeklyCollectionsDataView extends StatefulHookConsumerWidget {
  const CollectorsWeeklyCollectionsDataView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CollectorsWeeklyCollectionsDataViewState();
}

class _CollectorsWeeklyCollectionsDataViewState
    extends ConsumerState<CollectorsWeeklyCollectionsDataView> {
  @override
  Widget build(BuildContext context) {
    final collectorsWeeklyCollections =
        ref.watch(collectorsWeeklyCollectionsProvider);
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: const ChartTitle(text: 'Collecte Hebdomadaire - Collecteur'),
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
      series: collectorsWeeklyCollections.when(
        data: (data) {
          return data.first.collectors
              .map(
                (collector) => LineSeries<CollectorsWeeklyCollections, dynamic>(
                  dataSource: data,
                  xValueMapper:
                      (CollectorsWeeklyCollections collectorsCollections, _) =>
                          collectorsCollections.collectionDate.day,
                  yValueMapper:
                      (CollectorsWeeklyCollections collectorsCollections, _) =>
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
            <LineSeries<CollectorsWeeklyCollections, dynamic>>[],
        loading: () => <LineSeries<CollectorsWeeklyCollections, dynamic>>[],
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }
}
