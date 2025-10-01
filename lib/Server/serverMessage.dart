import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp/model/modelMessage.dart';
import 'package:whatsapp/context/context.dart';

class Servermessage {
  static CollectionReference message = FirebaseFirestore.instance.collection(
    'message',
  );

  static Future<Modelmessage> firbaseChat({
    required String messagetext,
    required String id,
    required DateTime datetime,
    required String phon,
  }) async {
    // إضافة الرسالة لفايرستور
    var response = await message.add({
      'message': messagetext,
      'id': id,
      kCreatedAte: datetime,
      'phon': phon,
    });

    // إرجاع موديل من البيانات اللي حفظتها
    return Modelmessage.fromJson({
      'message': messagetext,
      'id': id,
      kCreatedAte: datetime.toString(),
      'docId': response.id, // id الخاص بالـ document
      'phon': phon,
    });
  }
}
