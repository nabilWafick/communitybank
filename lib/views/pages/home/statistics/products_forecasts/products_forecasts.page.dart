import 'package:communitybank/views/widgets/statistics/products_forecasts/products_forecasts.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsForecastsPage extends ConsumerWidget {
  const ProductsForecastsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        ProductsForecastsStatisticsSortOptions(),
        ProductsForecastsStatisticsData(),
      ],
    );
  }
}
