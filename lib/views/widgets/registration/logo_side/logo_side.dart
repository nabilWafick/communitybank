import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogoSide extends ConsumerWidget {
  const LogoSide({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 130.0),
      height: screenSize.height,
      width: screenSize.width / 2,
      color: CBColors.primaryColor,
      child: Center(
        child: Card(
          elevation: 5.0,
          color: CBColors.backgroundColor,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 50.0,
              horizontal: 50.0,
            ),
            child: CBLogo(
              fontSize: 50.0,
              bankColor: CBColors.tertiaryColor.withOpacity(.5),
            ),
          ),
        ),
      ),
    );
  }
}
