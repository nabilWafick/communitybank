// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:communitybank/views/pages/home/dashboard/dashboard.page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
//import 'package:intl/date_symbol_data_local.dart';
//import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MonthlyCollectionsDataView extends StatefulHookConsumerWidget {
  const MonthlyCollectionsDataView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MonthlyCollectionsDataViewState();
}

class _MonthlyCollectionsDataViewState
    extends ConsumerState<MonthlyCollectionsDataView> {
  TooltipBehavior? _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      header: '',
      canShowMarker: false,
    );
    //   initializeDateFormatting('fr');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final monthlyCollections = ref.watch(monthlyCollectionsProvider);
    // final format = DateFormat.MEd('fr');
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: const ChartTitle(text: 'Collecte Mensuelle'),
      primaryXAxis: const CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
        // labelRotation: 45,
      ),
      primaryYAxis: const NumericAxis(
        axisLine: AxisLine(width: 0),
        labelFormat: '{value}',
        majorTickLines: MajorTickLines(size: 0),
      ),
      series: <ColumnSeries<ChartSampleData, String>>[
        ColumnSeries<ChartSampleData, String>(
          dataSource: monthlyCollections.when(
            data: (data) => data
                .map(
                  (dailyCollection) => ChartSampleData(
                    x: dailyCollection.collectionDate.day.toString(),
                    //format.format(dailyCollection.collectionDate),
                    y: dailyCollection.collectionAmount.ceil(),
                  ),
                )
                .toList(),
            error: (error, stackTrace) => <ChartSampleData>[],
            loading: () => <ChartSampleData>[],
          ),
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            textStyle: TextStyle(fontSize: 10),
          ),
        )
      ],
      tooltipBehavior: _tooltipBehavior,
    );
  }

  /// Get default column series
}

class ChartSampleData {
  final String x;
  final dynamic y;
  ChartSampleData({
    required this.x,
    required this.y,
  });

  ChartSampleData copyWith({
    String? x,
    dynamic y,
  }) {
    return ChartSampleData(
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'x': x,
      'y': y,
    };
  }

  factory ChartSampleData.fromMap(Map<String, dynamic> map) {
    return ChartSampleData(
      x: map['x'] as String,
      y: map['y'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChartSampleData.fromJson(String source) =>
      ChartSampleData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ChartSampleData(x: $x, y: $y)';

  @override
  bool operator ==(covariant ChartSampleData other) {
    if (identical(this, other)) return true;

    return other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}
