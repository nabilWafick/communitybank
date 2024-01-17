import 'package:communitybank/views/widgets/definitions/customers_accounts/customers_accounts.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomersAccountsPage extends ConsumerWidget {
  const CustomersAccountsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        CustomersAccountsSortOptions(),
        CustomersAccountsList(),
      ],
    );
  }
}
