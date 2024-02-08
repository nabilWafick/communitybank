import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardCard extends ConsumerWidget {
  final int value;
  final String label;
  const DashboardCard({
    super.key,
    required this.value,
    required this.label,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: CBColors.sidebarTextColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 35.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CBText(
            text: value.toString(),
            fontSize: 30.0,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(
            height: 15.0,
          ),
          CBText(
            text: label,
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
