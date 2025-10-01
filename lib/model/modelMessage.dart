import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp/context/context.dart';

class Modelmessage {
  final String text;
  final String id;
  final DateTime? createdAt;
  final String? phon;

  Modelmessage({
    required this.text,
    required this.id,
    this.createdAt,
    this.phon,
  });

  factory Modelmessage.fromJson(Map<String, dynamic> json) {
    return Modelmessage(
      text: json['message'] ?? '',
      id: json['id'] ?? '',
      phon: json['phon'], // لو مش موجود هتبقى null
      createdAt: (json[kCreatedAte] is Timestamp)
          ? (json[kCreatedAte] as Timestamp).toDate()
          : DateTime.tryParse(json[kCreatedAte]?.toString() ?? ''),
    );
  }
}
