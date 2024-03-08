import 'package:communitybank/controllers/agents_total/agents_total.controller.dart';
import 'package:communitybank/controllers/collections_totals/collections_totals.controller.dart';
import 'package:communitybank/controllers/collectors_total/collectors_total.controller.dart';
import 'package:communitybank/controllers/customers_accounts_total/customers_accounts_total.controller.dart';
import 'package:communitybank/controllers/customers_cards_total/customers_cards_total.controller.dart';
import 'package:communitybank/controllers/customers_total/customers_total.controller.dart';
import 'package:communitybank/controllers/products_total/products_total.controller.dart';
import 'package:communitybank/controllers/settlements_total/settlements_total.controller.dart';
import 'package:communitybank/controllers/types_total/types_total.controller.dart';
import 'package:communitybank/models/data/agents_total/agents_total.model.dart';
import 'package:communitybank/models/data/collections_totals/collections_totals.model.dart';
import 'package:communitybank/models/data/collectors_total/collectors_total.model.dart';
import 'package:communitybank/models/data/customers_accounts_total/customers_accounts_total.model.dart';
import 'package:communitybank/models/data/customers_cards_total/customers_cards_total.model.dart';
import 'package:communitybank/models/data/customers_total/customers_total.model.dart';
import 'package:communitybank/models/data/products_total/products_total.model.dart';
import 'package:communitybank/models/data/settlements_total/settlements_total.model.dart';
import 'package:communitybank/models/data/types_total/types_total.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/dashboard/dashboard_card/dashboard_card.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
          IconButton(
            onPressed: () {
              ref.invalidate(collectionsTotalsProvider);
              ref.invalidate(customersTotalProvider);
              ref.invalidate(collectorsTotalProvider);
              ref.invalidate(settlementsTotalProvider);
              ref.invalidate(customersAccountsTotalProvider);
              ref.invalidate(customersCardsTotalProvider);
              ref.invalidate(agentsTotalProvider);
              ref.invalidate(typesTotalProvider);
              ref.invalidate(productsTotalProvider);
            },
            icon: const Icon(
              Icons.refresh,
            ),
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
            ],
          )
        ],
      ),
    );
  }
}
