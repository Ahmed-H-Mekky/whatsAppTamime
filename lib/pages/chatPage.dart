import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/cubits/cubitMessages/cubit.dart';
import 'package:whatsapp/cubits/cubitMessages/sendefirebasemasseg.dart';
import 'package:whatsapp/cubits/cubitMessages/stat.dart';
import 'package:whatsapp/cubits/cubitMessages/statesFirbase.dart';
import 'package:whatsapp/cubits/cubitRegister/LogInCubit.dart';
import 'package:whatsapp/widget/BottomSendMessage.dart';
import 'package:whatsapp/widget/chatBubble.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});
  static String id = '/chatHome';

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  @override
  Widget build(BuildContext context) {
    var phon = BlocProvider.of<CubitLogin>(context).userPhone;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: BlocBuilder<UserCubit, UserState>(
          builder: (context, userState) {
            String userName = userState.name.isNotEmpty
                ? userState.name
                : 'مستخدم';
            String? userImage = userState.image;

            return Row(
              children: [
                CircleAvatar(
                  backgroundImage: userImage != null
                      ? FileImage(File(userImage))
                      : null,
                  child: userImage == null ? const Icon(Icons.person) : null,
                ),
                const SizedBox(width: 15),
                Text(
                  userName,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            );
          },
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
                          bool isMine = messagelist[index].phon == phon;
                          return isMine
                              ? ChatBubble(messagelist[index])
                              : ChatBubbleForFreinds(messagelist[index]);
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
