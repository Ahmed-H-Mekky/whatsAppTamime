import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/cubits/cubitMessages/cubit.dart';
import 'package:whatsapp/cubits/cubitMessages/sendefirebasemasseg.dart';
import 'package:whatsapp/pages/chatePageHom.dart';
import 'package:whatsapp/widget/GestureDetectorBottom.dart';
import 'package:whatsapp/helps/snalBar/showSnakbar.dart';
import 'package:whatsapp/model/ShowDailog.dart';

class Uploadimage extends StatefulWidget {
  const Uploadimage({super.key});
  static String id = '/uploadImage';

  @override
  State<Uploadimage> createState() => _UploadimageState();
}

class _UploadimageState extends State<Uploadimage> {
  File? imageFile;
  final TextEditingController myController = TextEditingController();
  final int textLength = 18;

  int countString() => myController.text.trimLeft().length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('images/dark.jpeg', fit: BoxFit.cover),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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

                  // صورة البروفايل
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: imageFile != null
                              ? FileImage(imageFile!)
                              : null,
                          child: imageFile == null
                              ? Icon(
                                  Icons.person,
                                  size: 80,
                                  color: Colors.grey[600],
                                )
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
                                showDialogChooseImage(
                                  context,
                                  onImageSelected: (File file) {
                                    setState(() {
                                      imageFile = file;
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

                  // إدخال الاسم
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
                            prefixText: '${textLength - countString()} :',
                          ),
                          onChanged: (val) {
                            setState(() {
                              if (countString() >= textLength) {
                                showSnakBar(
                                  context,
                                  message: "وصلت للحد الأقصى",
                                );
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  GestureDetectorBottom(
                    text: 'التالي',
                    onTap: () {
                      if (countString() >= 3) {
                        // حفظ البيانات في Cubit
                        context.read<UserCubit>().setUser(
                          name: myController.text,
                          phone: '0123456789', // ضع رقم الهاتف الحقيقي
                          image: imageFile?.path,
                        );

                        // جلب الرسائل
                        BlocProvider.of<Sendefirebasemasseg>(
                          context,
                        ).getMessage();

                        // الانتقال إلى صفحة الدردشة
                        Navigator.pushNamed(context, Chatepagehom.id);
                      } else {
                        showSnakBar(context, message: "الاسم قصير جدًا");
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
