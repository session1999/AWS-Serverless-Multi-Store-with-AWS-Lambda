import 'dart:convert';

class User {
  final String fullName;
  final String email;
  final String password;

  User({required this.fullName, required this.email, required this.password});

  //Serialization is the process of converting an object (like a Dart class) into a format that can be easily stored or transmitted — usually JSON
  Map<String, dynamic> toMap() {
    return {'fullName': fullName, 'email': email, 'password': password};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
