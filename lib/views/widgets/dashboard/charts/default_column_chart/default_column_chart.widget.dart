// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardDefaultColumnChart extends StatefulHookConsumerWidget {
  const DashboardDefaultColumnChart({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardDefaultColumnChartState();
}

class _DashboardDefaultColumnChartState
    extends ConsumerState<DashboardDefaultColumnChart> {
  TooltipBehavior? _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      header: '',
      canShowMarker: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: const ChartTitle(text: 'Population growth of various countries'),
      primaryXAxis: const CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: const NumericAxis(
          axisLine: AxisLine(width: 0),
          labelFormat: '{value}%',
          majorTickLines: MajorTickLines(size: 0)),
      series: _getDefaultColumnSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  /// Get default column series
  List<ColumnSeries<ChartSampleData, String>> _getDefaultColumnSeries() {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        dataSource: <ChartSampleData>[
          ChartSampleData(
            x: 'China',
            y: 0.541,
          ),
          ChartSampleData(
            x: 'Brazil',
            y: 0.818,
          ),
          ChartSampleData(
            x: 'Bolivia',
            y: 1.51,
          ),
          ChartSampleData(
            x: 'Mexico',
            y: 1.302,
          ),
          ChartSampleData(
            x: 'Egypt',
            y: 2.017,
          ),
          ChartSampleData(
            x: 'Mongolia',
            y: 1.683,
          ),
        ],
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        dataLabelSettings: const DataLabelSettings(
          isVisible: true,
          textStyle: TextStyle(fontSize: 10),
        ),
      )
    ];
  }
}

class ChartSampleData {
  final String x;
  final double y;
  ChartSampleData({
    required this.x,
    required this.y,
  });

  ChartSampleData copyWith({
    String? x,
    double? y,
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
      y: map['y'] as double,
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
