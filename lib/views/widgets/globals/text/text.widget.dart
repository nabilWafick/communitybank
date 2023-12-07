import 'package:flutter/material.dart';

class CBText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final Color? color;

  const CBText({
    super.key,
    required this.text,
    this.textAlign,
    this.fontSize,
    this.fontWeight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          fontSize: fontSize,
          fontFamily: 'Poppins',
          fontWeight: fontWeight,
          color: color),
    );
  }
}
