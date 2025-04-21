import 'package:flutter/material.dart';
import 'package:lake_project/controller/auth_controller.dart';
import 'package:lake_project/views/authentication/sign_in_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController =
        AuthController(); //Object of the authcontroller to validate the form
    final GlobalKey<FormState> formKey =
        GlobalKey(); // auth global key to  validate each formfield
    late String
    fullName; // these are the model variables in in User class... using late because we are expecting
    late String email;
    late String password;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),

              TextFormField(
                validator: (value) {
                  //validator this is because of the _formKey variable to validate the input
                  if (value!.isNotEmpty) {
                    return null;
                  } else {
                    return "Please fill in fullName";
                  }
                },
                onChanged: (value) {
                  // this is to monitor the form when anything changes so it captures it
                  fullName = value;
                },
                decoration: InputDecoration(
                  labelText: "Enter your full names",
                  hintText: "full names",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 20),

              TextFormField(
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  } else {
                    return "Please fill in email";
                  }
                },

                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  prefixIconColor: Colors.pinkAccent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              SizedBox(height: 20),

              TextFormField(
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  } else {
                    return "Please fill in pass";
                  }
                },
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  prefixIconColor: Colors.pinkAccent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 20),

              InkWell(
                // Inkwell is used within a container to make it tap-able
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    // to validate all input
                    authController.signUpUsers(
                      fullName: fullName,
                      email: email,
                      password: password,
                      context: context,
                    );
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      "Signup",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Have an account?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignInScreen();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Sign-in",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
