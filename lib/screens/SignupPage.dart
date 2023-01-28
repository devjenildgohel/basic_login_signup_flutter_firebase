import 'package:basic_login_signup_firebase/screens/HomePage.dart';
import 'package:basic_login_signup_firebase/screens/LoginPage.dart';
import 'package:basic_login_signup_firebase/validators/validations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isLogin = true;

  String? emailErrorMessage = "";
  String? passwordErrorMessage = "";

  Future<void> signUpWithEmailPassword() async {
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
          await auth().signUpWithEmailPassword(
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
        Text(
          'Sign Up Here',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 30.0),
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: TextField(
            style: TextStyle(color: Colors.white),
            controller: _emailController,
            decoration: InputDecoration(
              errorText: emailErrorMessage,
              errorStyle: TextStyle(
                color: Colors.white,
              ),
              hintText: 'Enter Your email address',
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: TextField(
            style: TextStyle(color: Colors.white),
            controller: _passwordController,
            decoration: InputDecoration(
              errorText: passwordErrorMessage,
              errorStyle: TextStyle(
                color: Colors.white,
              ),
              hintText: 'Enter Your Password',
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
            obscureText: true,
          ),
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            signUpWithEmailPassword();
          },
          child: Text(
            'Signup',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          ),
          child: Text(
            'Already user ? Go TO Login !',
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
        decoration: BoxDecoration(
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
