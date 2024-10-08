import 'package:communitybank/models/views/sidear_suboption/sidebar_suboption.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:communitybank/views/widgets/home/home.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SidebarSubOption extends ConsumerWidget {
  final SidebarSubOptionModel sidebarSubOptionData;
  const SidebarSubOption({
    super.key,
    required this.sidebarSubOptionData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSidebarSubOption =
        ref.watch(selectedSidebarSubOptionProvider);
    return InkWell(
      onTap: () {
        ref.read(selectedSidebarSubOptionProvider.notifier).state =
            sidebarSubOptionData;
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        decoration: BoxDecoration(
          color: selectedSidebarSubOption == sidebarSubOptionData
              ? Colors.white
              : CBColors.primaryColor,
          border: Border.all(
            color: CBColors.primaryColor,
          ),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 4,
              offset: const Offset(4, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Row(
          children: [
            Icon(
              sidebarSubOptionData.icon,
              color: selectedSidebarSubOption == sidebarSubOptionData
                  ? CBColors.primaryColor
                  : Colors.white,
              size: 20.0,
            ),
            const SizedBox(
              width: 10.0,
            ),
            CBText(
              text: sidebarSubOptionData.name,
              fontSize: 10.0,
              fontWeight: FontWeight.w600,
              color: selectedSidebarSubOption == sidebarSubOptionData
                  ? CBColors.primaryColor
                  : Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
