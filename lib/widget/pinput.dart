import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:whatsapp/cubits/cubitRegister/LogInCubit.dart';

class CustomrPinput extends StatelessWidget {
  const CustomrPinput({super.key, required this.codeController});

  final TextEditingController codeController;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
    );
    return Pinput(
      length: 6, // عدد المربعا
      controller: codeController,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          border: Border.all(color: Colors.green, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      submittedPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      onCompleted: (pin) {
        // عند اكتمال إدخال الكود، نستدعي الدالة للتحقق
        context.read<CubitLogin>().verifyCode(smsCode: pin);
      },
    );
  }
}
