import 'package:basic_login_signup_firebase/screens/HomePage.dart';
import 'package:basic_login_signup_firebase/screens/LoginPage.dart';
import 'package:basic_login_signup_firebase/screens/SignupPage.dart';
import 'package:basic_login_signup_firebase/validators/validations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isLogin = true;

  String? emailErrorMessage = "";
  String? passwordErrorMessage = "";

  Future<void> signInWithEmailPassword() async {
    bool isValid = validations().validateEmail(_emailController.text) &&
        validations().validatePassword(_passwordController.text);
    bool emailNotEmpty = _emailController.text.isNotEmpty;
    bool passwordNotEmpty = _passwordController.text.isNotEmpty;

    if (!emailNotEmpty) {
      setState(() {
        emailErrorMessage = "Email is Empty";
      });
    } else if (!passwordNotEmpty) {
      setState(() {
        passwordErrorMessage = "Password is Empty";
      });
    } else {
      if (isValid) {
        try {
          emailErrorMessage = "";
          passwordErrorMessage = "";
          await auth().signInWithEmailPassword(
              email: _emailController.text, password: _passwordController.text);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } on FirebaseAuthException catch (e) {
          setState(() {
            emailErrorMessage = e.message;
          });
        }
      }
    }
  }

  Widget signupWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Login here',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30.0),
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: TextField(
            style: TextStyle(color: Colors.white),
            controller: _emailController,
            decoration: InputDecoration(
              errorText: emailErrorMessage,
              errorStyle: const TextStyle(
                color: Colors.white,
              ),
              hintText: 'Email Address',
              hintStyle: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: TextField(
            style: TextStyle(color: Colors.white),
            controller: _passwordController,
            decoration: InputDecoration(
              errorText: passwordErrorMessage,
              errorStyle: const TextStyle(
                color: Colors.white,
              ),
              hintText: 'Password',
              hintStyle: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
            obscureText: true,
          ),
        ),
        const SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            signInWithEmailPassword();
          },
          child: const Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignupPage()),
          ),
          child: const Text(
            'New Here ? Signup Now !',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: signupWidget(),
      ),
    );
  }
}
