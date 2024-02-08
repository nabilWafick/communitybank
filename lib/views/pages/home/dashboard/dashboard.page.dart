import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: const Center(
          child: CBText(
            text: 'Dashboard',
            fontSize: 25.0,
          ),
        ) /* Wrap(
        children: [
          DashboardCard(
            value: 10000,
            label: 'Clients',
          ),
        ],
      ),*/
        );
  }
}
