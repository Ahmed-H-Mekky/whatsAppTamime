import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextRichBottom extends StatelessWidget {
  const TextRichBottom({
    super.key,
    required this.ontap,
    required this.text,
    required this.bottom,
  });
  final VoidCallback ontap;
  final String bottom;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: text,
            style: TextStyle(color: Colors.white),
          ),
          TextSpan(
            text: bottom,
            style: TextStyle(
              color: Colors.yellow, // اللون المختلف
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()..onTap = ontap,
          ),
        ],
      ),
    );
  }
}
