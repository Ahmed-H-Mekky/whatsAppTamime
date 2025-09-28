import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFromField extends StatelessWidget {
  CustomTextFromField({
    super.key,
    required this.hintText,
    this.validator,
    required this.controller, // ✅ نخزن الـ controller هنا
    this.textAlign = TextAlign.start, // ✅ لو عايز تتحكم بمحاذاة النص
    this.keyboardType = TextInputType.text, // ✅ نوع لوحة المفاتيح
  });

  final String hintText;
  Widget? prefixIcon;
  final String? Function(String?)? validator;
  final TextEditingController controller; // ✅ متغير يمسك الـ controller
  final TextAlign textAlign;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // ✅ ربط الـ controller
      validator: validator,
      textAlign: textAlign, // ✅ التحكم في محاذاة النص
      keyboardType: keyboardType, // ✅ نوع لوحة المفاتيح (نص/رقم/بريد)
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 1, 191, 8),
            width: 2.0,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 1, 191, 8),
            width: 1.5,
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 15, color: Colors.white),
        prefixIcon: prefixIcon,
      ),
    );
  }
}
