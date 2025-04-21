import 'package:flutter/material.dart';
import 'package:lake_project/controller/auth_controller.dart';

class ConfirmSignUpScreen extends StatelessWidget {
  final AuthController _authController = AuthController();
  final String email;
  late String confirmationCode;

  ConfirmSignUpScreen({super.key, required this.email});
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Text("Email sent to  $email"),
            TextFormField(
              onChanged: (value) {
                confirmationCode = value;
              },
              validator: (value) {
                if (value!.isNotEmpty) {
                  return null;
                } else {
                  return "Enter opt code";
                }
              },
              decoration: InputDecoration(labelText: "Enter Opt"),
            ),

            ElevatedButton(
              onPressed: () {
                _authController.confirmSignUp(
                  email: email,
                  confirmationCode: confirmationCode,
                  context: context,
                );
              },
              child: Text("confirm"),
            ),
          ],
        ),
      ),
    );
  }
}
