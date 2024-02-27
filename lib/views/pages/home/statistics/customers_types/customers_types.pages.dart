import 'package:communitybank/views/widgets/statistics/customers_types/customers_types.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomersTypesPage extends ConsumerWidget {
  const CustomersTypesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        CustomersTypesStatisticsSortOptions(),
        CustomersTypesStatisticsData(),
      ],
    );
  }
}
