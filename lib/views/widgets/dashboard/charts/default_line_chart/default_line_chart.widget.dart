// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardDefaultLineChart extends StatefulHookConsumerWidget {
  const DashboardDefaultLineChart({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardDefaultLineChartState();
}

class _DashboardDefaultLineChartState
    extends ConsumerState<DashboardDefaultLineChart> {
  List<ChartData>? chartData;

  @override
  void initState() {
    chartData = <ChartData>[
      ChartData(
        x: 2005,
        y1: 21,
        y2: 28,
      ),
      ChartData(
        x: 2006,
        y1: 24,
        y2: 44,
      ),
      ChartData(
        x: 2007,
        y1: 36,
        y2: 48,
      ),
      ChartData(
        x: 2008,
        y1: 38,
        y2: 50,
      ),
      ChartData(
        x: 2009,
        y1: 54,
        y2: 66,
      ),
      ChartData(
        x: 2010,
        y1: 57,
        y2: 78,
      ),
      ChartData(
        x: 2011,
        y1: 70,
        y2: 84,
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: const ChartTitle(text: 'Inflation - Consumer price'),
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
        labelFormat: '{value}%',
        axisLine: AxisLine(width: 0),
        majorTickLines: MajorTickLines(color: Colors.transparent),
      ),
      series: _getDefaultLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<ChartData, num>> _getDefaultLineSeries() {
    return <LineSeries<ChartData, num>>[
      LineSeries<ChartData, num>(
        dataSource: chartData,
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y1,
        name: 'Germany',
        markerSettings: const MarkerSettings(isVisible: true),
      ),
      LineSeries<ChartData, num>(
        dataSource: chartData,
        name: 'England',
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y2,
        markerSettings: const MarkerSettings(isVisible: true),
      )
    ];
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
  }
}

class ChartData {
  final double x;
  final double y1;
  final double y2;
  ChartData({
    required this.x,
    required this.y1,
    required this.y2,
  });

  ChartData copyWith({
    double? x,
    double? y1,
    double? y2,
  }) {
    return ChartData(
      x: x ?? this.x,
      y1: y1 ?? this.y1,
      y2: y2 ?? this.y2,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'x': x,
      'y1': y1,
      'y2': y2,
    };
  }

  factory ChartData.fromMap(Map<String, dynamic> map) {
    return ChartData(
      x: map['x'] as double,
      y1: map['y1'] as double,
      y2: map['y2'] as double,
    );
  }

  String toJson() => json.encode(
        toMap(),
      );

  factory ChartData.fromJson(String source) =>
      ChartData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ChartData(x: $x, y1: $y1, y2: $y2)';

  @override
  bool operator ==(covariant ChartData other) {
    if (identical(this, other)) return true;

    return other.x == x && other.y1 == y1 && other.y2 == y2;
  }

  @override
  int get hashCode => x.hashCode ^ y1.hashCode ^ y2.hashCode;
}
