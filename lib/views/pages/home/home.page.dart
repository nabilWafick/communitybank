import 'package:communitybank/views/widgets/home/home.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Row(
        children: [
          Sidebar(),
          Main(),
        ],
      ),
    );
  }
}
