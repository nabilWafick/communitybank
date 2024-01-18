import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CashOperationsSettlements extends ConsumerWidget {
  const CashOperationsSettlements({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
          //  color: Colors.blueAccent,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(
              15.0,
            ),
            topRight: Radius.circular(
              15.0,
            ),
          ),
          border: Border.all(
            color: CBColors.sidebarTextColor.withOpacity(.5),
            width: 1.5,
          )),
      height: 370.0,
      child: const Center(
        child: Center(
          child: CBText(
            text: 'Settlements',
          ),
        ),
      ),
    );
  }
}
