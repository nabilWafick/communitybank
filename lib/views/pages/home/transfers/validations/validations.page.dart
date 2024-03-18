import 'package:communitybank/views/widgets/transferts/validations/validations.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransfersValidationsPage extends ConsumerWidget {
  const TransfersValidationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        TransfersValidationsSortOptions(),
        TransfersValidationsList(),
      ],
    );
  }
}
