import 'package:communitybank/views/widgets/definitions/economical_activities/economical_activities.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EconomicalActivitiesPage extends ConsumerWidget {
  const EconomicalActivitiesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        EconomicalActivitiesSortOptions(),
        EconomicalActivitiesList(),
      ],
    );
  }
}
