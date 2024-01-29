import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CBIconButton extends ConsumerWidget {
  final IconData icon;
  final String text;
  final Function() onTap;

  const CBIconButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(
          //   vertical: 10.0,
          ),
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 5.0,
          color: CBColors.primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(
                icon,
                color: CBColors.backgroundColor,
              ),
              const SizedBox(
                width: 15.0,
              ),
              CBText(
                text: text,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: CBColors.backgroundColor,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
