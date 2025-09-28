// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:whatsapp/Server/uploadeCloudinary.dart';

class Pikeimage extends StatefulWidget {
  final void Function(File) onImageSelected;
  const Pikeimage({super.key, required this.onImageSelected});
  @override
  State<Pikeimage> createState() => _PikeimageState();
}

class _PikeimageState extends State<Pikeimage> {
  XFile? imagepiker;

  _pikeimage(ImageSource source) async {
    //هنا عملت منها ابوجكت
    final ImagePicker picker = ImagePicker();
    //هنا بعمل تهيئه
    imagepiker = await picker.pickImage(
      source: source,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (imagepiker == null) {
      return;
    } else {
      //بحولها الي صيغة فايل لتكون قابله للنسخ او العرض او الرفع
      File file = File(imagepiker!.path);
      //للرجوع للصفحه معتحميل الصوره
      widget.onImageSelected(
        file,
      ); // نبعث الصورة للصفحة ال عاوزاستخدم فيها الصوره

      // Cloudinary بعد اختيار الصورة نرفعها عل ال
      String? url = await UploadCloudinary.uploadImage(context, file);
      if (url != null) {
        //firebaseStore بحفظ االرابط عل  Cloudinary بعد ما برفع الرابط عل ال
        await UploadCloudinary.saveToFirebase(context, url);
      }

      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'صورة الملف الشخصي',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        centerTitle: true,

        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Align(
        alignment: Alignment.topRight,

        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  _pikeimage(ImageSource.camera);
                  if (mounted) Navigator.pop(context);
                },
                icon: Icon(Icons.camera_alt_outlined),

                label: Text('الكاميرا'),
              ),
              TextButton.icon(
                onPressed: () {
                  _pikeimage(ImageSource.gallery);
                },
                label: Text('المعرض'),
                icon: Icon(Icons.image),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
