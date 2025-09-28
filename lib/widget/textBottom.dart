import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/cubits/cubitRegister/LogInCubit.dart';
import 'package:whatsapp/helps/snalBar/showSnakbar.dart';

TextButton TextBorron(
  BuildContext context,
  String phone, {
  required int seconds,
  required Function startTimer,
}) {
  return TextButton.icon(
    icon: const Icon(Icons.refresh),
    label: Text(
      seconds > 0 ? "إعادة الإرسال بعد $seconds ثانية" : "إعادة إرسال الكود",
      style: TextStyle(color: Color.fromARGB(255, 1, 191, 8)),
    ),
    onPressed: seconds > 0
        ? null
        : () {
            context.read<CubitLogin>().sendcode(phone: phone);
            showSnakBar(context, message: "تم طلب إرسال الكود من جديد");
            startTimer();
          },
  );
}
