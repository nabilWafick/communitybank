import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomerCardData extends ConsumerWidget {
  final String label;
  final String value;
  const CustomerCardData({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      // width: 240.0,
      child: Row(
        children: [
          CBText(
            text: '$label: ',
            fontSize: 11,
            //  fontWeight: FontWeight.w500,
          ),
          CBText(
            text: value,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            //  color: CBColors.tertiaryColor,
          )
        ],
      ),
    );
  }
}
