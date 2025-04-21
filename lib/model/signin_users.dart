import 'dart:convert';

class SigninUsers {
  final String email;
  final String password;

  SigninUsers({required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return {'email': email, 'password': password};
  }

  factory SigninUsers.fromMap(Map<String, dynamic> map) {
    return SigninUsers(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SigninUsers.fromJson(String source) =>
      SigninUsers.fromMap(json.decode(source));
}
