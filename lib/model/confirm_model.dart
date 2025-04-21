import 'dart:convert';

class ConfirmModel {
  final String confirmationCode;
  final String email;

  ConfirmModel({required this.confirmationCode, required this.email});

  Map<String, dynamic> toMap() {
    return {'confirmationCode': confirmationCode, 'email': email};
  }

  factory ConfirmModel.fromMap(Map<String, dynamic> map) {
    return ConfirmModel(
      confirmationCode: map['confirmationCode'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfirmModel.fromJson(String source) =>
      ConfirmModel.fromMap(json.decode(source));
}
