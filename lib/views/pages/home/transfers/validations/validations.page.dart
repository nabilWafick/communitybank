import 'package:communitybank/utils/constants/constants.util.dart';
import 'package:communitybank/views/pages/home/dashboard/dashboard.page.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:communitybank/views/widgets/transferts/validations/validations.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransfersValidationsPage extends ConsumerWidget {
  const TransfersValidationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agentRole = ref.watch(agentRoleProvider);

    Future.delayed(
      const Duration(
        milliseconds: 100,
      ),
      () async {
        final prefs = await SharedPreferences.getInstance();
        final role = prefs.getString(CBConstants.agentRolePrefKey) ?? 'USER';

        ref.read(agentRoleProvider.notifier).state = role;
      },
    );

    return agentRole != 'USER'
        ? const Column(
            children: [
              TransfersValidationsSortOptions(),
              TransfersValidationsList(),
            ],
          )
        : const Center(
            child: CBText(
              text: 'Validations',
              fontSize: 25.0,
              fontWeight: FontWeight.w500,
            ),
          );
  }
}
