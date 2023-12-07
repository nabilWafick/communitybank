import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CBLogo extends ConsumerWidget {
  final double fontSize;
  final Color bankColor;
  const CBLogo({
    super.key,
    required this.fontSize,
    required this.bankColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  final pageController = ref.watch(pageControllerProvider);

    return InkWell(
      onTap: () {
        // ref.read(currentPageIndexProvider.notifier).state = 0;
        /* pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 10),
          curve: Curves.easeIn,
        );*/
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CBText(
            text: 'Community',
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: CBColors.primaryColor,
          ),
          const SizedBox(
            width: 10.0,
          ),
          CBText(
            text: 'Bank',
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: bankColor,
          ),
        ],
      ),
    );
  }
}
