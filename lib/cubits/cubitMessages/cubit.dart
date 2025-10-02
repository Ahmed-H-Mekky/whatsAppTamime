import 'package:flutter_bloc/flutter_bloc.dart';
import 'stat.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState.initial());

  void setName(String name) {
    emit(state.copyWith(name: name));
  }

  void setImage(String? path) {
    emit(state.copyWith(image: path));
  }

  void setPhone(String phone) {
    emit(state.copyWith(phone: phone));
  }

  void setUser({required String name, String? phone, String? image}) {
    emit(UserState(name: name, phone: phone ?? '', image: image));
  }
}
