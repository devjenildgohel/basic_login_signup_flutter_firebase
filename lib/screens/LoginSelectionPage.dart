import 'package:basic_login_signup_firebase/screens/LoginPage.dart';
import 'package:basic_login_signup_firebase/screens/PhoneSignInPage.dart';
import 'package:basic_login_signup_firebase/screens/SignupPage.dart';
import 'package:flutter/material.dart';


class LoginSelectionPage extends StatefulWidget {
  const LoginSelectionPage({super.key});

  @override
  _LoginSelectionPageState createState() => _LoginSelectionPageState();
}

Widget loginWithOtpWidget(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      const Text(
        'Select Login Process',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 30.0),
      ElevatedButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        ),
        child: const Text(
          'Login With Email',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: 10.0),
      ElevatedButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PhoneSignInPage()),
        ),
        child: const Text(
          'Login With Phone And OTP',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}

class _LoginSelectionPageState extends State<LoginSelectionPage> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: loginWithOtpWidget(context),
      ),
    );
  }
}
