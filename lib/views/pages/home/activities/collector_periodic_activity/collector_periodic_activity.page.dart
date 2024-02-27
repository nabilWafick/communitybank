import 'package:communitybank/views/widgets/activities/collector_periodic_activity/collector_periodic_activity.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollectorPeriodicActivityPage extends ConsumerWidget {
  const CollectorPeriodicActivityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        CollectorPeriodicActivitySortOptions(),
        CollectorPeriodicActivityData(),
      ],
    );
  }
}
