import 'package:communitybank/views/widgets/stocks/stocks.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StocksPage extends ConsumerWidget {
  const StocksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        StocksSortOptions(),
        StocksList(),
      ],
    );
  }
}
