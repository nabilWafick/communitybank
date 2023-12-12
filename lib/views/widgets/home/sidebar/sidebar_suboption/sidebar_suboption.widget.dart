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
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: const BorderSide(
          color: CBColors.primaryColor,
        ),
      ),
      elevation: 10.0,
      color: selectedSidebarSubOption == sidebarSubOptionData
          ? Colors.white
          : CBColors.primaryColor,
      child: InkWell(
        onTap: () {
          ref.read(selectedSidebarSubOptionProvider.notifier).state =
              sidebarSubOptionData;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 20.0,
          ),
          child: Row(
            children: [
              Icon(
                sidebarSubOptionData.icon,
                color: selectedSidebarSubOption == sidebarSubOptionData
                    ? CBColors.primaryColor
                    : Colors.white,
              ),
              const SizedBox(
                width: 15.0,
              ),
              CBText(
                text: sidebarSubOptionData.name,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: selectedSidebarSubOption == sidebarSubOptionData
                    ? CBColors.primaryColor
                    : Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
