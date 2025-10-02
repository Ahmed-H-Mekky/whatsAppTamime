import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/cubits/cubitMessages/cubit.dart';
import 'package:whatsapp/cubits/cubitMessages/sendefirebasemasseg.dart';
import 'package:whatsapp/cubits/cubitRegister/LogInCubit.dart';
import 'package:whatsapp/firebase_options.dart';
import 'package:whatsapp/pages/chatePageHom.dart';
import 'package:whatsapp/pages/otp.dart';
import 'package:whatsapp/pages/singInPage.dart';
import 'package:whatsapp/pages/chatPage.dart';
import 'package:whatsapp/pages/uploadImage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CubitLogin()),
        BlocProvider(create: (context) => Sendefirebasemasseg()..getMessage()),
        BlocProvider(create: (context) => UserCubit()), // 👈 أضفنا UserCubit
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Golden Chat',
        theme: ThemeData.dark(),
        home: SingIn(),
        routes: {
          OtpPage.id: (context) => OtpPage(),
          ChatHome.id: (context) => ChatHome(),
          Uploadimage.id: (context) => Uploadimage(),
          Chatepagehom.id: (context) => Chatepagehom(),
        },
      ),
    );
  }
}
