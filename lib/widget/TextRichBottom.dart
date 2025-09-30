import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextRichBottom extends StatelessWidget {
  const TextRichBottom({
    super.key,
    required this.ontap,
    required this.text1,
    required this.textBottom,
    required this.text2,
  });
  final VoidCallback ontap;
  final String textBottom;
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: text1,
            style: TextStyle(color: Colors.white),
          ),
          TextSpan(
            text: text2,
            style: TextStyle(color: Colors.white),
          ),
          TextSpan(
            text: textBottom,
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
