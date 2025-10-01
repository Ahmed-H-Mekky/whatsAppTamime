import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/contextRoutPage/routPage.dart';
import 'package:whatsapp/cubits/cubitMessages/sendefirebasemasseg.dart';
import 'package:whatsapp/cubits/cubitMessages/statesFirbase.dart';
import 'package:whatsapp/cubits/cubitRegister/LogInCubit.dart';
import 'package:whatsapp/widget/chatBubble.dart';
import 'package:whatsapp/widget/BottomSendMessage.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});
  static String id = kChatHome;

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  @override
  Widget build(BuildContext context) {
    var userName = ModalRoute.of(context)!.settings.arguments as Map;
    var phon = BlocProvider.of<CubitLogin>(context).userPhone;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: userName['image'] != null
                  ? FileImage(File(userName['image']))
                  : null,
            ),
            const SizedBox(width: 15),
            Text(
              userName['myName'],
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('images/dark.jpeg', fit: BoxFit.cover),
          ),

          Column(
            children: [
              Expanded(
                child: BlocBuilder<Sendefirebasemasseg, Statesfirbase>(
                  builder: (context, state) {
                    if (state is SuccessSendeMessage) {
                      var messagelist = state.messageList;

                      if (messagelist.isEmpty) {
                        return const Center(
                          child: Text(
                            "لا توجد رسائل بعد",
                            style: TextStyle(color: Colors.white70),
                          ),
                        );
                      }

                      return ListView.builder(
                        reverse: true,
                        itemCount: messagelist.length,
                        itemBuilder: (context, index) {
                          // المقارنة بين الرقم المخزن في الرسالة ورقم المستخدم
                          bool isMine = messagelist[index].phon == phon;
                          return isMine
                              ? ChatBubble(messagelist[index]) // رسائل المستخدم
                              : ChatBubbleForFreinds(
                                  messagelist[index],
                                ); // رسائل الآخرين
                        },
                      );
                    }

                    if (state is Failure) {
                      return Center(
                        child: Text(
                          "حصل خطأ: ${state.error}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              BottomSendMessage(),
            ],
          ),
        ],
      ),
    );
  }
}
