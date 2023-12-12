import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';

class CBElevatedButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final Function() onPressed;

  const CBElevatedButton(
      {super.key,
      required this.text,
      this.textColor,
      this.backgroundColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          /* shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(.0),),*/
          //   elevation: 5.0,
          backgroundColor: backgroundColor,
          // minimumSize: const Size(50.0, 45.0),
        ),
        child: CBText(
          text: text,
          textAlign: TextAlign.center,
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}
