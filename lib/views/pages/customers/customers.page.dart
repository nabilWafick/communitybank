import 'package:communitybank/views/widgets/customers/customers.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomersPage extends ConsumerWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10.0,
      ),
      child: const Column(
        children: [
          // CBText(text: 'Test')
          CustomersSortOptions(),
          CustomersList(),
        ],
      ),
    );
  }
}
