class UserState {
  final String name;
  final String phone;
  final String? image;

  UserState({required this.name, required this.phone, this.image});

  factory UserState.initial() {
    return UserState(name: '', phone: '', image: null);
  }

  UserState copyWith({String? name, String? phone, String? image}) {
    return UserState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      image: image ?? this.image,
    );
  }
}
