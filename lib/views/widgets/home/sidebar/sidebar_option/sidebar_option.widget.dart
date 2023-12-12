import 'package:communitybank/models/views/sidebar_option/sidebar_option.model.dart';
import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/home/home.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SidebarOption extends ConsumerWidget {
  final SidebarOptionModel sidebarOptionData;

  const SidebarOption({
    super.key,
    required this.sidebarOptionData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSidebarOption = ref.watch(selectedSidebarOptionProvider);
    return InkWell(
      onTap: () {
        ref.read(selectedSidebarOptionProvider.notifier).state =
            sidebarOptionData;
        ref.read(selectedSidebarSubOptionProvider.notifier).state =
            sidebarOptionData.subOptions[0];
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0),
        padding: const EdgeInsets.symmetric(
          // vertical: 5.0,
          horizontal: 25.0,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border(
            left: BorderSide(
              width: selectedSidebarOption.name == sidebarOptionData.name
                  ? 5.0
                  : 0,
              color: selectedSidebarOption.name == sidebarOptionData.name
                  ? CBColors.primaryColor
                  : CBColors.sidebarTextColor,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              sidebarOptionData.icon,
              size: selectedSidebarOption.name == sidebarOptionData.name
                  ? 25.0
                  : 20.0,
              color: selectedSidebarOption.name == sidebarOptionData.name
                  ? CBColors.primaryColor
                  : CBColors.sidebarTextColor,
            ),
            const SizedBox(
              width: 10.0,
            ),
            CBText(
              text: sidebarOptionData.name,
              fontSize: 15.0,
              fontWeight: selectedSidebarOption.name == sidebarOptionData.name
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: selectedSidebarOption.name == sidebarOptionData.name
                  ? CBColors.primaryColor
                  : CBColors.sidebarTextColor,
            )
          ],
        ),
      ),
    );
  }
}
