import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp/Server/modelPhon.dart';

class SearchFirebase {
  var phone = FirebaseFirestore.instance.collection('user');
  Future<Modelphon> searchPonNem({
    required String myphone,
    required String otherPon,
  }) async {
    // ignore: unused_local_variable
    var rep = await phone.add({'myphone': myphone, 'otherphone': otherPon});
    return Modelphon.fromjson({'myphone': myphone, 'otherphone': otherPon});
  }
}
