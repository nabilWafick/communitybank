// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardDefaultDoughnutChart extends StatefulHookConsumerWidget {
  const DashboardDefaultDoughnutChart({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardDefaultDoughnutChartState();
}

class _DashboardDefaultDoughnutChartState
    extends ConsumerState<DashboardDefaultDoughnutChart> {
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true, format: 'point.x : point.y%');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      title: const ChartTitle(
        text: 'Composition of ocean water',
      ),
      legend: const Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
      ),
      series: _getDefaultDoughnutSeries(),
      tooltipBehavior: _tooltip,
    );
  }

  /// Returns the doughnut series which need to be render.
  List<DoughnutSeries<ChartSampleData, String>> _getDefaultDoughnutSeries() {
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          explode: true,
          dataSource: <ChartSampleData>[
            ChartSampleData(x: 'Chlorine', y: 55, text: '55%'),
            ChartSampleData(x: 'Sodium', y: 31, text: '31%'),
            ChartSampleData(x: 'Magnesium', y: 7.7, text: '7.7%'),
            ChartSampleData(x: 'Sulfur', y: 3.7, text: '3.7%'),
            ChartSampleData(x: 'Calcium', y: 1.2, text: '1.2%'),
            ChartSampleData(x: 'Others', y: 1.4, text: '1.4%'),
          ],
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) => data.text,
          dataLabelSettings: const DataLabelSettings(isVisible: true))
    ];
  }
}

class ChartSampleData {
  final String x;
  final double y;
  final String text;
  ChartSampleData({
    required this.x,
    required this.y,
    required this.text,
  });

  ChartSampleData copyWith({
    String? x,
    double? y,
    String? text,
  }) {
    return ChartSampleData(
      x: x ?? this.x,
      y: y ?? this.y,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'x': x,
      'y': y,
      'text': text,
    };
  }

  factory ChartSampleData.fromMap(Map<String, dynamic> map) {
    return ChartSampleData(
      x: map['x'] as String,
      y: map['y'] as double,
      text: map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChartSampleData.fromJson(String source) =>
      ChartSampleData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ChartSampleData(x: $x, y: $y, text: $text)';

  @override
  bool operator ==(covariant ChartSampleData other) {
    if (identical(this, other)) return true;

    return other.x == x && other.y == y && other.text == text;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ text.hashCode;
}
