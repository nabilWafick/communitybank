import 'package:communitybank/views/widgets/transferts/between_customers_cards/between_customer_cards_data/between_customer_cards_data.widget.dart';
import 'package:communitybank/views/widgets/transferts/between_customers_cards/between_customer_cards_sort_options/between_customer_cards_sort_options.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransfersBetweenCustomerCardsPage extends ConsumerWidget {
  const TransfersBetweenCustomerCardsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        TransfersBetweenCustomerCardsSortOptions(),
        TransfersBetweenCustomerCardsData()
      ],
    );
  }
}
