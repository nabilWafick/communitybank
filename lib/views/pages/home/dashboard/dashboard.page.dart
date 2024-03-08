import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/dashboard/charts/default_column_chart/default_column_chart.widget.dart';
import 'package:communitybank/views/widgets/dashboard/charts/default_doughnut_chart/default_doughnut_chart.widget.dart';
import 'package:communitybank/views/widgets/dashboard/charts/default_line_chart/default_line_chart.widget.dart';
import 'package:communitybank/views/widgets/dashboard/charts/pie_smart_data_label/pie_smart_data_label.widget.dart';
import 'package:communitybank/views/widgets/dashboard/collections_data_view/collections_data_view.widget.dart';
import 'package:communitybank/views/widgets/dashboard/overview/overview.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashboardOverview(),
          DashBoardCollectionsDataView(),
        ],
      ),
    );
  }
}
