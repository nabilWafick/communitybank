import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CashOperationsCard extends ConsumerWidget {
  const CashOperationsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SizedBox(
      height: 640.0,
      child: Center(
        child: CBText(
          text: 'Cash Operations',
          fontSize: 25.0,
        ),
      ),
    );
  }
}
