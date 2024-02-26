import 'package:communitybank/views/widgets/activities/customer_periodic_activity/customer_periodic_activity.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerPeriodicActivityPage extends ConsumerWidget {
  const CustomerPeriodicActivityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        CustomerPeriodicActivitySortOptions(),
        CustomerPeriodicActivityData(),
      ],
    );
  }
}
