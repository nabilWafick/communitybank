import 'package:communitybank/views/widgets/definitions/types/types.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TypesPage extends ConsumerWidget {
  const TypesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        TypesSortOptions(),
        TypesList(),
      ],
    );
  }
}
