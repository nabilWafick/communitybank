import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/pages/home/dashboard/dashboard.page.dart';
import 'package:communitybank/views/widgets/dashboard/dashboard_card/dashboard_card.widget.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:communitybank/views/widgets/globals/icon_button/icon_button.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:communitybank/views/widgets/statistics/customers_products/customers_products_data/customers_products_data.widget.dart';
import 'package:communitybank/views/widgets/statistics/customers_types/customers_types.widgets.dart';
import 'package:communitybank/views/widgets/statistics/products_forecasts/products_forecasts.widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardOverview extends StatefulHookConsumerWidget {
  const DashboardOverview({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardOverviewState();
}

class _DashboardOverviewState extends ConsumerState<DashboardOverview> {
  @override
  Widget build(BuildContext context) {
    final collectionsTotals = ref.watch(collectionsTotalsProvider);
    final customersTotal = ref.watch(customersTotalProvider);
    final customersAccountsTotal = ref.watch(customersAccountsTotalProvider);
    final collectorsTotal = ref.watch(collectorsTotalProvider);
    final customersCardsTotal = ref.watch(customersCardsTotalProvider);
    final agentsTotal = ref.watch(agentsTotalProvider);
    final typesTotal = ref.watch(typesTotalProvider);
    final productsTotal = ref.watch(productsTotalProvider);
    final settlementsTotal = ref.watch(settlementsTotalProvider);

    return // *** GLOBAL VIEW ***
        Container(
      margin: const EdgeInsets.symmetric(
        vertical: 30.0,
      ),
      child: Column(
        children: [
          CBIconButton(
            icon: Icons.refresh,
            text: 'Rafraîchir',
            onTap: () {
              ref.invalidate(collectionsTotalsProvider);
              ref.invalidate(customersTotalProvider);
              ref.invalidate(collectorsTotalProvider);
              ref.invalidate(settlementsTotalProvider);
              ref.invalidate(customersAccountsTotalProvider);
              ref.invalidate(customersCardsTotalProvider);
              ref.invalidate(agentsTotalProvider);
              ref.invalidate(typesTotalProvider);
              ref.invalidate(productsTotalProvider);
              ref.invalidate(weeklyCollectionsProvider);
              ref.invalidate(monthlyCollectionsProvider);
              ref.invalidate(yearlyCollectionsProvider);
              ref.invalidate(collectorsWeeklyCollectionsProvider);
              ref.invalidate(collectorsMonthlyCollectionsProvider);
              ref.invalidate(collectorsYearlyCollectionsProvider);
              ref.invalidate(customersTypesStatisticsDataStreamProvider);
              ref.invalidate(customersProductsStatisticsDataStreamProvider);
              ref.invalidate(productsForecastsStatisticsDataStreamProvider);
              ref.invalidate(
                searchProvider(
                  'products-forecasts-dashboard-settlements-number',
                ),
              );
            },
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: const CBText(
              text: 'Vue d\'ensemble',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
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
          Wrap(
            runSpacing: 10.0,
            spacing: 20.0,
            runAlignment: WrapAlignment.center,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              DashboardCard(
                label: 'Collectes',
                value: collectionsTotals.when(
                  data: (data) {
                    return data.isEmpty ? 0 : data.first.totalAmount;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                label: 'Règlements',
                value: settlementsTotal.when(
                  data: (data) {
                    return data.isEmpty ? 0 : data.first.totalNumber;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                label: 'Clients',
                value: customersTotal.when(
                  data: (data) {
                    return data.isEmpty ? 0 : data.first.totalNumber;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                label: 'Comptes Clients',
                value: customersAccountsTotal.when(
                  data: (data) {
                    return data.isEmpty ? 0 : data.first.totalNumber;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                label: 'Cartes',
                value: customersCardsTotal.when(
                  data: (data) {
                    return data.isEmpty ? 0 : data.first.totalNumber;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                label: 'Agents',
                value: agentsTotal.when(
                  data: (data) {
                    return data.isEmpty ? 0 : data.first.totalNumber;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                label: 'Collecteurs',
                value: collectorsTotal.when(
                  data: (data) {
                    return data.isEmpty ? 0 : data.first.totalNumber;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                label: 'Types',
                value: typesTotal.when(
                  data: (data) {
                    return data.isEmpty ? 0 : data.first.totalNumber;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                label: 'Produits',
                value: productsTotal.when(
                  data: (data) {
                    return data.isEmpty ? 0 : data.first.totalNumber;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              /*    DashboardCard(
                label: 'Weekly Collections',
                value: weeklyCollections.when(
                  data: (data) {
                    return data.isEmpty ? 0 : data.first.collectionAmount;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                label: 'Monthly Collections',
                value: monthlyCollections.when(
                  data: (data) {
                    return data.isEmpty ? 0 : data.first.collectionAmount;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                label: 'Yearly Collections',
                value: yearlyCollections.when(
                  data: (data) {
                    return data.isEmpty ? 0 : data.first.collectionAmount;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                label: 'Collectors Weekly Collections',
                value: collectorsWeeklyCollections.when(
                  data: (data) {
                    return data.isEmpty ? 0 : data.first.collectionsAmounts[0];
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
            
              DashboardCard(
                label: 'Collectors Monthly Collections',
                value: collectorsMonthlyCollections.when(
                  data: (data) {
                    debugPrint('first: ${data.first}');
                    return data.isEmpty ? 0 : data.first.collectionsAmounts[0];
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
                  DashboardCard(
                label: 'Collectors Yearly Collections',
                value: collectorsYearlyCollections.when(
                  data: (data) {
                    return data.isEmpty ? 0 : data.first.collectionsAmounts[0];
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
          */
            ],
          )
        ],
      ),
    );
  }
}
