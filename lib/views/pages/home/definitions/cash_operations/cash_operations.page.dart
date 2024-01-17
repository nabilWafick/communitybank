import 'package:communitybank/views/widgets/definitions/cash_operations/cash_operations.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CashOperationsPage extends ConsumerWidget {
  const CashOperationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        CashOperationsCard(),
      ],
    );
  }
}
