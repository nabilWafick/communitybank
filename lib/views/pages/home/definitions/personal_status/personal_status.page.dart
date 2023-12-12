import 'package:communitybank/views/widgets/definitions/personal_status/personal_status.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonnalStatusPage extends ConsumerWidget {
  const PersonnalStatusPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        PersonalStatusSortOptions(),
        PersonalStatusList(),
      ],
    );
  }
}
