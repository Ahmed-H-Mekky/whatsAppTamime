import 'package:flutter/material.dart';

class GestureDetectorBottom extends StatelessWidget {
  const GestureDetectorBottom({
    super.key,
    required this.onTap,
    required this.text,
  });
  final VoidCallback? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromARGB(255, 1, 191, 8),
        ),
        width: double.infinity,
        height: 45,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
