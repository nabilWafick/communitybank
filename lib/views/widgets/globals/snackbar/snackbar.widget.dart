import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';

snackBar({
  required BuildContext context,
  required String message,
  required Color color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: CBText(
        text: message,
        textAlign: TextAlign.left,
        fontSize: 15.0,
        color: Colors.white,
      ),
    ),
  );
}
