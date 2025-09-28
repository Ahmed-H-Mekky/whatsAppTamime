import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/cubits/cubitRegister/logInState.dart';

class CubitLogin extends Cubit<StateLogIn> {
  CubitLogin() : super(Initstate());
  final FirebaseAuth auth = FirebaseAuth.instance;

  String? _verificationId;
  // ignore: unused_field
  int? _resendToken;
  // الفنكشن المسؤولة عن إرسال كود التحقق  للمستخدم
  Future<void> sendcode({required String phone, int? forceToken}) async {
    emit(LoadingState());

    await auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 30),
      forceResendingToken: forceToken,

      verificationCompleted: (cred) async {
        final userCredential = await auth.signInWithCredential(cred);
        emit(VerifiedState(user: userCredential.user!));
      },

      verificationFailed: (e) {
        emit(ErrorState(error: e.toString()));
      },

      codeSent: (String id, int? token) {
        _verificationId = id;
        _resendToken = token;
        emit(CodeSentState());
      },

      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  //  الفنكشن المسؤولة عن التحقق من الكود الذي أدخله المستخدم وتسجيل الدخول
  Future<void> verifyCode({required String smsCode}) async {
    emit(LoadingState());
    if (_verificationId != null) {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );
      final userCredential = await auth.signInWithCredential(credential);
      emit(VerifiedState(user: userCredential.user!));
    } else {
      emit(ErrorState(error: "Verification ID is null"));
    }
  }
}
