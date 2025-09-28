import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp/context/context.dart';

class Modelmessage {
  final String message;
  final String id;
  final DateTime dateTime;

  Modelmessage({
    required this.message,
    required this.id,
    required this.dateTime,
  });

  // Factory لتحويل من Map (Firestore or JSON) لـ Modelmessage
  factory Modelmessage.fromJson(Map<String, dynamic> json) {
    return Modelmessage(
      message: json['message'],
      id: json['id'],
      dateTime: json[kCreatedAte] is Timestamp
          ? (json[kCreatedAte] as Timestamp).toDate()
          : DateTime.parse(json[kCreatedAte].toString()),
    );
  }
}
