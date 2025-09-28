import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/cubits/cubitMessages/sendeFirebaseMasseg.dart';

class BottomSendMessage extends StatelessWidget {
  BottomSendMessage({super.key});

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textEditingController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "اكتب رسالة...",
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: () {
              if (textEditingController.text.isNotEmpty) {
                BlocProvider.of<Sendefirebasemasseg>(context).sendMessage(
                  messagetext: textEditingController.text,
                  id: "user1",
                  datetime: DateTime.now(),
                );
                textEditingController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
