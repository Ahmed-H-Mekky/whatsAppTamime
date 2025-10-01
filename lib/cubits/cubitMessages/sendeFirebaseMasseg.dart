import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/model/modelMessage.dart';
import 'package:whatsapp/Server/serverMessage.dart';
import 'package:whatsapp/context/context.dart';
import 'package:whatsapp/cubits/cubitMessages/statesFirbase.dart';

class Sendefirebasemasseg extends Cubit<Statesfirbase> {
  Sendefirebasemasseg() : super(InitialState());
  List<Modelmessage> messageList = [];
  // إرسال رسالة
  Future<void> sendMessage({
    required String messagetext,
    required String id,
    required DateTime datetime,
    required String phon,
  }) async {
    emit(LoadingStat());
    try {
      Servermessage.firbaseChat(
        phon: phon,
        messagetext: messagetext,
        id: id,
        datetime: datetime,
      );
    } catch (e) {
      emit(Failure(error: e.toString()));
    }
  }

  void getMessage() {
    Servermessage.message
        .orderBy(kCreatedAte, descending: true)
        .snapshots()
        .listen((event) {
          messageList = event.docs.map((e) {
            return Modelmessage.fromJson(e.data() as Map<String, dynamic>);
          }).toList();
          emit(SuccessSendeMessage(messageList: messageList));
        });
  }
}
