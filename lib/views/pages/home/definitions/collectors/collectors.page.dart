import 'package:communitybank/views/widgets/definitions/collectors/collectors.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollectorsPage extends ConsumerWidget {
  const CollectorsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        CollectorsSortOptions(),
        CollectorsList(),
      ],
    );
  }
}
