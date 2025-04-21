import 'package:flutter/material.dart';
import 'package:lake_project/model/confirm_model.dart';
import 'package:lake_project/model/signin_users.dart';
import 'package:lake_project/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:lake_project/views/authentication/confirm_sign_up_screen.dart';
import 'package:lake_project/views/authentication/sign_in_screen.dart';

class AuthController {
  //Signup users function
  Future<void> signUpUsers({
    required String fullName,
    required String email,
    required String password,
    required BuildContext
    context, //This buildContext will tell whoever is calling this auth screen its context
  }) async {
    User user = User(fullName: fullName, email: email, password: password);

    http.Response response = await http.post(
      Uri.parse(
        "https://v35rdp3n4g.execute-api.eu-north-1.amazonaws.com/Sign-Up",
      ),
      body: user.toJson(),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ConfirmSignUpScreen(email: email);
          },
        ),
      );
    } else {
      print(response.body);
    }

    try {} catch (e) {
      print(e.toString());
    }
  }

  //Confirm users function
  Future<void> confirmSignUp({
    required String email,
    required String confirmationCode,
    required BuildContext context,
  }) async {
    final confirmModel = ConfirmModel(
      confirmationCode: confirmationCode,
      email: email,
    );

    http.Response response = await http.post(
      Uri.parse(
        "https://v35rdp3n4g.execute-api.eu-north-1.amazonaws.com/confirm-sign-up",
      ),
      body: confirmModel.toJson(),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return SignInScreen();
          },
        ),
      );
    } else {
      print(response.body);
    }

    try {} catch (e) {
      print(e.toString());
    }
  }

  //SignIn users function
  Future<void> signIn({required String email, required String password}) async {
    final signedusers = SigninUsers(email: email, password: password);

    http.Response response = await http.post(
      Uri.parse(
        "https://v35rdp3n4g.execute-api.eu-north-1.amazonaws.com/sign-in",
      ),

      body: signedusers.toJson(),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
    );

    if (response.statusCode == 200) {
      print("You are logged in");
    } else {
      print(response.body);
    }

    try {} catch (e) {
      print(e.toString());
    }
  }
}
