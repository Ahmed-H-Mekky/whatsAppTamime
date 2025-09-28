import 'dart:async'; // ✅ للتايمر
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/cubits/cubitRegister/LogInCubit.dart';
import 'package:whatsapp/cubits/cubitRegister/logInState.dart';
import 'package:whatsapp/helps/snalBar/showSnakbar.dart';
import 'package:whatsapp/pages/uploadImage.dart';
import 'package:whatsapp/widget/pinput.dart';
import 'package:whatsapp/widget/textBottom.dart';

class OtpPage extends StatefulWidget {
  static const String id = "otp_page";

  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController codeController = TextEditingController();
  int seconds = 30;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    seconds = 30;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds == 0) {
        t.cancel();
      } else {
        setState(() => seconds--);
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phone = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: const Text("ادخل الكود")),
      body: BlocConsumer<CubitLogin, StateLogIn>(
        listener: (context, state) {
          if (state is VerifiedState) {
            showSnakBar(context, message: "تم تسجيل الدخول");
            Navigator.pushReplacementNamed(context, Uploadimage.id);
          } else if (state is ErrorState) {
            showSnakBar(context, message: state.error);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    //مع الكولم او الرو لجعل  العناصر في المنتصف align بستخدم ال
                    alignment: Alignment.center,
                    child: CustomrPinput(codeController: codeController),
                  ),

                  const SizedBox(height: 20),

                  //  إعادة إرسال الكود مع العداد
                  TextBorron(
                    context,
                    phone,
                    seconds: seconds,
                    startTimer: startTimer,
                  ),
                ],
              ),
              //  مؤشّر التحميل
              if (state is LoadingState)
                Center(
                  child: Container(
                    width: 370,
                    height: 55,
                    color: Colors.grey.withValues(alpha: 0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('......جاري التحقق'),
                            SizedBox(width: 12),
                            CircularProgressIndicator(
                              color: Colors.greenAccent,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
