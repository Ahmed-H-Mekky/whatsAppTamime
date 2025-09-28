import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/cubits/cubitMessages/sendeFirebaseMasseg.dart';
import 'package:whatsapp/cubits/cubitRegister/LogInCubit.dart';
import 'package:whatsapp/firebase_options.dart';
import 'package:whatsapp/pages/otp.dart';
import 'package:whatsapp/pages/singInPage.dart';
import 'package:whatsapp/pages/chatPage.dart';
import 'package:whatsapp/pages/uploadImage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseAuth.instance.setSettings(
  //   appVerificationDisabledForTesting: true,
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CubitLogin()),
        BlocProvider(create: (context) => Sendefirebasemasseg()), // 👈 مضاف هنا
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Golden Chat',
        theme: ThemeData.dark(),
        // theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: SingIn(), // أول صفحة
        routes: {
          OtpPage.id: (context) => OtpPage(),
          ChatHome.id: (context) => ChatHome(),
          Uploadimage.id: (context) => Uploadimage(),
        },
      ),
    );
  }
}
