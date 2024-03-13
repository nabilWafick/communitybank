import 'package:communitybank/controllers/agents_total/agents_total.controller.dart';
import 'package:communitybank/controllers/collections_totals/collections_totals.controller.dart';
import 'package:communitybank/controllers/collectors_monthly_collections/collectors_monthly_collections.controller.dart';
import 'package:communitybank/controllers/collectors_total/collectors_total.controller.dart';
import 'package:communitybank/controllers/collectors_weekly_collections/collectors_weekly_collections.controller.dart';
import 'package:communitybank/controllers/collectors_yearly_collections/collectors_yearly_collections.controller.dart';
import 'package:communitybank/controllers/customers_accounts_total/customers_accounts_total.controller.dart';
import 'package:communitybank/controllers/customers_cards_total/customers_cards_total.controller.dart';
import 'package:communitybank/controllers/customers_total/customers_total.controller.dart';
import 'package:communitybank/controllers/monthly_collections/monthly_collections.controller.dart';
import 'package:communitybank/controllers/products_total/products_total.controller.dart';
import 'package:communitybank/controllers/settlements_total/settlements_total.controller.dart';
import 'package:communitybank/controllers/types_total/types_total.controller.dart';
import 'package:communitybank/controllers/weekly_collections/weekly_collections.controller.dart';
import 'package:communitybank/controllers/yearly_collections/yearly_collections.controller.dart';
import 'package:communitybank/models/data/agents_total/agents_total.model.dart';
import 'package:communitybank/models/data/collections_totals/collections_totals.model.dart';
import 'package:communitybank/models/data/collectors_monthly_collections/collectors_monthly_collections.model.dart';
import 'package:communitybank/models/data/collectors_total/collectors_total.model.dart';
import 'package:communitybank/models/data/collectors_weekly_collections/collectors_weekly_collections.model.dart';
import 'package:communitybank/models/data/collectors_yearly_collections/collectors_yearly_collections.model.dart';
import 'package:communitybank/models/data/customers_accounts_total/customers_accounts_total.model.dart';
import 'package:communitybank/models/data/customers_cards_total/customers_cards_total.model.dart';
import 'package:communitybank/models/data/customers_total/customers_total.model.dart';
import 'package:communitybank/models/data/monthly_collections/monthly_collections.model.dart';
import 'package:communitybank/models/data/products_total/products_total.model.dart';
import 'package:communitybank/models/data/settlements_total/settlements_total.model.dart';
import 'package:communitybank/models/data/types_total/types_total.model.dart';
import 'package:communitybank/models/data/weekly_collections/weekly_collections.model.dart';
import 'package:communitybank/models/data/yearly_collections/yearly_collections.model.dart';
import 'package:communitybank/views/widgets/dashboard/dashboard.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final collectionsTotalsProvider =
    StreamProvider<List<CollectionsTotals>>((ref) async* {
  yield* CollectionsTotalsController.getTotals().asStream();
});

final customersTotalProvider =
    StreamProvider<List<CustomersTotal>>((ref) async* {
  yield* CustomersTotalController.getTotalNumber().asStream();
});

final collectorsTotalProvider =
    StreamProvider<List<CollectorsTotal>>((ref) async* {
  yield* CollectorsTotalController.getTotalNumber().asStream();
});

final customersAccountsTotalProvider =
    StreamProvider<List<CustomersAccountsTotal>>((ref) async* {
  yield* CustomersAccountsTotalController.getTotalNumber().asStream();
});

final customersCardsTotalProvider =
    StreamProvider<List<CustomersCardsTotal>>((ref) async* {
  yield* CustomersCardsTotalController.getTotalNumber().asStream();
});

final agentsTotalProvider = StreamProvider<List<AgentsTotal>>((ref) async* {
  yield* AgentsTotalController.getTotalNumber().asStream();
});

final productsTotalProvider = StreamProvider<List<ProductsTotal>>((ref) async* {
  yield* ProductsTotalController.getTotalNumber().asStream();
});

final typesTotalProvider = StreamProvider<List<TypesTotal>>((ref) async* {
  yield* TypesTotalController.getTotalNumber().asStream();
});

final settlementsTotalProvider =
    StreamProvider<List<SettlementsTotal>>((ref) async* {
  yield* SettlementsTotalController.getTotalNumber().asStream();
});

final weeklyCollectionsProvider =
    StreamProvider<List<WeeklyCollections>>((ref) async* {
  yield* WeeklyCollectionsController.getWeeklyCollections().asStream();
});

final monthlyCollectionsProvider =
    StreamProvider<List<MonthlyCollections>>((ref) async* {
  yield* MonthlyCollectionsController.getMonthlyCollections().asStream();
});

final yearlyCollectionsProvider =
    StreamProvider<List<YearlyCollections>>((ref) async* {
  yield* YearlyCollectionsController.getYearlyCollections().asStream();
});
final collectorsWeeklyCollectionsProvider =
    StreamProvider<List<CollectorsWeeklyCollections>>((ref) async* {
  yield* CollectorsWeeklyCollectionsController.getCollectorsWeeklyCollections()
      .asStream();
});

final collectorsMonthlyCollectionsProvider =
    StreamProvider<List<CollectorsMonthlyCollections>>((ref) async* {
  yield* CollectorsMonthlyCollectionsController
          .getCollectorsMonthlyCollections()
      .asStream();
});

final collectorsYearlyCollectionsProvider =
    StreamProvider<List<CollectorsYearlyCollections>>((ref) async* {
  yield* CollectorsYearlyCollectionsController.getCollectorsYearlyCollections()
      .asStream();
});

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
          DashboardCollectionsDataView(),
          DashboardTypesDataView(),
          DashboardProductsDataView(),
          DashboardProductsForecastsDataView(),
        ],
      ),
    );
  }
}
