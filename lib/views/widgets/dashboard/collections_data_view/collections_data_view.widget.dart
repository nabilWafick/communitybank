import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/pages/home/dashboard/dashboard.page.dart';
import 'package:communitybank/views/widgets/dashboard/charts/default_doughnut_chart/default_doughnut_chart.widget.dart';
import 'package:communitybank/views/widgets/dashboard/charts/pie_smart_data_label/pie_smart_data_label.widget.dart';
import 'package:communitybank/views/widgets/dashboard/collections_data_view/collectors_monthly_collections/collectors_monthly_collections.widget.dart';
import 'package:communitybank/views/widgets/dashboard/collections_data_view/collectors_weekly_collections/collectors_weekly_collections.widget.dart';
import 'package:communitybank/views/widgets/dashboard/collections_data_view/collectors_yearly_collections/collectors_yearly_collections.widget.dart';
import 'package:communitybank/views/widgets/dashboard/collections_data_view/monthly_collections/monthly_collections.widget.dart';
import 'package:communitybank/views/widgets/dashboard/collections_data_view/weekly_collections/weekly_collections.widget.dart';
import 'package:communitybank/views/widgets/dashboard/collections_data_view/yearly_collections/yearly_collections.widget.dart';
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
    final collectionsTotals = ref.watch(collectionsTotalsProvider);
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
                child: CBText(
                  text: collectionsTotals.when(
                    data: (data) {
                      return data.isEmpty
                          ? '0'
                          : data.first.totalAmount.ceil().toString();
                    },
                    error: (error, stackTrace) => '0',
                    loading: () => '0',
                  ),
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
            child: const WeeklyCollectionsDataView(),
          ),
          Container(
            //  color: CBColors.primaryColor.withOpacity(.7),
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30.0,
            ),
            height: 500.0,
            //  width: MediaQuery.of(context).size.width * .8,
            child: const MonthlyCollectionsDataView(),
          ),
          Container(
            //  color: CBColors.primaryColor.withOpacity(.7),
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30.0,
            ),
            height: 500.0,
            //  width: MediaQuery.of(context).size.width * .8,
            child: const YearlyCollectionsDataView(),
          ),
          Container(
            //  color: CBColors.primaryColor.withOpacity(.7),
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30.0,
            ),
            height: 500.0,
            //  width: MediaQuery.of(context).size.width * .8,
            child: const CollectorsWeeklyCollectionsDataView(),
          ),
          Container(
            //  color: CBColors.primaryColor.withOpacity(.7),
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30.0,
            ),
            height: 500.0,
            //  width: MediaQuery.of(context).size.width * .8,
            child: const CollectorsMonthlyCollectionsDataView(),
          ),
          Container(
            //  color: CBColors.primaryColor.withOpacity(.7),
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30.0,
            ),
            height: 500.0,
            //  width: MediaQuery.of(context).size.width * .8,
            child: const CollectorsYearlyCollectionsDataView(),
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
