// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:whatsapp/model/modelMessage.dart';

abstract class Statesfirbase {}

class InitialState extends Statesfirbase {}

class LoadingStat extends Statesfirbase {}

class SuccessSendeMessage extends Statesfirbase {
  List<Modelmessage> messageList;
  SuccessSendeMessage({required this.messageList});
}

class Failure extends Statesfirbase {
  final String error;

  Failure({required this.error});
}
