import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForecastsPage extends ConsumerWidget {
  const ForecastsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: CBText(
        text: 'Forecasts',
        fontSize: 25.0,
      ),
    );
  }
}
