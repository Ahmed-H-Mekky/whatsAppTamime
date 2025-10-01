import 'package:flutter/material.dart';
import 'package:whatsapp/context/context.dart';
import 'package:whatsapp/model/modelMessage.dart';

class ChatBubble extends StatelessWidget {
  final Modelmessage message; // تعديل
  const ChatBubble(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: kColor,
        ),
        child: Text(message.text), // هنا تعرض نص الرسالة
      ),
    );
  }
}

class ChatBubbleForFreinds extends StatelessWidget {
  final Modelmessage message; // تعديل
  const ChatBubbleForFreinds(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: Color(0x66006d84),
        ),
        child: Text(message.text), // هنا تعرض نص الرسالة
      ),
    );
  }
}
