import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/home/home.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SidebarOption extends ConsumerWidget {
  final int index;
  final IconData icon;
  final String name;

  const SidebarOption({
    super.key,
    required this.index,
    required this.icon,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSidebarOption = ref.watch(selectedSidebarOptionProvider);
    return InkWell(
      onTap: () {
        ref.read(selectedSidebarOptionProvider.notifier).state = index;
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
              width: selectedSidebarOption == index ? 5.0 : 0,
              color: selectedSidebarOption == index
                  ? CBColors.primaryColor
                  : CBColors.sidebarTextColor,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: selectedSidebarOption == index ? 25.0 : 20.0,
              color: selectedSidebarOption == index
                  ? CBColors.primaryColor
                  : CBColors.sidebarTextColor,
            ),
            const SizedBox(
              width: 10.0,
            ),
            CBText(
              text: name,
              fontSize: 15.0,
              fontWeight: selectedSidebarOption == index
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: selectedSidebarOption == index
                  ? CBColors.primaryColor
                  : CBColors.sidebarTextColor,
            )
          ],
        ),
      ),
    );
  }
}
