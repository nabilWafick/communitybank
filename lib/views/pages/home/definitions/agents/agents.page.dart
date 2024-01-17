import 'package:communitybank/views/widgets/definitions/agents/agents.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AgentsPage extends ConsumerWidget {
  const AgentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        AgentsSortOptions(),
        AgentsList(),
      ],
    );
  }
}
