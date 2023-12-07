import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';

class CBTextButton extends CBText {
  final Function() onPressed;
  const CBTextButton(
      {super.key,
      required super.text,
      super.textAlign,
      super.fontSize,
      super.fontWeight,
      super.color,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: 'Poppins',
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}
