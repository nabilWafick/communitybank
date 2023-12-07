import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';

class CBOutlinedButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Function() onPressed;

  const CBOutlinedButton(
      {super.key,
      required this.text,
      required this.textColor,
      required this.backgroundColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(.0),
          side: const BorderSide(width: 1.5, color: CBColors.primaryColor),
        ),
        color: Colors.white,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(.0),
              side: const BorderSide(width: .0, color: CBColors.primaryColor),
            ),
            //elevation: 2.0,
            // backgroundColor: backgroundColor,
            //  minimumSize: const Size(double.maxFinite, 45.0)
          ),
          child: CBText(
              text: text,
              textAlign: TextAlign.center,
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              color: textColor),
        ),
      ),
    );
  }
}
