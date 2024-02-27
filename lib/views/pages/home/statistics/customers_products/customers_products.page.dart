import 'package:communitybank/views/widgets/statistics/customers_products/customers_products.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomersProductsPage extends ConsumerWidget {
  const CustomersProductsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(children: [
      CustomersProductsStatisticsSortOptions(),
      CustomersProductsStatisticsData(),
    ]);
  }
}
