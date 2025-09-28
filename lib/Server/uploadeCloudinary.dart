import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/helps/snalBar/showSnakbar.dart';

class UploadCloudinary {
  static String uploadPreset = 'whatsTamime'; // اسم preset في Cloudinary
  static String cloudName = 'ddvhzbpxc'; // اسم Cloudinary account
  static Dio dio = Dio();
  // رفع الصورة إلى Cloudinary
  static Future<String?> uploadImage(
    BuildContext context,
    File imageFile,
  ) async {
    try {
      //بجهز السرفير للتخزين
      final url = "https://api.cloudinary.com/v1_1/$cloudName/image/upload";
      // بحول البيانات ال ماب حتي يتم تخزينها عل السيرفر
      final formData = FormData.fromMap({
        // بنشئ ملف متعدد الاجزاء يعني يقبل اي حاجه صوره نص فديو الخ
        'file': await MultipartFile.fromFile(imageFile.path),
        //اسم السيرفر ال هخزن عليه
        'upload_preset': uploadPreset,
      });

      final response = await dio.post(url, data: formData);

      if (response.statusCode == 200) {
        return response.data['url'];
      } else {
        showSnakBar(context, message: 'فشل رفع الصورة إلى Cloudinary');
      }
    } catch (error) {
      showSnakBar(context, message: 'خطأ: $error');
    }
    return null;
  }

  // حفظ الرابط في Firestore
  static Future<void> saveToFirebase(BuildContext context, String url) async {
    try {
      await FirebaseFirestore.instance.collection('image').add({
        'url': url,
        'timeSend': FieldValue.serverTimestamp(),
      });
      showSnakBar(context, message: 'تم رفع الصورة بنجاح');
    } catch (e) {
      showSnakBar(context, message: 'خطأ في Firebase: $e');
    }
  }
}
