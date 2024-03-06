import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardCard extends ConsumerWidget {
  final String label;
  final double value;
  final bool ceil;

  const DashboardCard({
    super.key,
    required this.label,
    required this.value,
    required this.ceil,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: CBColors.sidebarTextColor.withOpacity(.3),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10.0),
      ),
      /* padding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 35.0,
      ),*/
      height: 150.0,
      width: 200.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CBText(
            text: FunctionsController.formatLargeNumber(
              number: value,
              ceil: ceil,
            ),
            fontSize: 40.0,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(
            height: 5.0,
          ),
          CBText(
            text: label,
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
