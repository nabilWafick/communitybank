import 'package:communitybank/views/widgets/cash/settlements/settlements.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettlementsPage extends ConsumerWidget {
  const SettlementsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        SettlementsSortOptions(),
        SettlementsList(),
      ],
    );
  }
}
