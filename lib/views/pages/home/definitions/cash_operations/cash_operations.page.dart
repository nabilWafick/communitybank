import 'package:communitybank/views/widgets/cash/cash_operations/cash_operations.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CashOperationsPage extends ConsumerWidget {
  const CashOperationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            CashOperationsSearchOptions(),
            CashOperationsInfos(),
          ],
        ),
        CashOperationsSettlements(),
      ],
    );
  }
}
