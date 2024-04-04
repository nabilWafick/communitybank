import 'package:communitybank/views/widgets/activities/satisfied_customers_cards/satisfied_customers_cards.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SatisfiedCustomersCardsPage extends ConsumerWidget {
  const SatisfiedCustomersCardsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        SatisfiedCustomersCardsSortOptions(),
        SatisfiedCustomersCardsData(),
      ],
    );
  }
}
