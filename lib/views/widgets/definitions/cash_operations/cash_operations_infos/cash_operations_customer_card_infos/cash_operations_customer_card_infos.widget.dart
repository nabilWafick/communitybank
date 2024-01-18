import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CashOperationsCustomerCardInfos extends ConsumerWidget {
  final double width;
  const CashOperationsCustomerCardInfos({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: width,
      height: 440.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          15.0,
        ),
        border: Border.all(
          color: CBColors.sidebarTextColor.withOpacity(.5),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          const CBText(
            text: 'Cash Operations Customer Card Infos',
          ),
          CBText(
            text: 'width: $width',
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
