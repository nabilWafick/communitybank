import 'package:communitybank/views/widgets/definitions/localities/localities.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalitiesPage extends ConsumerWidget {
  const LocalitiesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        LocalitiesSortOptions(),
        LocalitiesList(),
      ],
    );
  }
}
