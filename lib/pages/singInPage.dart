import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/cubits/cubitRegister/LogInCubit.dart';
import 'package:whatsapp/cubits/cubitRegister/logInState.dart';
import 'package:whatsapp/pages/otp.dart';
import 'package:whatsapp/widget/dropBottomFrom.dart';
import 'package:whatsapp/widget/textfromfield.dart';
import 'package:whatsapp/widget/GestureDetectorBottom.dart';
import 'package:whatsapp/helps/snalBar/showSnakbar.dart';

class SingIn extends StatefulWidget {
  const SingIn({super.key});

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  final GlobalKey<FormState> keyFrom = GlobalKey();
  final TextEditingController phoneController = TextEditingController();

  String selectedCountry = "مصر";
  String selectedCountryCode = "+20";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "تسجيل الدخول",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<CubitLogin, StateLogIn>(
        listener: (context, state) {
          if (state is CodeSentState) {
            showSnakBar(context, message: 'تم ارسال الكود');

            Navigator.pushNamed(
              context,
              OtpPage.id,
              arguments: "$selectedCountryCode${phoneController.text.trim()}",
            );
          } else if (state is ErrorState) {
            showSnakBar(context, message: state.error);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Form(
                  key: keyFrom,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              const Text(
                                'أدخل رقم هاتفك',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'سيحتاج واتساب تميم إلى التحقق من رقم هاتفك. قد تسري عليك رسوم تفرضها شركة الاتصالات',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white70,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 30),

                              // اختيار الدولة
                              SizedBox(
                                height: 45,
                                width: double.infinity,
                                child: Dropbottomfrom(
                                  selectedCountry: selectedCountry,
                                  selectedCountryCode: selectedCountryCode,
                                  onChanged: (country, code) {
                                    setState(() {
                                      selectedCountry = country;
                                      selectedCountryCode = code;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),

                              // رقم الهاتف
                              Row(
                                children: [
                                  Container(
                                    height: 45,
                                    width: 70,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.greenAccent,
                                          width: 0.7,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      selectedCountryCode,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: SizedBox(
                                      height: 45,
                                      child: CustomTextFromField(
                                        hintText: 'ادخل رقم الهاتف',
                                        controller: phoneController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'أدخل رقم الهاتف';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (state is LoadingState)
                Container(
                  color: Colors.black.withOpacity(0.7),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.greenAccent,
                            strokeWidth: 2,
                          ),
                          SizedBox(width: 12),
                          Text(
                            '......جاري التحقق',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GestureDetectorBottom(
          onTap: () {
            if (keyFrom.currentState!.validate()) {
              BlocProvider.of<CubitLogin>(context).sendcode(
                phone: "$selectedCountryCode${phoneController.text.trim()}",
              );
            }
          },
          text: 'التالي',
        ),
      ),
    );
  }
}
