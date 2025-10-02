import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logInState.dart';

class CubitLogin extends Cubit<StateLogIn> {
  CubitLogin() : super(Initstate());
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? _verificationId;
  String? userPhone;
  int? _resendToken;

  // إرسال كود التحقق وللتحقق من وجود الرقم قبل الإضافة
  Future<void> sendcode({required String phone, int? forceToken}) async {
    userPhone = phone;
    emit(LoadingState());

    try {
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

        codeSent: (String id, int? token) async {
          _verificationId = id;
          _resendToken = token;

          // التحقق من وجود الرقم في Firestore
          var usersRef = firestore.collection('users');
          var query = await usersRef.where('phone', isEqualTo: phone).get();

          if (query.docs.isEmpty) {
            await usersRef.add({'phone': phone});
          }

          emit(CodeSentState());
        },

        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  // التحقق من الكود
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
