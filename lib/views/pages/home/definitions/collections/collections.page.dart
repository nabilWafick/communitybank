import 'package:communitybank/views/widgets/definitions/collections/collections.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollectionsPage extends ConsumerWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        CollectionsSortOptions(),
        CollectionsList(),
      ],
    );
  }
}
