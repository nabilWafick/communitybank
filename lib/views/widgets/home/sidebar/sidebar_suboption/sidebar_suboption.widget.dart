import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SidebarSubOption extends ConsumerWidget {
  final int index;
  final IconData icon;
  final String name;
  const SidebarSubOption({
    super.key,
    required this.index,
    required this.icon,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: InkWell(
        onTap: () {},
        child: Card(
          elevation: 5.0,
          color: CBColors.primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 20.0,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 15.0,
                ),
                CBText(
                  text: name,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: CBColors.backgroundColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
