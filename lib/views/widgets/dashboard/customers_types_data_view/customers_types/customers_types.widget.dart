import 'package:communitybank/models/data/customers_types/customers_types.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/statistics/customers_types/customers_types.widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomersTypesDataView extends StatefulHookConsumerWidget {
  const CustomersTypesDataView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomersTypesDataViewState();
}

class _CustomersTypesDataViewState
    extends ConsumerState<CustomersTypesDataView> {
  List<String>? _labelIntersectActionList;
  late String _selectedLabelIntersectAction;
  TooltipBehavior? _tooltipBehavior;
  late LabelIntersectAction _labelIntersectAction;

//  @override
  Widget buildSettings(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter stateSetter) {
      return ListView(
        shrinkWrap: true,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Text(
                'Label intersect\naction',
                style: TextStyle(
                  color: CBColors.tertiaryColor,
                  fontSize: 16,
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(55, 0, 0, 0),
              ),
              Container(
                height: 50,
                alignment: Alignment.center,
                child: DropdownButton<String>(
                    focusColor: Colors.transparent,
                    underline:
                        Container(color: const Color(0xFFBDBDBD), height: 1),
                    value: _selectedLabelIntersectAction,
                    items: _labelIntersectActionList!.map(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              color: CBColors.tertiaryColor,
                            ),
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (String? value) {
                      _onLabelIntersectActionChange(value);
                      stateSetter(() {});
                    }),
              ),
            ],
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final customersTypesStatisticsDataStream =
        ref.watch(customersTypesStatisticsDataStreamProvider);
    return SfCircularChart(
      title: const ChartTitle(text: 'Types - Nombre Clients'),
      series: customersTypesStatisticsDataStream.when(
        data: (data) => <PieSeries<CustomersTypes, String>>[
          PieSeries<CustomersTypes, String>(
            explode: true,
            name: 'Types',
            dataSource: data,
            xValueMapper: (CustomersTypes data, _) => data.typeName,
            yValueMapper: (CustomersTypes data, _) => data.customers.length,
            dataLabelMapper: (CustomersTypes data, _) =>
                '${data.typeName}: ${data.customers.length}',
            radius: '60%',
            dataLabelSettings: DataLabelSettings(
              margin: EdgeInsets.zero,
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              connectorLineSettings: const ConnectorLineSettings(
                type: ConnectorType.curve,
                length: '20%',
              ),
              labelIntersectAction: _labelIntersectAction,
            ),
          )
        ],
        error: (error, stackTrace) => <PieSeries<CustomersTypes, String>>[],
        loading: () => <PieSeries<CustomersTypes, String>>[],
      ),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  @override
  void initState() {
    _selectedLabelIntersectAction = 'shift';
    _labelIntersectActionList = <String>['shift', 'hide', 'none'].toList();
    _labelIntersectAction = LabelIntersectAction.shift;
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      header: '',
    );
    super.initState();
  }

  @override
  void dispose() {
    _labelIntersectActionList!.clear();
    super.dispose();
  }

  /// Method for changing the data label intersect action.
  void _onLabelIntersectActionChange(String? item) {
    setState(() {
      if (item != null) {
        _selectedLabelIntersectAction = item;
        if (_selectedLabelIntersectAction == 'shift') {
          _labelIntersectAction = LabelIntersectAction.shift;
        }
        if (_selectedLabelIntersectAction == 'none') {
          _labelIntersectAction = LabelIntersectAction.none;
        }
        if (_selectedLabelIntersectAction == 'hide') {
          _labelIntersectAction = LabelIntersectAction.hide;
        }
      }
    });
  }
}


/*
class CustomersTypes {
  final String x;
  final double y;
  CustomersTypes({
    required this.x,
    required this.y,
  });

  CustomersTypes copyWith({
    String? x,
    double? y,
  }) {
    return CustomersTypes(
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

  factory CustomersTypes.fromMap(Map<String, dynamic> map) {
    return CustomersTypes(
      x: map['x'] as String,
      y: map['y'] as double,
    );
  }

  String toJson() => json.encode(
        toMap(),
      );

  factory CustomersTypes.fromJson(String source) =>
      CustomersTypes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CustomersTypes(x: $x, y: $y)';

  @override
  bool operator ==(covariant CustomersTypes other) {
    if (identical(this, other)) return true;

    return other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}
*/