import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/contextRoutPage/routPage.dart';
import 'package:whatsapp/cubits/cubitMessages/sendeFirebaseMasseg.dart';
import 'package:whatsapp/helps/snalBar/showSnakbar.dart';
import 'package:whatsapp/model/ShowDailog.dart';
import 'package:whatsapp/widget/GestureDetectorBottom.dart';

class Uploadimage extends StatefulWidget {
  const Uploadimage({super.key});
  static String id = kUploadimage;

  @override
  State<Uploadimage> createState() => _UploadimageState();
}

class _UploadimageState extends State<Uploadimage> {
  File? imageFil;
  int count = 0;
  final int textLength = 18;
  final TextEditingController myController = TextEditingController();

  int countString(TextEditingController controller) {
    count = controller.text.trimLeft().length;
    if (count == textLength) count--;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text(
              'المعلومات الشخصيه',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'الرجاء ادخل اسمك وتحديد الصوره الشخصيه - الصوره غير إلزاميه',
              style: TextStyle(
                color: Colors.grey[200],
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            //  صورة البروفايل
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: imageFil != null
                        //FileImage=> يأخذ ملف الصورة ويحوّله إلى صورة يمكن عرضها في الواجهة
                        ? FileImage(imageFil!)
                        : null,
                    child: imageFil == null
                        ? Icon(Icons.person, size: 80, color: Colors.grey[600])
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          // _pickProfileImage, // هنا فتح اختيار الصورة

                          showDialogChooseImage(
                            context,
                            onImageSelected: (File file) {
                              setState(() {
                                imageFil = file;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),

            //  إدخال الاسم
            Row(
              children: [
                const Text('🙂', style: TextStyle(fontSize: 25)),
                const SizedBox(width: 5),
                Expanded(
                  child: TextField(
                    maxLength: textLength,
                    controller: myController,
                    decoration: InputDecoration(
                      counterText: "",
                      hintText: "ادخل اسمك",
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.greenAccent,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.greenAccent,
                          width: 2.0,
                        ),
                      ),
                      prefixText: '${textLength - count} :',
                    ),
                    onChanged: (val) {
                      setState(() {
                        if (countString(myController) >= textLength) {
                          showSnakBar(context, message: "وصلت للحد الأقصى");
                        }
                      });
                    },
                  ),
                ),
              ],
            ),

            const Spacer(),

            GestureDetectorBottom(
              onTap: () {
                if (countString(myController) >= 3) {
                  //ببعت الصوره والاسم الي الفيربيز تتخزن
                  FirebaseFirestore.instance.collection('user').add({
                    'MyName': myController.text,
                    'Image': imageFil?.path,
                  });
                  BlocProvider.of<Sendefirebasemasseg>(context).getMessage();
                  Navigator.pushNamed(
                    context,
                    kChatHome,
                    arguments: {
                      'image': imageFil?.path,
                      'myName': myController.text,
                    },
                  );
                }
              },
              text: 'التالي',
            ),
          ],
        ),
      ),
    );
  }
}
