import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CBEditButton extends ConsumerWidget {
  final Function() onTap;
  const CBEditButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2.0,
        color: Colors.green.shade500,
        child: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0,
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(
              Icons.edit,
              color: CBColors.backgroundColor,
              size: 17.0,
            ),
            SizedBox(
              width: 15.0,
            ),
            CBText(
              text: 'Modifier',
              fontSize: 10.0,
              fontWeight: FontWeight.w500,
              color: CBColors.backgroundColor,
            )
          ]),
        ),
      ),
    );
  }
}
