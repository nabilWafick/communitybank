import 'package:communitybank/views/widgets/transferts/between_customers_accounts/between_customer_accounts_sort_options/between_customers_accounts_sort_options.widget.dart';
import 'package:communitybank/views/widgets/transferts/between_customers_accounts/between_customers_accounts_data/between_customers_accounts_data.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransfersBetweenCustomersAccountsPage extends ConsumerWidget {
  const TransfersBetweenCustomersAccountsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Column(
        children: [
          TransfersBetweenCustomersAccountsSortOptions(),
          TransfersBetweenCustomersAccountsData()
        ],
      ),
    );
  }
}
