import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/contextRoutPage/routPage.dart';
import 'package:whatsapp/cubits/cubitMessages/sendeFirebaseMasseg.dart';
import 'package:whatsapp/cubits/cubitMessages/statesFirbase.dart';
import 'package:whatsapp/widget/chatBubble.dart';
import 'package:whatsapp/widget/BottomSendMessage.dart';

class ChatHome extends StatelessWidget {
  const ChatHome({super.key});
  static String id = kChatHome;
  @override
  Widget build(BuildContext context) {
    var userName = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: userName['image'] != null
                  //FileImage=> يأخذ ملف الصورة ويحوّله إلى صورة يمكن عرضها في الواجهة
                  ? FileImage(File(userName['image']))
                  : null,
            ),
            const SizedBox(width: 15),
            Text(
              userName['myName'],
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<Sendefirebasemasseg, Statesfirbase>(
              builder: (context, state) {
                var messagelist = BlocProvider.of<Sendefirebasemasseg>(
                  context,
                ).messageList;

                if (state is SuccessSendeMessage) {
                  return ListView.builder(
                    reverse: true,
                    itemCount: messagelist.length,
                    itemBuilder: (context, index) {
                      return ChatBubble(text: messagelist[index].message);
                    },
                  );
                }

                if (state is LoadingStat) {
                  return const Center(child: SizedBox());
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          BottomSendMessage(),
        ],
      ),
    );
  }
}
