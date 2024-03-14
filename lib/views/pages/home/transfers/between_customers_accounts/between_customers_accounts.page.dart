import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransfersBetweenCustomersAccountsPage extends ConsumerWidget {
  const TransfersBetweenCustomersAccountsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: CBText(
        text: 'Transfert entre comptes clients',
        fontSize: 25.0,
      ),
    );
  }
}
