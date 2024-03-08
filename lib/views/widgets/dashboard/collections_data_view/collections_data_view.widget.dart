import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/dashboard/charts/default_column_chart/default_column_chart.widget.dart';
import 'package:communitybank/views/widgets/dashboard/charts/default_doughnut_chart/default_doughnut_chart.widget.dart';
import 'package:communitybank/views/widgets/dashboard/charts/default_line_chart/default_line_chart.widget.dart';
import 'package:communitybank/views/widgets/dashboard/charts/pie_smart_data_label/pie_smart_data_label.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashBoardCollectionsDataView extends ConsumerStatefulWidget {
  const DashBoardCollectionsDataView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashBoardCollectionsDataViewState();
}

class _DashBoardCollectionsDataViewState
    extends ConsumerState<DashBoardCollectionsDataView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Collectes',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: '1750925',
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Container(
            height: .5,
            width: double.infinity,
            color: CBColors.sidebarTextColor,
            margin: const EdgeInsets.only(
              top: 10.0,
              bottom: 17.0,
            ),
          ),
          Container(
            //  color: CBColors.primaryColor.withOpacity(.7),
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30.0,
            ),
            height: 500.0,
            //  width: MediaQuery.of(context).size.width * .8,
            child: const DashboardDefaultColumnChart(),
          ),
          Container(
            //  color: CBColors.primaryColor.withOpacity(.7),
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30.0,
            ),
            height: 500.0,
            //  width: MediaQuery.of(context).size.width * .8,
            child: const DashboardDefaultLineChart(),
          ),
          Container(
            //  color: CBColors.primaryColor.withOpacity(.7),
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30.0,
            ),
            height: 1000.0,
            //  width: MediaQuery.of(context).size.width * .8,
            child: const DashboardPieSmartDataLabels(),
          ),
          Container(
            //  color: CBColors.primaryColor.withOpacity(.7),
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30.0,
            ),
            height: 700.0,
            //  width: MediaQuery.of(context).size.width * .8,
            child: const DashboardDefaultDoughnutChart(),
          ),
        ],
      ),
    );
  }
}
