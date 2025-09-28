import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.centerLeft,
      child: Container(
        margin: EdgeInsets.all(6),
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 16, right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          // color: kColor,
        ),
        child: Text(text),
      ),
    );
  }
}
