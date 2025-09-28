import 'package:firebase_auth/firebase_auth.dart';

abstract class StateLogIn {}

class Initstate extends StateLogIn {}

class LoadingState extends StateLogIn {}

class VerifiedState extends StateLogIn {
  final User user;

  VerifiedState({required this.user});
}

class CodeSentState extends StateLogIn {}

class ErrorState extends StateLogIn {
  final String error;
  ErrorState({required this.error});
}
