import 'package:communitybank/models/data/customers_products/customers_products.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/statistics/customers_products/customers_products_data/customers_products_data.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomersProductsDataView extends StatefulHookConsumerWidget {
  const CustomersProductsDataView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomersProductsDataViewState();
}

class _CustomersProductsDataViewState
    extends ConsumerState<CustomersProductsDataView> {
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
    final customersProductsStatisticsDataStream =
        ref.watch(customersProductsStatisticsDataStreamProvider);
    return SfCircularChart(
      title: const ChartTitle(text: 'Produits - Nombre Clients'),
      series: customersProductsStatisticsDataStream.when(
        data: (data) => <PieSeries<CustomersProducts, String>>[
          PieSeries<CustomersProducts, String>(
            explode: true,
            name: 'Produits',
            dataSource: data,
            xValueMapper: (CustomersProducts data, _) => data.productName,
            yValueMapper: (CustomersProducts data, _) => data.customers.length,
            dataLabelMapper: (CustomersProducts data, _) =>
                '${data.productName}: ${data.customers.length}',
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
        error: (error, stackTrace) => <PieSeries<CustomersProducts, String>>[],
        loading: () => <PieSeries<CustomersProducts, String>>[],
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
class CustomersProducts {
  final String x;
  final double y;
  CustomersProducts({
    required this.x,
    required this.y,
  });

  CustomersProducts copyWith({
    String? x,
    double? y,
  }) {
    return CustomersProducts(
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

  factory CustomersProducts.fromMap(Map<String, dynamic> map) {
    return CustomersProducts(
      x: map['x'] as String,
      y: map['y'] as double,
    );
  }

  String toJson() => json.encode(
        toMap(),
      );

  factory CustomersProducts.fromJson(String source) =>
      CustomersProducts.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CustomersProducts(x: $x, y: $y)';

  @override
  bool operator ==(covariant CustomersProducts other) {
    if (identical(this, other)) return true;

    return other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}
*/